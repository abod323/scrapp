import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:sacrapapp/app/modules/Login/controllers/login_controller.dart';

import '../../../widget/custom_appbar.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/custom_textfield.dart';
import '../../../widget/styles.dart';

class ForgetPassword extends StatelessWidget {

 var controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:  AppBar(
        title: Text('forgot_password'.tr,style: robotoRegular.copyWith(fontSize: 16,fontWeight:FontWeight.bold,color:Colors.black),),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      
      ),
      body: Center(
        child:Column(
          children: [
            //forget password
            const SizedBox(height: 40,),
            Text('forgot_password'.tr,style: robotoRegular.copyWith(fontSize: 30,fontWeight:FontWeight.bold,color:Colors.amber),),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text('forget_subtitle'.tr,textAlign:TextAlign.center,style: robotoRegular.copyWith(fontSize: 15,fontWeight:FontWeight.bold,color:Colors.grey),),
            ),
            //email
            //sizebox
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextfield(
                borderWidth: 1,
                controller: controller.forgetEmailController,
                hint: 'email'.tr,
                label: 'email'.tr,
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
              text: 'send'.tr,
              onPressed: (){
                //check validation
                if(controller.forgetEmailController.text.isEmpty){
                  Get.snackbar('error'.tr, 'email_empty'.tr,   snackPosition: SnackPosition.BOTTOM,);
                }else{
                  controller.forgotPasswordButtonClicked();
                }
              },
            ),

          ],
        ),
      ),
    );
  }
}