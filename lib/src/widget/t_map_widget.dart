import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tencent_map/src/controller/t_map_controller.dart';
import 'package:tencent_map/src/controller/t_map_controller_impl.dart';
import 'package:tencent_map/src/model/t_ui_setting.dart';

class TMapWidget extends StatefulWidget {
  const TMapWidget({Key? key, required this.onCreate, this.setting}) : super(key: key);
  final ValueChanged<TMapController> onCreate;
  final TUiSetting? setting;

  @override
  _TMapWidgetState createState() => _TMapWidgetState();
}

class _TMapWidgetState extends State<TMapWidget> {
  TMapController? controller;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void onCreate(int viewId) {
    if (controller == null) {
      controller = TMapControllerImpl(viewId);
      widget.onCreate(controller!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AndroidView(
      viewType: 't_map_view',
      onPlatformViewCreated: onCreate,
      creationParams: <String, dynamic>{
        if (widget.setting != null) ...widget.setting!.toJson(),
      },
      creationParamsCodec: StandardMessageCodec(),
    );
  }
}
