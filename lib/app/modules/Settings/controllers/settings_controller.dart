import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/repository/auth_repo.dart';
import '../../../widget/styles.dart';
import '../../Login/views/login_view.dart';

class SettingsController extends GetxController {
  //TODO: Implement SettingsController

  final count = 0.obs;
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

  //logout
  void logout() {
    //SHOW CONFIRM DIALOG
    Get.defaultDialog(
      title: 'logout'.tr,
      content: Text('logout_message'.tr,style: robotoRegular,),
      confirm: TextButton(
        onPressed: () async {
          Get.find<AuthRepo>().logout().then((value) {
          if (value) {
            Get.offAll(() => const LoginView());
          }
        });
        },
        child: Text('yes'.tr,style: robotoRegular,),
      ),
      cancel: TextButton(
        onPressed: () {
          Get.back();
        },
        child: Text('no'.tr,style: robotoRegular,),
      ),
    );
  }
}
