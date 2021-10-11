class TUiSetting {
  ///是否开启地图缩放手势
  final bool zoomGesturesEnabled;

  ///是否开启地图倾斜手势
  final bool tiltGesturesEnabled;

  ///是否开启地图滚动手势
  final bool scrollGesturesEnabled;

  ///当前是否显示比例尺
  final bool scaleViewEnabled;

  ///是否开启地图旋转手势
  final bool rotateGesturesEnabled;

  ///是否显示定位按钮
  final bool myLocationButtonEnabled;

  TUiSetting({
    this.zoomGesturesEnabled = true,
    this.tiltGesturesEnabled = false,
    this.scrollGesturesEnabled = true,
    this.scaleViewEnabled = true,
    this.rotateGesturesEnabled = false,
    this.myLocationButtonEnabled = false,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'zoomGesturesEnabled': zoomGesturesEnabled,
      'tiltGesturesEnabled': tiltGesturesEnabled,
      'scrollGesturesEnabled': scrollGesturesEnabled,
      'scaleViewEnabled': scaleViewEnabled,
      'rotateGesturesEnabled': rotateGesturesEnabled,
      'myLocationButtonEnabled': myLocationButtonEnabled,
    };
  }
}
