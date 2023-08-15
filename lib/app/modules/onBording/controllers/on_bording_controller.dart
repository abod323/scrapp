import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sacrapapp/app/data/api/api_clinet.dart';

import '../../Login/views/login_view.dart';

class OnBordingController extends GetxController {
  //TODO: Implement OnBordingController

  final index = 0.obs;
  ApiClinet apiClinet = Get.find<ApiClinet>();
  //page controller
  final pageController = PageController();
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

  //save first time
  void saveFirstTime() {
    //save first time to shared pref
    apiClinet.sharedPreferences.setBool('firstTime', false);
    Get.offAll(() => const LoginView());
  }

}
