import 'package:flutter/material.dart';
import 'package:tencent_map/src/overlayer/option/t_marker_option.dart';
import 'package:tencent_map/src/overlayer/t_overlayer.dart';

class TMarker extends TOverLayer {
  TMarker(
    String id, {
    ValueChanged<String>? onRemove,
    ValueChanged<TMarker>? onTap,
  }) : super(id, onRemove, (value) => onTap?.call(value as TMarker));
}
