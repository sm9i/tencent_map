import 'package:flutter/material.dart';
import 'package:tencent_map/src/overlayer/t_overlayer.dart';

class TPolyLine extends TOverLayer {
  TPolyLine(
    String id, {
    ValueChanged<String>? onRemove,
    ValueChanged<TPolyLine>? onTap,
  }) : super(id, onRemove, (value) => onTap?.call(value as TPolyLine));
}
