import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../widget/custom_button.dart';
import '../../../widget/custom_textfield.dart';
import '../../../widget/styles.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('profile'.tr,style: robotoBold.copyWith(color: Colors.black)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      
      ),
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
          
            children: [
            const SizedBox(height: 40,),
       
           Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextfield(
                  borderWidth: 1,
                  hint: 'name'.tr,
                  label: 'name'.tr,
                  controller: controller.nameController,
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
                    controller: controller.phoneController,
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
                    controller: controller.countryController,
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
                    controller: controller.addressController,
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
                    controller: controller.cityController,
                    contentPadding: 10,
                    prefixIconPadding: 10,
                    
                  ),
                ),
        
        
            const SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(
                  width:350,
                  isEnable:!controller.isloading.value,
                  isLoding:controller.isloading,
                  radius: 25,
                  text: 'save'.tr,
                  onPressed: (){
                   controller.updateCustomerInfo();
                  },
                ),
              ),
          
        
          ]),
        ),
      )
    );
  }
}
