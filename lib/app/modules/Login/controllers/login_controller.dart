import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sacrapapp/app/data/api/api_clinet.dart';
import 'package:sacrapapp/app/data/repository/settings_repo.dart';
import 'package:sacrapapp/app/modules/Home/views/home_view.dart';
import 'package:sacrapapp/app/modules/Home/views/nav_home.dart';
import 'package:sacrapapp/app/modules/Login/views/login_view.dart';

import '../../../data/repository/auth_repo.dart';
import '../../../util/get_di.dart';
import '../views/change_password.dart';
import '../views/verfiy_page.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController
  var hidePassword = true.obs;
  ApiClinet? apiClinet;
  AuthRepo? autoRepo;
 var loading = false.obs;
  var language = 'en'.obs;
  //controller
  var emailController = TextEditingController();
  var forgetEmailController = TextEditingController();
  var passwordController = TextEditingController();
  var codeController = TextEditingController();
  var newPasswordController = TextEditingController();
  var rePasswordController = TextEditingController();

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    apiClinet = Get.find<ApiClinet>();
    autoRepo = Get.find<AuthRepo>();
    Get.find<SettingsRepo>().getAllSettings();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  //login
  void loginButtonClicked(){
    
   //check validation
    if(emailController.text.isEmpty){
      Get.snackbar('error'.tr, 'email_empty'.tr,   snackPosition: SnackPosition.BOTTOM,);
      
    }else if(passwordController.text.isEmpty){
      Get.snackbar('error'.tr, 'password_empty'.tr,   snackPosition: SnackPosition.BOTTOM,);
    }else{
      loading.value = true;
      autoRepo!.login(email: emailController.text, password: passwordController.text).then((value) {
        if(value.statusCode==200){
          //save token
          autoRepo!.saveToken(value.body['token']).then((value1) {
            if(value1){
              // Get.offAllNamed(Routes.HOME);
              loading.value = false;
             
              Get.offAll(()=>NavHome());
              autoRepo!.saveUserEmailAndName(emailController.text, value.body['name']);
               AppDi.init();
            }
          });
        }else{
          Get.snackbar('error'.tr, value.body['message'],snackPosition: SnackPosition.BOTTOM,);
          loading.value = false;
        }
      });
    }
  }
  //forgot password
  void forgotPasswordButtonClicked(){
    loading.value = true;
    autoRepo!.forgetPassword(forgetEmailController.text).then((value) {
      print(value.body);
      if(value.statusCode==200){
        Get.to(()=>VerfiyPage());
        loading.value = false;
      }else{
        // Get.snackbar('error'.tr, value.body['message'],snackPosition: SnackPosition.BOTTOM,);
        loading.value = false;
      }
    });
  }
  //verify
  void verifyButtonClicked(){
    loading.value = true;
    autoRepo!.verifyCode(forgetEmailController.text,codeController.text).then((value) {
      if(value.statusCode==200){
        Get.offAll(()=>ChangePasswordPage());
        loading.value = false;
      }else{
        Get.snackbar('error'.tr, value.body['message'],snackPosition: SnackPosition.BOTTOM,);
        loading.value = false;
      }
    });
  }
  //changePasswordButtonClicked
  void changePasswordButtonClicked(){
    loading.value = true;
      autoRepo!.resetPassword(codeController.text, newPasswordController.text).then((value) {
        if(value.statusCode==200){

          Get.offAll(()=>LoginView());
          loading.value = false;
       Get.snackbar('success'.tr, 'password_changed_successfully'.tr,snackPosition: SnackPosition.BOTTOM,);
        }else{
          Get.snackbar('error'.tr, value.body['message'],snackPosition: SnackPosition.BOTTOM,);
          loading.value = false;
        }
      });
    
  }

}
