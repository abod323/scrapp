import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sacrapapp/app/modules/Login/views/login_view.dart';

import '../../../data/repository/auth_repo.dart';
import '../../../widget/styles.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var RepasswordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  //address
  var addressController = TextEditingController();
  var cityController = TextEditingController();
  //country
  var countryController = TextEditingController();
  var isloading = false.obs;
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getCustomerInfo();
  }

  //get customer info
  Future getCustomerInfo() async {
    isloading.value = true;
    var response = await Get.find<AuthRepo>().getCustomerInfo();
    print(response.body);
    if (response.statusCode == 200) {
      var data = response.body;
      nameController.text = data['customer']['name'];
      emailController.text = data['customer']['email'];
      phoneController.text = data['customer']['phone'];
      addressController.text = data['customer']['address'];
      cityController.text = data['customer']['city'];
      countryController.text = data['customer']['country'];
      isloading.value = false;
    } else {
      isloading.value = false;
      Get.snackbar("Error", "Something went wrong");
    }
  }
  //update customer info
  Future updateCustomerInfo() async {
   //check empty
    if(nameController.text.isEmpty){
    Get.snackbar('error'.tr, 'name_empty'.tr,   snackPosition: SnackPosition.BOTTOM,);
  }else if(phoneController.text.isEmpty){
    Get.snackbar('error'.tr, 'phone_empty'.tr,   snackPosition: SnackPosition.BOTTOM,);
  }else if(countryController.text.isEmpty){
    Get.snackbar('error'.tr, 'country_empty'.tr,   snackPosition: SnackPosition.BOTTOM,);
  }else if(cityController.text.isEmpty){
    Get.snackbar('error'.tr, 'city_empty'.tr,   snackPosition: SnackPosition.BOTTOM,);
  }else if(addressController.text.isEmpty){
    Get.snackbar('error'.tr, 'address_empty'.tr,   snackPosition: SnackPosition.BOTTOM,);
  }
  else{
     isloading.value = true;
    var response = await Get.find<AuthRepo>().updateCustomerInfo(
        nameController.text,
        phoneController.text,
        addressController.text,
        cityController.text,
        countryController.text);
    print(response.body);
    if (response.statusCode == 200) {
      Get.find<AuthRepo>().saveUserEmailAndName(emailController.text, nameController.text);
      isloading.value = false;
      Get.snackbar("success".tr, "profile_updated".tr,snackPosition: SnackPosition.BOTTOM,);
    } else {
      isloading.value = false;
      Get.snackbar("error".tr, "Something went wrong",snackPosition: SnackPosition.BOTTOM,);
    }
  }
  
  
    
  }
  //delete account
  Future deleteAccount() async {
   //show confirm dialog
    Get.defaultDialog(
      title: 'delete_account'.tr,
      content: Text('delete_account_message'.tr,style: robotoRegular,),
      confirm: TextButton(
        onPressed: () async {
          var response = await Get.find<AuthRepo>().deleteUser();
          print(response.body);
          if (response.statusCode == 200) {
            Get.find<AuthRepo>().logout();
            Get.offAll(()=>LoginView());
          } else {
            Get.snackbar("error".tr, "something_went_wrong".tr,snackPosition: SnackPosition.BOTTOM,);
          }
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
