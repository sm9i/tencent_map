import 'package:tencent_map/src/model/t_convert.dart';

class TLatLng {
  const TLatLng(this.latitude, this.longitude);

  factory TLatLng.fromJson(Map<dynamic, dynamic> json) {
    return TLatLng(
      asT<double>(json['lat'])!,
      asT<double>(json['lng'])!,
    );
  }

  final double latitude;
  final double longitude;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'lat': latitude,
      'lng': longitude,
    };
  }

  @override
  String toString() {
    return 'TLatLng{latitude: $latitude, longitude: $longitude}';
  }
}
