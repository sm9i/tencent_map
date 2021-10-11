import 'package:tencent_map/src/model/t_camera_postion.dart';
import 'package:tencent_map/src/model/t_convert.dart';

enum TChangeStatus { CHANGE, FINISH }

class TCameraChange {
  TCameraChange._(this.status, this.postion);

  factory TCameraChange.fromJson(Map<dynamic, dynamic> json) {
    return TCameraChange._(
      (asT<bool>(json['change']) ?? false) ? TChangeStatus.CHANGE : TChangeStatus.FINISH,
      TCameraPostion.fromJson(json),
    );
  }

  final TChangeStatus status;
  final TCameraPostion postion;

  @override
  String toString() {
    return 'TCameraChange{status: $status, postion: $postion}';
  }
}
