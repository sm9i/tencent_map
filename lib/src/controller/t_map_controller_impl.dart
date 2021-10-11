import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tencent_map/src/model/t_camera_change.dart';
import 'package:tencent_map/src/model/t_camera_postion.dart';
import 'package:tencent_map/src/model/t_lat_lng.dart';
import 'package:tencent_map/src/model/t_result.dart';
import 'package:tencent_map/src/overlayer/manager/t_overlayer_manager_impl.dart';
import 'package:tencent_map/src/overlayer/option/t_polyline_option.dart';
import 'package:tencent_map/src/overlayer/option/t_over_option.dart';
import 'package:tencent_map/src/overlayer/option/t_over_option_type.dart';
import 'package:tencent_map/src/overlayer/t_marker.dart';
import 'package:tencent_map/src/overlayer/manager/t_overlayer_manager.dart';
import 'package:tencent_map/src/overlayer/t_polyline.dart';

import '../../tencent_map.dart';

class TMapControllerImpl extends TMapController {
  TMapControllerImpl(int viewId)
      : _channel = MethodChannel('t_map_view_$viewId'),
        _eventChannel = EventChannel('t_map_view_change_event_$viewId'),
        _overlayerManager = TOverlayerManagerImpl(viewId);

  final MethodChannel _channel;

  final EventChannel _eventChannel;
  final TOverLayerManager _overlayerManager;

  List<StreamSubscription> _changeListener = <StreamSubscription>[];

  @override
  void dispose() {
    _overlayerManager.dispose();
    _changeListener.forEach((element) => element.cancel());
  }

  @override
  void setMapType(TMapType type) {
    _channel.invokeMethod(
      "map#setMapType",
      type.toJson(),
    );
  }

  @override
  void setMyLocation(bool show) {
    _channel.invokeMethod(
      "map#setShowMyLocation",
      <String, dynamic>{"enable": show},
    );
  }

  @override
  void moveCamera(TLatLng latLng, {double? zoom}) => _moveCamera(latLng, zoom: zoom);

  @override
  void animCamera(TLatLng latLng, {double? zoom, int? duration}) => _moveCamera(latLng, zoom: zoom, isAnim: true, duration: duration);

  ///
  void _moveCamera(
    TLatLng latLng, {
    double? zoom,
    bool isAnim = false,
    int? duration,
  }) {
    _channel.invokeMethod(
      "map#moveCamera",
      <String, dynamic>{
        ...latLng.toJson(),
        if (zoom != null) "zoom": zoom,
        if (isAnim) "anim": true,
        if (isAnim) "duration": duration ?? 1000,
      },
    );
  }

  @override
  Future<void> removeAllOverLayer() async {
    await _channel.invokeMethod("map#removeAllOverLayer");
    _overlayerManager.removeAll();
  }

  @override
  void addChangeListener(ValueChanged<TCameraChange> onMapChange) {
    _changeListener.add(_eventChannel.receiveBroadcastStream().listen((event) {
      onMapChange(TCameraChange.fromJson(Map<dynamic, dynamic>.of(event)));
    }));
  }

  @override
  Future<TCameraPostion?> get cameraPostion async {
    final res = await _channel.invokeMethod("map#getCameraPosition");
    if (res['success'] != null && res['success']) {
      return TCameraPostion.fromJson(Map<dynamic, dynamic>.of(res['data']));
    } else {
      return null;
    }
  }

  @override
  Future<Uint8List?> getSnapshot() async {
    final res = await _channel.invokeMethod('map#getSnapshot');
    if (res != null) {
      return res as Uint8List;
    }
    // final channelRes = ChannelResut<Uint8List>.fromJson(res, (data) => data as Uint8List);
    // if (channelRes.success && channelRes.data != null) {
    //   return channelRes.data;
    // }

    return null;
  }

  @override
  Future<TMarker?> addMarker(TMarkerOption markerOptions, {ValueChanged<TMarker>? onTap}) async {
    final TOverOption option = TOverOption(TOverOptionType.marker, markerOptions.toJson());

    final String? res = await _addOverLayer(option);

    if (res != null) {
      final marker = TMarker(
        res,
        onRemove: _overlayerManager.removeOverLayer,
        onTap: onTap,
      );
      _overlayerManager.addOverLayer(marker);
      return marker;
    }
    return null;
  }

  @override
  Future<TPolyLine?> addPolyline(TPolylineOption polyline, {ValueChanged<TPolyLine>? onTap}) async {
    final TOverOption option = TOverOption(TOverOptionType.polyline, polyline.toJson());

    final String? res = await _addOverLayer(option);
    if (res != null) {
      final polyline = TPolyLine(
        res,
        onRemove: _overlayerManager.removeOverLayer,
        onTap: onTap,
      );
      _overlayerManager.addOverLayer(polyline);
      return polyline;
    }
    return null;
  }

  Future<String?> _addOverLayer(TOverOption option) async {
    return _channel.invokeMethod("map#addOverLayer", option.toJson()).then((res) {
      final channelResult = ChannelResut<String>.fromJson(Map<dynamic, dynamic>.of(res), parse: (s) => s as String);
      if (channelResult.success) {
        return channelResult.data;
      } else {
        return null;
      }
    }).catchError((dynamic e) {
      return null;
    });
  }
}
