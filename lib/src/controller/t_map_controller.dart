import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:tencent_map/src/model/t_camera_change.dart';
import 'package:tencent_map/src/model/t_camera_postion.dart';
import 'package:tencent_map/src/model/t_lat_lng.dart';
import 'package:tencent_map/src/model/t_map_type.dart';
import 'package:tencent_map/src/overlayer/option/t_marker_option.dart';
import 'package:tencent_map/src/overlayer/option/t_polyline_option.dart';
import 'package:tencent_map/src/overlayer/t_marker.dart';
import 'package:tencent_map/src/overlayer/t_polyline.dart';

abstract class TMapController {
  ///设置地图类型
  void setMapType(TMapType type);

  ///设置我的位置可见
  void setMyLocation(bool show);

  ///移动地图中心
  void moveCamera(TLatLng latLng, {double? zoom});

  ///动画移动地图中心
  void animCamera(TLatLng latLng, {double? zoom, int? duration});

  ///添加地图移动监听
  void addChangeListener(ValueChanged<TCameraChange> onMapChange);

  ///添加标记
  Future<TMarker?> addMarker(TMarkerOption marker, {ValueChanged<TMarker>? onTap});

  ///添加线条
  Future<TPolyLine?> addPolyline(TPolylineOption polyline,{ValueChanged<TPolyLine>? onTap});

  ///获取当前地图中心
  Future<TCameraPostion?> get cameraPostion;

  ///截图
  Future<Uint8List?> getSnapshot();

  ///删除所有标记
  void removeAllOverLayer();

  void dispose();
}
