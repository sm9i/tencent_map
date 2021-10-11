import 'package:flutter/cupertino.dart';

class TMapType {
  const TMapType._(this.value);
  ///地图默认类型
  static const NONE = TMapType._(-1);

  ///普通地图
  static const NORMAL = TMapType._(1000);

  ///暗色模式
  static const DARK = TMapType._(1008);

  ///卫星图
  static const SATELLITE = TMapType._(1011);

  ///导航白天+路况 用于腾讯导航sdk
  static const TRAFFIC_NAVI = TMapType._(1009);

  ///导航夜间+路况 用户腾讯导航sdk
  static const TRAFFIC_NIGHT = TMapType._(1010);

  ///夜间模式
  static const NIGHT = TMapType._(1013);

  ///导航模式
  static const NAVI = TMapType._(1012);



  final int value;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'type': value};
  }
}
