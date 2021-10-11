import 'package:flutter/cupertino.dart';
import 'package:tencent_map/src/overlayer/option/t_over_option_type.dart';
import 'package:tencent_map/src/overlayer/t_overlayer.dart';

class TOverOption {
  TOverOption(this.type, this.data);

  final TOverOptionType type;
  final Map<String, dynamic> data;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      ...type.toJson(),
      'data': data,
    };
  }
}
