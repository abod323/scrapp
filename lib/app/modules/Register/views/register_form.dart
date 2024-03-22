
import 'package:flutter/material.dart';

//get
import 'package:get/get.dart';
import 'package:sacrapapp/app/modules/Login/widgets/custom_button.dart';
import 'package:sacrapapp/app/modules/Login/widgets/custom_input_field.dart';
import 'package:sacrapapp/app/modules/Login/widgets/fade_slide_transition.dart';
import 'package:sacrapapp/app/modules/Register/controllers/register_controller.dart';
import 'package:sacrapapp/app/util/app_constant.dart';


class RegisterForm extends StatelessWidget {
  final Animation<double> animation;
  var controller =Get.put(RegisterController());

 RegisterForm({
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    final height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final space = height > 650 ? kSpaceM : kSpaceS;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kPaddingL),
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          //create account header
          FadeSlideTransition(
            animation: animation,
            additionalOffset: 0.0,
            child: Text(
              'register'.tr,
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: kBlack, fontWeight: kFontWeightBold, fontFamily: kFontFamily),
            ),
          ),
          SizedBox(height: space),
          //name
          FadeSlideTransition(
            animation: animation,
            additionalOffset: 0.0,
            child: CustomInputField(
              controller: controller.nameController,
              label: 'name'.tr,
              prefixIcon: Icons.person,
              obscureText: false,
              isNumber: false
            ),
          ),
          SizedBox(height: space),
          FadeSlideTransition(
            animation: animation,
            additionalOffset: 0.0,
            child:  CustomInputField(
              controller: controller.phoneController,
              label: 'phone'.tr,
              prefixIcon: Icons.phone_android,
              obscureText: false,
              isNumber: true
            ),
          ),
              SizedBox(height: space),
          //email
          FadeSlideTransition(
            animation: animation,
            additionalOffset: 1 * space,
            child: CustomInputField(
              controller: controller.emailController,
              label: 'email'.tr,
              prefixIcon: Icons.email,
              obscureText: false,
              isNumber: false
            ),
          ),
          SizedBox(height: space),
          //password
          FadeSlideTransition(
            animation: animation,
            additionalOffset: 2 * space,
            child: CustomInputField(
              controller: controller.passwordController,
              label: 'password'.tr,
              prefixIcon: Icons.lock,
              obscureText: true,
              isNumber: false
            ),
          ),
      //address
       SizedBox(height: space),
          FadeSlideTransition(
            animation: animation,
            additionalOffset: 2 * space,
            child: CustomInputField(
              controller: controller.addressController,
              label: 'address'.tr,
              prefixIcon: Icons.location_on,
              obscureText: false,
              isNumber: false
            ),
          ),
 SizedBox(height: space),
          //city
          FadeSlideTransition(
            animation: animation,
            additionalOffset: 2 * space,
            child: CustomInputField(
              controller: controller.cityController,
              label: 'city'.tr,
              prefixIcon: Icons.location_city,
              obscureText: false,
              isNumber: false
            ),
          ),
           
          SizedBox(height: space),
          FadeSlideTransition(
            animation: animation,
            additionalOffset: 3 * space,
            child: Obx(() => CustomButton(
              isLoding: controller.loading.value,
              color: kBlue,
              textColor: kWhite,
              text: 'register'.tr,
              onPressed: () {
                controller.RegisterButtonClicked();
              },
            ),)
          ),
          SizedBox(height: 2 * space),
          FadeSlideTransition(
            animation: animation,
            additionalOffset: 4 * space,
            child: TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(
                'have_account'.tr,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: kBlack.withOpacity(0.5), fontWeight: kFontWeightNormal, fontFamily: kFontFamily),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
