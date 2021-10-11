import 't_convert.dart';

typedef ParseData<T> = T Function(dynamic data);

class ChannelResut<T> {
  ChannelResut._(this.success, {this.message = '', this.data});

  factory ChannelResut.fromJson(Map<dynamic, dynamic> json, {ParseData<T>? parse}) {
    if (!(asT<bool>(json['success']) ?? false)) {
      return ChannelResut._(
        false,
        message: asT<String>(json['message']) ?? '操作失败',
      );
    }
    return ChannelResut._(
      true,
      message: asT<String>(json['message']) ?? '操作成功',
      data: parse != null ? parse(json['data']) : json['data'],
    );
  }

  final bool success;
  final String message;
  final T? data;
}
