import 'package:get/get.dart';

class DesktopController extends GetxController {
  //TODO: Implement DesktopController

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  var selectedIndex = 0.obs;

  void setIndex(int index) {
    selectedIndex.value = index;
  }
}
