import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sacrapapp/app/modules/Login/views/login_view.dart';
import 'package:sacrapapp/app/modules/Profile/controllers/profile_controller.dart';

import '../../../data/repository/auth_repo.dart';
import '../../../language/language_page.dart';
import '../../../widget/styles.dart';
import '../../../widget/terms.dart';
import '../../Profile/views/profile_view.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
          
            const SizedBox(height: 20,),
            //profile card
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      Get.find<AuthRepo>().getUserName().toString()
                      ,style: robotoRegular.copyWith(fontSize: 20,fontWeight: FontWeight.bold),),
                    const SizedBox(height: 5,),
                    Text( Get.find<AuthRepo>().getUserEmail().toString()
                      ,style: robotoRegular.copyWith(fontSize: 15,color:Colors.grey[600]),),
      
                  ]
                ))),
                //list
                const SizedBox(height: 20,),
                //edit profile
              Get.find<AuthRepo>().getToken()==null?Container():
                ListTile(
                  onTap: (){
                   var profileController=Get.put(ProfileController());
                   profileController.getCustomerInfo().then((value) {
                     Get.to(()=>ProfileView());
                   });
                  },
                  leading: const Icon(color:Colors.amber,Icons.edit),
                  title: Text("edit_profile".tr,style: robotoRegular.copyWith(fontSize: 18,),),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
                ListTile(
                 
                  onTap: (){
                    Get.to(()=>LanguagePage());
                  },
                  leading: const Icon(color:Colors.amber,Icons.language),
                  title: Text("language".tr,style: robotoRegular.copyWith(fontSize: 18,),),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
                ListTile(
                  onTap: (){
                    // Get.toNamed("/about");
                  },
                  leading: const Icon(color:Colors.amber,Icons.info),
                  title: Text("about_us".tr,style: robotoRegular.copyWith(fontSize: 18,),),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
                ListTile(
                  onTap: (){
                    // Get.toNamed("/contact");
                  },
                  leading: const Icon(color:Colors.amber,Icons.contact_mail),
                  title: Text('contact_us'.tr,style: robotoRegular.copyWith(fontSize: 18,),),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
                ListTile(
                  onTap: (){
                      Get.to(()=>TermsPage());
                  },
                  leading: const Icon(color:Colors.amber,Icons.description),
                  title: Text("terms_and_conditions".tr,style: robotoRegular.copyWith(fontSize: 18),),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
                //logout LISTTILE
             
                ListTile(
                  onTap: (){
                    Get.find<AuthRepo>().getToken()==null?
                    Get.to(()=>LoginView(),arguments: [true]):controller.logout();
                  },
                  leading: const Icon(color:Colors.amber,Icons.logout),
                  title: Text(  Get.find<AuthRepo>().getToken()==null? "login".tr:"logout".tr
                  ,style: robotoRegular.copyWith(fontSize: 18),),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
                //DELETE ACCOUNT
                Get.find<AuthRepo>().getToken()==null?Container():
                ListTile(
                  onTap: (){
                    var profileController=Get.put(ProfileController());
                    profileController.deleteAccount();
                  },
                  leading: const Icon(Icons.delete,color:Colors.red,),
                  title: Text("delete_account".tr,style: robotoRegular.copyWith(fontSize: 18,color:Colors.red),),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
                
                
                ]),
      )
    );
  }
}
