import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import '../../../widget/custom_button.dart';
import '../../../widget/custom_textfield.dart';
import '../../../widget/styles.dart';
import '../controllers/login_controller.dart';

class ChangePasswordPage extends StatelessWidget {
var controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(child: Column(
        children: [
          //forget password
          const SizedBox(height: 40,),
          Text('change_password'.tr,style: robotoRegular.copyWith(fontSize: 30,fontWeight:FontWeight.bold,color:Colors.amber),),
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text('change_password_subtitle'.tr,textAlign:TextAlign.center,style: robotoRegular.copyWith(fontSize: 15,fontWeight:FontWeight.bold,color:Colors.grey),),
          ),
          //email
          //sizebox
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomTextfield(
              borderWidth: 1,
              controller: controller.newPasswordController,
              hint: 'new_password'.tr,
              label: 'new_password'.tr,
              contentPadding: 10,
              prefixIconPadding: 10,
              
            
            ),
          ),
          //re password
          //sizebox
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomTextfield(
              borderWidth: 1,
              controller: controller.rePasswordController,
              hint: 're_password'.tr,
              label: 're_password'.tr,
              contentPadding: 10,
              prefixIconPadding: 10,
              
            
            ),
          ),
          //send button
          const SizedBox(height: 15,),
           CustomButton(
            width:350,
            isLoding: controller.loading,
            isEnable:!controller.loading.value,
            radius: 25,
            text: 'save'.tr,
            onPressed: (){
              //check validation
              if(controller.newPasswordController.text.isEmpty){
                Get.snackbar('error'.tr, 'new_password_empty'.tr,   snackPosition: SnackPosition.BOTTOM,);
              }else if(controller.rePasswordController.text.isEmpty){
                Get.snackbar('error'.tr, 're_password_empty'.tr,   snackPosition: SnackPosition.BOTTOM,);
              }else if(controller.newPasswordController.text!=controller.rePasswordController.text){
                Get.snackbar('error'.tr, 'password_not_match'.tr,   snackPosition: SnackPosition.BOTTOM,);
              }else{
                controller.changePasswordButtonClicked();
              }
              
            },
          ),
        ],
      )),
    );
  }
}