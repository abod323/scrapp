import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/custom_textfield.dart';
import '../../../widget/styles.dart';
import '../controllers/login_controller.dart';

class VerfiyPage extends StatefulWidget {
  final bool isForgetPassword;
  final phone;
  final bool fromLogin;
  VerfiyPage({super.key, required this.isForgetPassword, required this.phone, required this.fromLogin});

  @override
  State<VerfiyPage> createState() => _VerfiyPageState();
}

class _VerfiyPageState extends State<VerfiyPage> with CodeAutoFill {
  Timer? _timer;
  int _start = 60;
  var controller = Get.put(LoginController());

  // Initialize SMS Autofill for OTP
  @override
  void initState() {
    super.initState();
    SmsAutoFill().listenForCode(); // Start listening for SMS OTP
    // startTimer();
  }

  // Timer to resend OTP
  // void startTimer() {
  //   const oneSec = Duration(seconds: 1);
  //   _timer = Timer.periodic(
  //     oneSec,
  //     (Timer timer) {
  //       if (_start == 0) {
  //         setState(() {
  //           timer.cancel();
  //         });
  //       } else {
  //         setState(() {
  //           _start--;
  //         });
  //       }
  //     },
  //   );
  // }

  // Callback when SMS code is detected
  @override
  void codeUpdated() {
    String? code = controller.codeController.text;
    setState(() {
      controller.codeController.text = code;
    });
    // Automatically verify OTP if auto-filled
    if (code != null && code.length == 6) {
      if (widget.isForgetPassword) {
        controller.verifyButtonClicked(code);
      } else {
        controller.verifyWhatsappOtpButtonClicked(int.parse(code), widget.fromLogin);
      }
    }
  }

  // Dispose resources
  @override
  void dispose() {
    _timer?.cancel();
    SmsAutoFill().unregisterListener(); // Stop listening for SMS
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('verify'.tr,
            style: robotoRegular.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          Text('otp'.tr,
              style: robotoRegular.copyWith(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber)),
          // const SizedBox(height: 20),
          // Padding(
          //   padding: const EdgeInsets.all(12.0),
          //   child: Text(
          //     widget.isForgetPassword ? 'otp_subtitle'.tr : 'whatssapp_otp'.tr,
          //     textAlign: TextAlign.center,
          //     style: robotoRegular.copyWith(
          //         fontSize: 15,
          //         fontWeight: FontWeight.bold,
          //         color: Colors.grey),
          //   ),
          // ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: PinFieldAutoFill(
              codeLength: 6,
              currentCode: controller.codeController.text,
              onCodeSubmitted: (code) {},
              onCodeChanged: (code) {
                if (code!.length == 6) {
                  controller.codeController.text = code;
                  if (widget.isForgetPassword) {
                    controller.verifyButtonClicked(code);
                  } else {
                    controller.verifyWhatsappOtpButtonClicked(
                        int.parse(code), widget.fromLogin);
                  }
                }
              },
            ),
          ),
          const SizedBox(height: 15),
           GestureDetector(
                  onTap: () {
                    
                    controller.resendOtpButtonClicked(widget.phone);
                  },
                  child: Text(
                    'resend_otp'.tr,
                    style: robotoRegular.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber),
                  ),
                ),
              
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(() {
              return controller.loading.value
                  ? Center(child: CircularProgressIndicator())
                  : Container();
            }),
          ),
        ],
      ),
    );
  }
}
