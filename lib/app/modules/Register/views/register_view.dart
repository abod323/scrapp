import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sacrapapp/app/widget/styles.dart';

import '../../../widget/custom_appbar.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/custom_textfield.dart';
import '../../../widget/terms.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {

   RegisterView({Key? key}) : super(key: key);
  var registerController=Get.put(RegisterController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:CustomAppBar.buildAppBar(context, 'register'.tr),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
          
            children: [
            const SizedBox(height: 40,),
            Text('register'.tr,style: TextStyle(fontSize: 30,fontWeight:FontWeight.bold,color:Colors.amber),),
            const SizedBox(height: 20,),
           Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextfield(
                  borderWidth: 1,
                  hint: 'name'.tr,
                  label: 'name'.tr,
                  controller: registerController.nameController,
                  contentPadding: 10,
                  prefixIconPadding: 10,
                  
                ),
              ),
           Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextfield(
                  borderWidth: 1,
                  hint: 'email'.tr,
                  label: 'email'.tr,
                  controller: registerController.emailController,
                  contentPadding: 10,
                  prefixIconPadding: 10,
                  
                ),
              ),
              //phone
            Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextfield(
                    borderWidth: 1,
                    hint: 'phone'.tr,
                    label: 'phone'.tr,
                    controller: registerController.phoneController,
                    contentPadding: 10,
                    prefixIconPadding: 10,
                    keyboardType: TextInputType.phone,
                    
                  ),
                ),
                //country
            Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextfield(
                    borderWidth: 1,
                    hint: 'country'.tr,
                    label: 'country'.tr,
                    controller: registerController.countryController,
                    contentPadding: 10,
                    prefixIconPadding: 10,
                    
                  ),
                ),
            //address
            Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextfield(
                    borderWidth: 1,
                    hint: 'address'.tr,
                    label: 'address'.tr,
                    controller: registerController.addressController,
                    contentPadding: 10,
                    prefixIconPadding: 10,
                    
                  ),
                ),

                //city
            Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextfield(
                    borderWidth: 1,
                    hint: 'city'.tr,
                    label: 'city'.tr,
                    controller: registerController.cityController,
                    contentPadding: 10,
                    prefixIconPadding: 10,
                    
                  ),
                ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextfield(
                  borderWidth: 1,
                  controller:registerController.passwordController,
                  hint: 'password'.tr,
                  label: 'password'.tr,
                  contentPadding: 10,
                  prefixIconPadding: 10,
                    isObscure: true,
                isPassword: true,
                  
                ),
              ),
           Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextfield(
                  borderWidth: 1,
                  controller:registerController.RepasswordController,
                  hint: 'confirm_password'.tr,
                  label: 'confirm_password'.tr,
                  contentPadding: 10,
                  prefixIconPadding: 10,
                    isObscure: true,
                isPassword: true,

                  
                 
                ),
              ),
           const SizedBox(height: 20,),
            //check box
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Obx(() => Checkbox(value: registerController.agree.value, onChanged: (value){
                    registerController.agree.value=value!;
                  }),),
                  Text('agree'.tr,style: robotoRegular.copyWith(fontSize: 15,fontWeight:FontWeight.bold,color:Colors.grey),),
                  TextButton(onPressed: (){
                    Get.to(()=>TermsPage());
                  }, child: Text('terms_and_conditions'.tr,style: robotoRegular.copyWith(fontSize: 15,fontWeight:FontWeight.bold,color:Colors.amber),))
                ],
              ),
            ),
            const SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(
                  width:350,
                  isEnable:!registerController.loading.value,
                  isLoding: registerController.loading,
                  radius: 25,
                  text: 'register'.tr,
                  onPressed: (){
                   registerController.RegisterButtonClicked();
                  },
                ),
              ),
          
        
          ]),
        ),
      )
    );
  }
}
