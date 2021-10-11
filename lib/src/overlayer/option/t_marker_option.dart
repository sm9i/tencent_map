import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:tencent_map/src/model/t_lat_lng.dart';
import 'package:tencent_map/src/util/screenshot.dart';

class TMarkerOption {
  TMarkerOption(
    this.latLng, {
    this.icon,
    this.anchor,
    this.alpha,
    this.flat,
    this.rotation,
    this.clockwise,
    this.level,
    this.zIndex,
    this.visible,
    this.draggable,
    this.fastload,
    this.infoWindowEnable,
    this.infoWindowArch,
    this.infoWindowOffset,
    this.viewInfoWindow,
    this.title,
    this.snippet,
    this.indoorInfo,
  });

  ///设置 样式图标
  Future<void> setIconByWidget(Widget widget) async {
    icon = await createImageFromWidget(widget);
  }

  ///指定经纬度坐标，必填参数
  final TLatLng latLng;

  ///点图标样式，默认为系统图标
  Uint8List? icon;

  ///锚点，默认为(0.5,0.5)为图标中心，该属性影响Marker的位置、旋转、变形动画等操作
  final Offset? anchor;

  ///标注的透明度 默认1
  final double? alpha;

  ///是不是3D标注，3D标注会随着地图倾斜面倾斜
  final bool? flat;

  ///旋转角度 默认0
  final double? rotation;

  ///旋转方向是否顺时针，默认true为顺时针
  final bool? clockwise;

  ///图层级别， 0, 1, 2
  final int? level;

  ///相同显示Level level(int) 的Marker的堆叠顺序，相同显示level，zIndex越大越靠上显示 level优先级大于zIndex
  final double? zIndex;

  ///标注是否可见 默认可见
  final bool? visible;

  ///是否支持拖拽，默认false
  final bool? draggable;

  ///允许快速加载模式，默认true，影响icon的更新性能，建议在频繁更新icon的情况关闭此模式
  final bool? fastload;

  ///是否开启InfoWindow，默认true为开启
  final bool? infoWindowEnable;

  ///InfoWindow的锚点，默认为(0.5,1)为底边中心点
  final Offset? infoWindowArch;

  ///InfoWindow的偏移量
  final Offset? infoWindowOffset;

  ///InfoWindow类型为View，默认为false
  final bool? viewInfoWindow;

  ///默认InfoWindow的标题
  final String? title;

  ///默认InfoWindow的描述
  final String? snippet;

  ///关联室内建筑，将Marker显示在室内楼层内
  final dynamic indoorInfo;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      ...latLng.toJson(),
      if (icon != null) "icon": icon,
      if (anchor != null)
        "anchor": <String, dynamic>{
          "anchorU": anchor!.dx,
          "anchorV": anchor!.dy,
        },
      if (alpha != null) "alpha": alpha,
      if (flat != null) "flat": flat,
      if (rotation != null) "rotation": rotation,
      if (clockwise != null) "clockwise": clockwise,
      if (level != null) "level": level,
      if (zIndex != null) "zIndex": zIndex,
      if (visible != null) "visible": visible,
      if (draggable != null) "draggable": draggable,
      if (fastload != null) "fastload": fastload,
      if (infoWindowEnable != null) "infoWindowEnable": infoWindowEnable,
      if (infoWindowArch != null)
        "infoWindowArch": <String, dynamic>{
          "infoWindowArchU": infoWindowArch!.dx,
          "infoWindowArchV": infoWindowArch!.dy,
        },
      if (infoWindowOffset != null)
        "infoWindowOffset": <String, dynamic>{
          "infoWindowOffsetU": infoWindowOffset!.dx,
          "infoWindowOffsetV": infoWindowOffset!.dy,
        },
      if (viewInfoWindow != null) "viewInfoWindow": viewInfoWindow,
      if (title != null) "title": title,
      if (snippet != null) "snippet": snippet,
      if (indoorInfo != null) "indoorInfo": indoorInfo,
    };
  }
}
