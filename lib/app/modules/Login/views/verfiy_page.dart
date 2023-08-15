import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import '../../../widget/custom_button.dart';
import '../../../widget/custom_textfield.dart';
import '../../../widget/styles.dart';
import '../controllers/login_controller.dart';

class VerfiyPage extends StatelessWidget {
  var controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text('verify'.tr,style: robotoRegular.copyWith(fontSize: 16,fontWeight:FontWeight.bold,color:Colors.black),),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      
      ),
      body:Column(children: [
        //otp
        const SizedBox(height: 40,),
        Text('otp'.tr,style: robotoRegular.copyWith(fontSize: 30,fontWeight:FontWeight.bold,color:Colors.amber),),
        const SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text('otp_subtitle'.tr,textAlign:TextAlign.center,style: robotoRegular.copyWith(fontSize: 15,fontWeight:FontWeight.bold,color:Colors.grey),),
        ),
        //otp
        //sizebox
        const SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomTextfield(
            borderWidth: 1,
            controller: controller.codeController,
            hint: 'otp'.tr,
            label: 'otp'.tr,
            contentPadding: 10,
            prefixIconPadding: 10,
            keyboardType: TextInputType.number,
          ),
        ),
        //send button
        const SizedBox(height: 15,),
        CustomButton(
          width:350,
          radius: 25,
          isLoding: controller.loading,
          isEnable:!controller.loading.value,
          text: 'verify'.tr,
          onPressed: (){
            //check validation
            if(controller.codeController.text.isEmpty){
              Get.snackbar('error'.tr, 'otp_empty'.tr,   snackPosition: SnackPosition.BOTTOM,);
            }else{
              controller.verifyButtonClicked();
            }
          },
        ),
      ]),
    );
  }
}