import 'package:flutter/material.dart';
import 'package:tencent_map/src/model/t_lat_lng.dart';

class TPolylineOption {
  TPolylineOption(
    this.latLng, {
    this.color,
    this.lineCap,
    this.width,
    this.borderColor,
    this.borderWidth,
  });

  final List<TLatLng> latLng;
  final Color? color;
  final bool? lineCap;
  final double? width;
  final Color? borderColor;
  final double? borderWidth;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'latLng': latLng.map((e) => e.toJson()).toList(),
      'color': color?.value,
      'lineCap': lineCap,
      'width': width,
      'borderColor': borderColor?.value,
      'borderWidth': borderWidth,
    };
  }
}
