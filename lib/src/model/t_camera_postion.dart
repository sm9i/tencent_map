import 'package:tencent_map/src/model/t_convert.dart';
import 'package:tencent_map/src/model/t_lat_lng.dart';

class TCameraPostion {
  TCameraPostion(
    this.latLng, {
    this.zoom = 15,
    this.tilt = 0.0,
    this.bearing = 0.0,
  });

  factory TCameraPostion.fromJson(Map<dynamic, dynamic> json) {
    return TCameraPostion(
      TLatLng.fromJson(json),
      zoom: asT<double>(json['zoom'])!,
      tilt: asT<double>(json['tilt'])!,
      bearing: asT<double>(json['bearing'])!,
    );
  }

  final TLatLng latLng;
  final double zoom;
  final double tilt;
  final double bearing;

  @override
  String toString() {
    return 'TCameraPostion{latLng: $latLng, zoom: $zoom, tilt: $tilt, bearing: $bearing}';
  }
}
