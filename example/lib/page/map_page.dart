import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tencent_map/tencent_map.dart';
import 'package:tencent_map_example/page/snapshot_page.dart';
import 'package:tencent_map_example/widget/button.dart';

class MapViewPage extends StatefulWidget {
  const MapViewPage({Key? key}) : super(key: key);

  @override
  _MapViewPageState createState() => _MapViewPageState();
}

class _MapViewPageState extends State<MapViewPage> {
  TMapController? controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: TMapWidget(
              onCreate: (TMapController value) {
                controller = value;
              },
              setting: TUiSetting(
                scaleViewEnabled: false,
              ),
            ),
          ),
          Expanded(
            child: Builder(builder: (context) {
              return ListView(
                children: <Widget>[
                  SetTypeWidget(onTap: (type) => controller?.setMapType(type)),
                  button('enable my location', () => controller?.setMyLocation(true)),
                  button(
                    'move camera',
                    () => controller?.moveCamera(TLatLng(39.963175, 116.431865), zoom: 15),
                  ),
                  button(
                    'move camera by anim',
                    () => controller?.animCamera(
                      TLatLng(39.963175, 116.431865),
                      zoom: 15,
                      duration: 500,
                    ),
                  ),
                  button(
                    'add marker',
                    () async {
                      // final assets = await rootBundle.load("assets/rmny.png");
                      final marker = TMarkerOption(
                        rLatLng(),
                        anchor: Offset(0.5, 1),
                        // icon: assets.buffer.asUint8List(),
                      );
                      await marker.setIconByWidget(Icon(
                        Icons.home,
                        color: Colors.orange,
                        size: 30,
                      ));
                      controller?.addMarker(marker, onTap: (marker) {
                        marker.remove();
                      });
                    },
                  ),
                  button(
                    'add polyline',
                    () async {
                      controller?.addPolyline(
                          TPolylineOption(
                            [
                              rLatLng(),
                              rLatLng(),
                              rLatLng(),
                              rLatLng(),
                              rLatLng(),
                            ],
                            color: Colors.orange,
                            lineCap: true,
                            width: 50,
                            borderColor: Colors.green,
                            borderWidth: 5,
                          ), onTap: (polyline) {
                        polyline.remove();
                      });
                    },
                  ),
                  button(
                    'remove all remark ',
                    () async {
                      controller?.removeAllOverLayer();
                    },
                  ),
                  button(
                    'add change listener',
                    () async {
                      controller?.addChangeListener((value) {
                        print(value);
                      });
                    },
                  ),
                  button(
                    'get camera postion',
                    () async {
                      final res = await controller?.cameraPostion;
                      toast(context, res.toString());
                    },
                  ),
                  button(
                    'get snapshot',
                    () async {
                      final res = await controller?.getSnapshot();
                      if (res != null) {
                        showCupertinoModalPopup(context: context, builder: (context) => SnapshotPage(data: res));
                      }
                    },
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  void toast(BuildContext context, String text) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));

  TLatLng rLatLng({TLatLng? latLng}) {
    if (latLng == null) {
      latLng = TLatLng(39.963175, 116.431865);
    }
    double r() {
      final res = Random.secure().nextDouble();
      final i = Random().nextInt(2);
      if (i == 0) {
        return 0 - res;
      } else {
        return res;
      }
    }

    return TLatLng(
      latLng.latitude + r() + r() + r(),
      latLng.longitude + r() + r() + r(),
    );

    return latLng;
  }
}
