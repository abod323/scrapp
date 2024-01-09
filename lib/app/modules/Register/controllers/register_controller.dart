import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sacrapapp/app/data/api/api_clinet.dart';
import 'package:sacrapapp/app/data/model/sign_up.dart';
import 'package:sacrapapp/app/data/repository/auth_repo.dart';
import 'package:sacrapapp/app/modules/Login/views/login_view.dart';
import 'package:sacrapapp/app/modules/Login/views/verfiy_page.dart';

class RegisterController extends GetxController {
  //TODO: Implement RegisterController

  final count = 0.obs;
  final agree = false.obs;
  ApiClinet apiClinet = Get.find<ApiClinet>();
  AuthRepo autoRepo = Get.find<AuthRepo>();
  //controller
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var RepasswordController = TextEditingController();
  var nameController = TextEditingController();
  var phone='';
  //address
  var addressController = TextEditingController();
  var cityController = TextEditingController();
  //country
  var countryController = TextEditingController();
  var loading = false.obs;


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
//register buttn
void RegisterButtonClicked(){
  //validation
  if(nameController.text.isEmpty){
    Get.snackbar('error'.tr, 'name_empty'.tr,   snackPosition: SnackPosition.BOTTOM,);
  }else if(emailController.text.isEmpty){
    Get.snackbar('error'.tr, 'email_empty'.tr,   snackPosition: SnackPosition.BOTTOM,);
  }else if(phone.isEmpty){
    Get.snackbar('error'.tr, 'phone_empty'.tr,   snackPosition: SnackPosition.BOTTOM,);
  }else if(countryController.text.isEmpty){
    Get.snackbar('error'.tr, 'country_empty'.tr,   snackPosition: SnackPosition.BOTTOM,);
  }else if(cityController.text.isEmpty){
    Get.snackbar('error'.tr, 'city_empty'.tr,   snackPosition: SnackPosition.BOTTOM,);
  }else if(addressController.text.isEmpty){
    Get.snackbar('error'.tr, 'address_empty'.tr,   snackPosition: SnackPosition.BOTTOM,);
  }
  
  else if(passwordController.text.isEmpty){
    Get.snackbar('error'.tr, 'password_empty'.tr,   snackPosition: SnackPosition.BOTTOM,);
  }else if(RepasswordController.text.isEmpty){
    Get.snackbar('error'.tr, 'repassword_empty'.tr,   snackPosition: SnackPosition.BOTTOM,);
  }else if(passwordController.text!=RepasswordController.text){
    Get.snackbar('error'.tr, 'password_not_match'.tr,   snackPosition: SnackPosition.BOTTOM,);
  }else if(!agree.value){
    Get.snackbar('error'.tr, 'agree_terms'.tr,   snackPosition: SnackPosition.BOTTOM,);
  }else{
    loading.value = true;
    autoRepo.registration(
       SignUpModel(
        name: nameController.text,
        email: emailController.text,
        phone: phone,
        password: passwordController.text,
        passwordConfirmation: RepasswordController.text,
        address: addressController.text,
        city: cityController.text,
        country: countryController.text,
      )
    ).then((value) {
      if(value.statusCode==200){
        Get.offAll(()=>VerfiyPage(isForgetPassword: false,phone:phone,),transition: Transition.rightToLeft,curve: Curves.easeInCubic,duration: const Duration(milliseconds: 600));
        Get.snackbar('success'.tr, 'register_success'.tr,   snackPosition: SnackPosition.BOTTOM,);
        loading.value = false;
      }else{
        //show message
        Get.snackbar('error'.tr, value.body['message'],   snackPosition: SnackPosition.BOTTOM,);
        loading.value = false;
      }
    });
  }
  

}
}
