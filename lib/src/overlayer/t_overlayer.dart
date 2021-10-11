import 'package:flutter/material.dart';
import 'package:tencent_map/src/overlayer/t_marker.dart';

abstract class TOverLayer {
  TOverLayer(this.id, this.onRemove, this.onTap);

  void remove() => onRemove?.call(id);
  final ValueChanged<TOverLayer>? onTap;
  final ValueChanged<String>? onRemove;

  final String id;

}
