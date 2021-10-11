import 'package:tencent_map/src/overlayer/t_overlayer.dart';

abstract class TOverLayerManager {
  void addOverLayer(TOverLayer overLayer);

  Future<bool> removeOverLayer(String overId);

  void removeAll();

  void onTapListener(String? overId);

  void dispose();
}
