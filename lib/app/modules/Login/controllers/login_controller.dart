import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sacrapapp/app/data/api/api_clinet.dart';
import 'package:sacrapapp/app/data/repository/settings_repo.dart';
import 'package:sacrapapp/app/modules/Home/views/home_view.dart';
import 'package:sacrapapp/app/modules/Home/views/nav_home.dart';
import 'package:sacrapapp/app/modules/Login/views/login_view.dart';
//http
import 'package:http/http.dart' as http;
import 'package:sacrapapp/app/util/app_constant.dart';

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
  var phone='';
  //controller

  var forgetEmailController = TextEditingController();
  var passwordController = TextEditingController();
  var codeController = TextEditingController();
  var newPasswordController = TextEditingController();
  var rePasswordController = TextEditingController();
  var phoneController=TextEditingController();

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
    if(phoneController.text.isEmpty){

      showSnackbar('error'.tr, 'phone_empty'.tr);
      
    }else if(passwordController.text.isEmpty){
      showSnackbar('error'.tr, 'password_empty'.tr);
    }else{
      loading.value = true;
      autoRepo!.login(email: phoneController.text.trim(), password: passwordController.text.trim(),login_by: 'phone').then((value) {
        if(value.statusCode==200){
          //save token
          autoRepo!.saveToken(value.body['token']).then((value1) {
            if(value1){
              // Get.offAllNamed(Routes.HOME);
              loading.value = false;
             
              Get.offAll(()=>NavHome());
              autoRepo!.saveUserEmailAndName(phone, value.body['name']);
               AppDi.init();
               passwordController.text='';
            }
          });
        }else{
          

          if(value.body['code']==100){
            resendOtpButtonClicked(phone).then((value) { 
              Get.to(()=>VerfiyPage(isForgetPassword: false,phone: phone,));
              loading.value = false;
              passwordController.text='';
            });
            

          }
          else{
            showSnackbar('error'.tr, value.body['message']);
            loading.value = false;
          }
          
          
        }
      });
    }
  }
  //resend otp
  Future<void> resendOtpButtonClicked(String phone) async {
    loading.value = true;
var request = http.MultipartRequest('POST', Uri.parse('${AppConstants.API_BASE_URL+AppConstants.RESEND_OTP_URI}'));
request.fields.addAll({
  'phone': phone,
});

http.StreamedResponse response = await request.send();

if (response.statusCode == 200) {
  print(await response.stream.bytesToString());
  showSnackbar('success'.tr, 'otp_sent_successfully'.tr);
  loading.value = false;
  
}
else {
  var body= await response.stream.bytesToString();
  var data= jsonDecode(body);
  showSnackbar('error'.tr, data['message']);
  loading.value = false;
}

  }
  //forgot password
  void forgotPasswordButtonClicked(){
    loading.value = true;
    autoRepo!.forgetPassword(forgetEmailController.text).then((value) {
      print(value.body);
      if(value.statusCode==200){
        Get.to(()=>VerfiyPage(isForgetPassword: true,phone:forgetEmailController.text,));
        loading.value = false;
      }else{
        showSnackbar('error'.tr, value.body['message']);
        loading.value = false;
      }
    });
  }
  //verify
  void verifyButtonClicked(String code){
    loading.value = true;
    autoRepo!.verifyCode(forgetEmailController.text,code).then((value) {
      if(value.statusCode==200){
        Get.offAll(()=>ChangePasswordPage());
        loading.value = false;
      }else{
        showSnackbar('error'.tr, value.body['message']);
        loading.value = false;
      }
    });
  }
  //verify otp
  Future<void> verifyWhatsappOtpButtonClicked(int otp) async {
    loading.value = true;

var request = http.Request('POST', Uri.parse('${AppConstants.API_BASE_URL+AppConstants.OTP_URI}?otp=$otp'));



http.StreamedResponse response = await request.send();

if (response.statusCode == 200) {
  print(await response.stream.bytesToString());
 //show snackbar
 showSnackbar('success'.tr, 'otp_verified_successfully'.tr);
  Get.offAll(()=>LoginView());
  loading.value = false;

}
else {

  //print message
  var body= await response.stream.bytesToString();
  var data= jsonDecode(body);
 //show snackbar
  showSnackbar('error'.tr, data['message']);
  loading.value = false;
}

  }
  //changePasswordButtonClicked
  void changePasswordButtonClicked(){
    loading.value = true;
      autoRepo!.resetPassword(codeController.text, newPasswordController.text).then((value) {
        if(value.statusCode==200){

          Get.offAll(()=>LoginView());
          loading.value = false;
      showSnackbar('success'.tr, 'password_changed_successfully'.tr);
        }else{
         showSnackbar('error'.tr, value.body['message']);
          loading.value = false;
        }
      });
    
  }

}
