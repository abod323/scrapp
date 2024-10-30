
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sacrapapp/app/modules/Login/controllers/login_controller.dart';
import 'package:sacrapapp/app/modules/Login/views/forget_password.dart';
import 'package:sacrapapp/app/modules/Register/controllers/register_controller.dart';
import 'package:sacrapapp/app/modules/Register/views/register_view.dart';
import 'package:sacrapapp/app/util/app_constant.dart';
import 'custom_button.dart';
import 'custom_input_field.dart';
import 'fade_slide_transition.dart';

class LoginForm extends StatelessWidget {
  final Animation<double> animation;
  var controller =Get.put(LoginController());

   LoginForm({
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    final height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final space = height > 650 ? kSpaceM : kSpaceS;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kPaddingL),
      child: Column(
        children: <Widget>[
           FadeSlideTransition(
            animation: animation,
            additionalOffset: 0.0,
            child: Text(
           'login'.tr,
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: kBlack, fontWeight: kFontWeightBold, fontFamily: kFontFamily),
            ),
          ),
          SizedBox(height: space),
          Directionality(
            textDirection: TextDirection.ltr,
            child: FadeSlideTransition(
              animation: animation,
              additionalOffset: 0.0,
              child:  CustomInputField(
                controller: controller.phoneController,
                isNumber: true,
                label: 'phone'.tr,
                prefixIcon: Icons.phone_android,
                obscureText: false,
              
              ),
            ),
          ),
         
          // SizedBox(height: space),
          // Directionality(
          //   textDirection: TextDirection.ltr,
          //   child: FadeSlideTransition(
          //     animation: animation,
          //     additionalOffset: 1 * space,
          //     child: CustomInputField(
          //       controller: controller.passwordController,
          //       isNumber: false,
          //       label: 'password'.tr,
          //       prefixIcon: Icons.lock,
          //       obscureText: true,
          //     ),
          //   ),
          // ),
          // SizedBox(height: space),  
          // //Forgot password
          // Row(
          //   mainAxisAlignment: Get.locale == Locale('ar', 'SA') ? MainAxisAlignment.end : MainAxisAlignment.start,
          //   children: <Widget>[
          //     TextButton(
          //       onPressed: () {
          //           Get.to(() => ForgetPassword());
          //       },
          //       child: Text(
          //         'forgot_password'.tr,
          //         style: Theme.of(context)
          //             .textTheme
          //             .subtitle1!
          //             .copyWith(color: kBlack.withOpacity(0.5), fontWeight: kFontWeightNormal, fontFamily: kFontFamily),
          //       ),
          //     ),
          //   ],
          // ),
          
          //space
          SizedBox(height: space),
          FadeSlideTransition(
            animation: animation,
            additionalOffset: 2 * space,
            child: Obx(() => CustomButton(
              isLoding: controller.loading.value,
              color: kBlue,
              textColor: kWhite,
              text: 'login'.tr,
              onPressed: () {
                controller.loginButtonClicked();
              },
            ),)
          ),
          SizedBox(height: 2 * space),
          Directionality(
            textDirection: TextDirection.ltr,
            child: FadeSlideTransition(
              animation: animation,
              additionalOffset: 3 * space,
              child: CustomButton(
                color: kWhite,
                textColor: kBlack.withOpacity(0.5),
                text: 'google'.tr,
                image: const Image(
                  image: AssetImage(kGoogleLogoPath),
                  height: 48.0,
                ),
                onPressed: () {
                  //show loading dialog
                  Get.dialog(
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                  var registerController = Get.put(RegisterController());
                  registerController.signInWithGoogle();
                },
              ),
            ),
          ),
          SizedBox(height: space),
          FadeSlideTransition(
            animation: animation,
            additionalOffset: 4 * space,
            child: TextButton(
              onPressed: () {
                Get.to(() => RegisterView());
              },
              child: Text(
                'dont_have_account'.tr,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: kBlack.withOpacity(0.5), fontWeight: kFontWeightNormal, fontFamily: kFontFamily),
              ),
            )
          ),
        ],
      ),
    );
  }
}
