import 'package:get/get.dart';

import '../controllers/on_bording_controller.dart';

class OnBordingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnBordingController>(
      () => OnBordingController(),
    );
  }
}
