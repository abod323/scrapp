import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sacrapapp/app/modules/Home/views/home_view.dart';
import 'package:sacrapapp/app/modules/Login/views/forget_password.dart';

import '../../../routes/app_pages.dart';
import '../../../util/get_di.dart';
import '../../../widget/custom_appbar.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/custom_textfield.dart';
import '../../../widget/styles.dart';
import '../../Home/views/nav_home.dart';
import '../../Register/views/register_view.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar.buildAppBar(context, 'login'.tr,
            isShowBackButton: Get.arguments != null && Get.arguments[0] == true
                ? true
                : false),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const SizedBox(
                height: 40,
              ),
              Text(
                'FADH',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: Colors.amber),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextfield(
                  borderWidth: 1,
                  controller: controller.emailController,
                  hint: 'email'.tr,
                  label: 'email'.tr,
                  contentPadding: 10,
                  prefixIconPadding: 10,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextfield(
                  borderWidth: 1,
                  hint: 'password'.tr,
                  controller: controller.passwordController,
                  label: 'password'.tr,
                  contentPadding: 10,
                  prefixIconPadding: 10,
                  width: 400,
                  isObscure: true,
                  isPassword: true,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                width: 350,
                isEnable: !controller.loading.value,
                radius: 25,
                fontSize: 18,
                isLoding: controller.loading,
                text: 'login'.tr,
                onPressed: () {
                  controller.loginButtonClicked();
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Get.arguments != null && Get.arguments[0] == true
                  ? Container()
                  :
                  //guest login text button
                  TextButton(
                      onPressed: () {
                        controller.autoRepo!.saveUserEmailAndName('', 'Guest');
                        Get.offAll(() => NavHome());
                        AppDi.init();
                      },
                      child: Text('continue_as_guest'.tr,
                          style: robotoRegular.copyWith(
                              color: Colors.amber,
                              ))),

              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                        onPressed: () {
                          Get.to(() => ForgetPassword());
                        },
                        child: Text('forgot_password'.tr,
                            style: robotoRegular.copyWith(
                                color: Colors.grey[600],
                                decoration: TextDecoration.underline))),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              RichText(
                  text: TextSpan(
                      text: 'dont_have_account'.tr,
                      style: robotoRegular.copyWith(color: Colors.grey[600]),
                      children: [
                    TextSpan(
                        text: ' ' + 'sign_now'.tr,
                        style: robotoRegular.copyWith(
                            color: Colors.amber[600],
                            decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.to(() => RegisterView());
                          })
                  ])),

              const SizedBox(
                height: 20,
              ),
              //change language
              Obx(() => controller.language.value == 'en'
                  ? TextButton(
                      onPressed: () {
                        controller.language.value = 'ar';
                        Get.updateLocale(Locale('ar'));
                      },
                      child: Text(
                        'عربي',
                        style: robotoRegular.copyWith(
                            color: Colors.amber[600],
                            decoration: TextDecoration.underline),
                      ))
                  : TextButton(
                      onPressed: () {
                        controller.language.value = 'en';
                        Get.updateLocale(Locale('en'));
                      },
                      child: Text(
                        'English',
                        style: robotoRegular.copyWith(
                            color: Colors.amber[600],
                            decoration: TextDecoration.underline),
                      )))
            ]),
          ),
        ));
  }
}
