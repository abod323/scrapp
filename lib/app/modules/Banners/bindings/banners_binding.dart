import 'package:get/get.dart';

import '../controllers/banners_controller.dart';

class BannersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BannersController>(
      () => BannersController(),
    );
  }
}
