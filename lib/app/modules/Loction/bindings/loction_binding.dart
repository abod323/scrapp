import 'package:get/get.dart';

import '../controllers/loction_controller.dart';

class LoctionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoctionController>(
      () => LoctionController(),
    );
  }
}
