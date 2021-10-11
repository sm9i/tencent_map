class TOverOptionType {
  const TOverOptionType._(this.value);

  ///marker
  static const marker = TOverOptionType._(0);

  ///polyline
  static const polyline = TOverOptionType._(1);

  final int value;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'overType': value,
    };
  }
}
