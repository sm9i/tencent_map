import 'dart:async';

import 'package:flutter/services.dart';
import 'package:tencent_map/src/model/t_convert.dart';
import 'package:tencent_map/src/model/t_result.dart';
import 'package:tencent_map/src/overlayer/manager/t_overlayer_manager.dart';
import 'package:tencent_map/src/overlayer/t_overlayer.dart';

class TOverlayerManagerImpl extends TOverLayerManager {
  TOverlayerManagerImpl(int viewId) : this._methodChannel = MethodChannel('t_map_view_over_$viewId') {
    _listner = EventChannel('t_map_view_over_event_$viewId').receiveBroadcastStream().map((event) => asT<String>(event)).listen(onTapListener);
  }

  final MethodChannel _methodChannel;

  final List<TOverLayer> overlayers = <TOverLayer>[];

  StreamSubscription<String?>? _listner;

  @override
  void addOverLayer(TOverLayer overLayer) => overlayers.add(overLayer);

  @override
  Future<bool> removeOverLayer(String overId) {
    return _methodChannel.invokeMethod('over#remove', <String, dynamic>{
      'overId': overId,
    }).then((value) {
      final res = ChannelResut.fromJson(value);
      if (res.success) {
        overlayers.removeWhere((element) => element.id == overId);
        return res.success;
      } else {
        return false;
      }
    }).catchError((dynamic e) {
      return false;
    });
  }

  @override
  void removeAll() => overlayers.clear();

  @override
  void onTapListener(String? overId) {
    if (overId == null) {
      return;
    }
    TOverLayer? overLayer;
    for (final value in overlayers) {
      if (value.id == overId) {
        overLayer = value;
      }
    }
    if (overLayer != null) {
      overLayer.onTap?.call(overLayer);
    }
  }

  @override
  void dispose() {
    _listner?.cancel();
  }
}
