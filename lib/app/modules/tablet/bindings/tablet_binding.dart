import 'package:get/get.dart';

import '../controllers/tablet_controller.dart';

class TabletBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TabletController>(
      () => TabletController(),
    );
  }
}
