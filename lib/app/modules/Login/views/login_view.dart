import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:phone_text_field/phone_text_field.dart';
import 'package:sacrapapp/app/modules/Home/views/home_view.dart';
import 'package:sacrapapp/app/modules/Login/views/forget_password.dart';
import 'package:sacrapapp/app/modules/Login/widgets/custom_clippers/index.dart';
import 'package:sacrapapp/app/modules/Login/widgets/header.dart';
import 'package:sacrapapp/app/modules/Login/widgets/login_form.dart';
import 'package:sacrapapp/app/util/app_constant.dart';

import '../../../routes/app_pages.dart';
import '../../../util/get_di.dart';
import '../../../widget/custom_appbar.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/custom_textfield.dart';
import '../../../widget/styles.dart';
import '../../Home/views/nav_home.dart';
import '../../Register/views/register_view.dart';
import '../controllers/login_controller.dart';

class LoginView extends StatefulWidget{
  
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with SingleTickerProviderStateMixin{
   late final AnimationController _animationController;
  late final Animation<double> _headerTextAnimation;
  late final Animation<double> _formElementAnimation;
  late final Animation<double> _whiteTopClipperAnimation;
  late final Animation<double> _blueTopClipperAnimation;
  late final Animation<double> _greyTopClipperAnimation;

  final controller = Get.put(LoginController());

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: kLoginAnimationDuration,
    );

    final fadeSlideTween = Tween<double>(begin: 0.0, end: 1.0);
    _headerTextAnimation = fadeSlideTween.animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(
        0.0,
        0.6,
        curve: Curves.easeInOut,
      ),
    ));
    _formElementAnimation = fadeSlideTween.animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(
        0.7,
        1.0,
        curve: Curves.easeInOut,
      ),
    ));

    final clipperOffsetTween = Tween<double>(
      begin: 200,
      end: 0.0,
    );
    _blueTopClipperAnimation = clipperOffsetTween.animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.2,
          0.7,
          curve: Curves.easeInOut,
        ),
      ),
    );
    _greyTopClipperAnimation = clipperOffsetTween.animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.35,
          0.7,
          curve: Curves.easeInOut,
        ),
      ),
    );
    _whiteTopClipperAnimation = clipperOffsetTween.animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.5,
          0.7,
          curve: Curves.easeInOut,
        ),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    resizeToAvoidBottomInset: false,
    backgroundColor: kWhite,
    body: Stack(
      children: <Widget>[
        
        AnimatedBuilder(
          animation: _whiteTopClipperAnimation,
          builder: (_, Widget? child) {
            return ClipPath(
              clipper: WhiteTopClipper(
                yOffset: _whiteTopClipperAnimation.value,
              ),
              child: child,
            );
          },
          child: Container(color: kGrey),
        ),
        AnimatedBuilder(
          animation: _greyTopClipperAnimation,
          builder: (_, Widget? child) {
            return ClipPath(
              clipper: GreyTopClipper(
                yOffset: _greyTopClipperAnimation.value,
              ),
              child: child,
            );
          },
          child: Container(color: kBlue),
        ),
        AnimatedBuilder(
          animation: _blueTopClipperAnimation,
          builder: (_, Widget? child) {
            return ClipPath(
              clipper: BlueTopClipper(
                yOffset: _blueTopClipperAnimation.value,
              ),
              child: child,
            );
          },
          child: Container(color: kWhite),
        ),
        //top right skip
        Get.arguments != null && Get.arguments[0] == true
                  ? Container()
                  :
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(kPaddingM),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextButton(
                      onPressed: () {
                        controller.autoRepo!.saveUserEmailAndName('', 'Guest');
                        Get.offAll(() => NavHome());
                        AppDi.init();
                      },
                      child: Text(
                        'skip'.tr,
                        style: robotoRegular.copyWith(
                            color: Colors.amber[600],
                            ),
                      ))
              ],
            ),
          ),
        ),
        
        //top left 
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(kPaddingM),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
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
                            ),
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
                            ),
                      ))),
            
              ],
            ),
          ),
        ),
          
        
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: kPaddingL),
            child: Column(
              children: <Widget>[
                Header(animation: _headerTextAnimation),
                SizedBox(height: 200 * 0.9),
                Expanded(child: SingleChildScrollView(child: LoginForm(animation: _formElementAnimation))),
              ],
            ),
          ),
        ),
      ],
    ),
  );
  }
}