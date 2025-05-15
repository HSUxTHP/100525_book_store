import 'package:get/get.dart';

import '../../desktop/controllers/desktop_controller.dart';
import '../../mobile/controllers/mobile_controller.dart';
import '../../tablet/controllers/tablet_controller.dart';
import '../controllers/responsive_controller.dart';

class ResponsiveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResponsiveController>(() => ResponsiveController());
    if (Get.width < 500) {
      Get.lazyPut<MobileController>(() => MobileController());
    } else if (Get.width < 1100) {
      Get.lazyPut<TabletController>(() => TabletController());
    } else {
      Get.lazyPut<DesktopController>(() => DesktopController());
    }
  }
}
