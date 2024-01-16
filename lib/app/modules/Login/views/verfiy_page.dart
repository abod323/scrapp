import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import 'package:get/get.dart';

import '../../../widget/custom_button.dart';
import '../../../widget/custom_textfield.dart';
import '../../../widget/styles.dart';
import '../controllers/login_controller.dart';

class VerfiyPage extends StatefulWidget {
  final bool isForgetPassword;
  final phone;
   VerfiyPage({super.key, required this.isForgetPassword,required this.phone});

  @override
  State<VerfiyPage> createState() => _VerfiyPageState();
}

class _VerfiyPageState extends State<VerfiyPage> {

  //timer
  Timer? _timer;
  int _start = 60;

  //start timer
  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  //dispose timer
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer!.cancel();
  }

  
  @override
  void initState() {
   
    super.initState();
    startTimer();
  }
  
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
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        //otp
        const SizedBox(height: 40,),
        Text('otp'.tr,style: robotoRegular.copyWith(fontSize: 30,fontWeight:FontWeight.bold,color:Colors.amber),),
        const SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(widget.isForgetPassword? 'otp_subtitle'.tr:'whatssapp_otp'.tr,textAlign:TextAlign.center,style: robotoRegular.copyWith(fontSize: 15,fontWeight:FontWeight.bold,color:Colors.grey),),
        ),
        //otp
        //sizebox
        const SizedBox(height: 20,),
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: CustomTextfield(
        //     borderWidth: 1,
        //     controller: controller.codeController,
        //     hint: 'otp'.tr,
        //     label: 'otp'.tr,
        //     contentPadding: 10,
        //     prefixIconPadding: 10,
        //     keyboardType: TextInputType.number,
        //   ),
        // ),
         Directionality(
          textDirection: TextDirection.ltr,
          child: OtpTextField(
          autoFocus:true,
           
          numberOfFields: 6,
          borderColor: Color(0xFF512DA8),
          //set to true to show as box or false to show as dash
          showFieldAsBox: true, 
          //runs when a code is typed in
          onCodeChanged: (String code) {
              //handle validation or checks here           
          },
          //runs when every textfield is filled
          onSubmit: (String verificationCode){
              // showDialog(
              //     context: context,
              //     builder: (context){
              //     return AlertDialog(
              //         title: Text("Verification Code"),
              //         content: Text('Code entered is $verificationCode'),
              //     );
              //     }
              // );
              controller.codeController.text=verificationCode;
               if(verificationCode.isEmpty){
              Get.snackbar('error'.tr, 'otp_empty'.tr,   snackPosition: SnackPosition.BOTTOM,);
            }else{
              if(widget.isForgetPassword){
                controller.verifyButtonClicked(verificationCode);
              }
              else{
                controller.verifyWhatsappOtpButtonClicked(int.parse(verificationCode));
              }
            }
          }, // end onSubmit
          
            ),
        ),
             const SizedBox(height: 15,),
          //resend otp timer
         _start==0?GestureDetector(
           onTap: (){
             setState(() {
               _start=60;
               startTimer();
             });
            controller.resendOtpButtonClicked(widget.phone);
              
           },
           child: Text('resend_otp'.tr,style: robotoRegular.copyWith(fontSize: 15,fontWeight:FontWeight.bold,color:Colors.amber),),
         ):Text('$_start',style: robotoRegular.copyWith(fontSize: 15,fontWeight:FontWeight.bold,color:Colors.grey),),

        const SizedBox(height: 15,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx((){
            return controller.loading.value?Center(child: CircularProgressIndicator()):Container();
          }),
        )
        // CustomButton(
        //   width:350,
        //   radius: 25,
        //   isLoding: controller.loading,
        //   isEnable:!controller.loading.value,
        //   text: 'verify'.tr,
        //   onPressed: (){
        //     //check validation
        //     if(controller.codeController.text.isEmpty){
        //       Get.snackbar('error'.tr, 'otp_empty'.tr,   snackPosition: SnackPosition.BOTTOM,);
        //     }else{
        //       if(isForgetPassword){
        //         controller.verifyButtonClicked();
        //       }
        //       else{
        //         controller.verifyWhatsappOtpButtonClicked(int.parse(controller.codeController.text));
        //       }
        //     }
        //   },
        // ),
       
      ]),
    );
  }
}