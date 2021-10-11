import 'package:flutter/material.dart';
import 'package:tencent_map/tencent_map.dart';

class SetTypeWidget extends StatelessWidget {
  const SetTypeWidget({Key? key, required this.onTap}) : super(key: key);
  final ValueChanged<TMapType> onTap;

  @override
  Widget build(BuildContext context) {
    return mapButton(
      '设置地图类型',
      ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          button('NONE', () => onTap.call(TMapType.NONE)),
          button('NORMAL', () => onTap.call(TMapType.NORMAL)),
          button('DARK', () => onTap.call(TMapType.DARK)),
          button('SATELLITE', () => onTap.call(TMapType.SATELLITE)),
          button('TRAFFIC_NAVI', () => onTap.call(TMapType.TRAFFIC_NAVI)),
          button('TRAFFIC_NIGHT', () => onTap.call(TMapType.TRAFFIC_NIGHT)),
          button('NIGHT', () => onTap.call(TMapType.NIGHT)),
          button('NAVI', () => onTap.call(TMapType.NAVI)),
        ],
      ),
    );
  }
}

Widget button(String title, VoidCallback onTap) {
  return TextButton(onPressed: onTap, child: Text(title));
}

Container mapButton(String title, Widget child) {
  return Container(
    height: 40,
    padding: EdgeInsets.symmetric(horizontal: 10),
    alignment: Alignment.center,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(title),
        Expanded(child: child),
      ],
    ),
  );
}
