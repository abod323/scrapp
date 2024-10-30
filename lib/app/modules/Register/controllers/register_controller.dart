import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sacrapapp/app/data/api/api_clinet.dart';
import 'package:sacrapapp/app/data/model/sign_up.dart';
import 'package:sacrapapp/app/data/repository/auth_repo.dart';
import 'package:sacrapapp/app/modules/Home/views/nav_home.dart';

import 'package:sacrapapp/app/modules/Login/views/verfiy_page.dart';
import 'package:sacrapapp/app/util/app_constant.dart';
import 'package:sacrapapp/app/util/get_di.dart';

class RegisterController extends GetxController {
  //TODO: Implement RegisterController
  var language = 'en'.obs;
  final count = 0.obs;
  final agree = false.obs;
  ApiClinet apiClinet = Get.find<ApiClinet>();
  AuthRepo autoRepo = Get.find<AuthRepo>();
  //controller
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
  var loading = false.obs;
Future<dynamic> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      //get user
      await FirebaseAuth.instance.signInWithCredential(credential).then((value) =>{
        
        //check if user is new
        if(value.additionalUserInfo!.isNewUser){
          autoRepo.registration(
          SignUpModel(
            name: value.user!=null?value.user!.displayName!:'name',
            email: value.user!=null?value.user!.email!:'email',
            phone: value.user!=null?value.user!.phoneNumber!=null?value.user!.phoneNumber!:'phone':'phone',
            password: '1223456',
            passwordConfirmation: '123456',
            address: 'address',
            city: 'city',
            country: 'KSA',
          ),
        ).then((value3) =>{
          if(value3.statusCode==200){
           //nav
           autoRepo.saveToken(value3.body['token']).then((value1) {
            if(value1){
              // Get.offAllNamed(Routes.HOME);
              loading.value = false;
               showSnackbar('success'.tr, 'register_success'.tr);
            Get.back();
              autoRepo.saveUserEmailAndName(value.user!.email!, value.user!.displayName!.toString()).then((value) =>    Get.offAll(()=>NavHome()));
               AppDi.init();
               passwordController.text='';
              
            }
          }),
           
            
          }else{
            //show message
            Get.back(),
            showSnackbar('error'.tr, value3.body['message']),
            loading.value = false,
          }
        })
        }
        else{
         
           autoRepo.login(email: value.user!.email!,password: '1234567',login_by:'google',name:value.user!.displayName!.toString()).then((value6) {
            if(value6.statusCode==200){
              //save token
              autoRepo.saveToken(value6.body['token']).then((value1) {
                if(value1){
                  // Get.offAllNamed(Routes.HOME);
                  loading.value = false;
                 
                  autoRepo.saveUserEmailAndName(value.user!.email!, value.user!.displayName!.toString()).then((value) =>   Get.offAll(()=>NavHome()));
                   AppDi.init();
                   passwordController.text='';
                     Get.back();
                }
              });
            }else{
                Get.back();
              showSnackbar('error'.tr, value6.body);
              loading.value = false;
            }
          })
        }
        
      });
      //check if user is new
    
        
      
    } on Exception catch (e) {
      // TODO
      print('exception->$e');
    }
  }



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
   showSnackbar('error'.tr, 'name_empty'.tr);
  }else if(phoneController.text.isEmpty){
    showSnackbar('error'.tr, 'phone_empty'.tr);
  }
  
 
  else{
    loading.value = true;
    autoRepo.registration(
       SignUpModel(
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
        password: passwordController.text,
        passwordConfirmation: RepasswordController.text,
        address: 'N/A',
        city: 'N/A',
        country: 'KSA',
      )
    ).then((value) {
      if(value.statusCode==200){
        Get.offAll(()=>VerfiyPage(isForgetPassword: false,phone:phoneController.text,fromLogin: false),transition: Transition.rightToLeft,curve: Curves.easeInCubic,duration: const Duration(milliseconds: 600));
   
        showSnackbar('success'.tr, 'register_success'.tr);
        loading.value = false;
      }else{
        //show message
        showSnackbar('error'.tr, value.body['message']);
        loading.value = false;
      }
    });
  }
  

}
}
