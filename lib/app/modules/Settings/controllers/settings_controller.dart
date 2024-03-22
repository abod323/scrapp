import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/model/app_settings.dart';
import '../../../data/repository/auth_repo.dart';
import '../../../widget/styles.dart';
import '../../Login/views/login_view.dart';

class SettingsController extends GetxController {
  //TODO: Implement SettingsController
  List<AppSettings>? appsettings;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  
  }

  Future<void> launchURL(String url) async {
   Uri _url = Uri.parse(url);
  if (!await launchUrl(_url,mode: LaunchMode.externalApplication)) {
    throw Exception('Could not launch $_url');
  }
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
