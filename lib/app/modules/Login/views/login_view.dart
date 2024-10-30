import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dart:math' as math;

import '../../../widget/custom_textfield.dart';
import '../../Home/views/home_view.dart';
import '../../Register/views/register_view.dart';
import '../controllers/login_controller.dart';
import '../../../routes/app_pages.dart';
import '../../../util/get_di.dart';
import '../../../widget/styles.dart';
import '../../Home/views/nav_home.dart';
import '../widgets/custom_button.dart';
class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with TickerProviderStateMixin {
  late final AnimationController _backgroundAnimationController;
  late final AnimationController _formAnimationController;
  late final Animation<double> _backgroundAnimation;
  late final Animation<double> _formAnimation;
  late final Animation<double> _logoAnimation;

  final controller = Get.put(LoginController());

  @override
  void initState() {
    super.initState();
    _backgroundAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    _formAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _backgroundAnimation = Tween<double>(begin: 0, end: 2 * math.pi).animate(_backgroundAnimationController);
    _formAnimation = CurvedAnimation(parent: _formAnimationController, curve: Curves.easeInOut);
    _logoAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _formAnimationController,
        curve: const Interval(0, 0.5, curve: Curves.easeOut),
      ),
    );

    _formAnimationController.forward();
  }

  @override
  void dispose() {
    _backgroundAnimationController.dispose();
    _formAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildAnimatedBackground(),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      //skip btn
                    TextButton(
                      
                      onPressed: () {
                       controller.autoRepo!.saveUserEmailAndName('', 'Guest');
                        Get.offAll(() => NavHome());
                        AppDi.init();},
                      child: Text('skip'.tr),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    const SizedBox(height: 40),
                    _buildSkipButton(),
                    const SizedBox(height: 20),
                    _buildLogo(),
                    const SizedBox(height: 40),
                    _buildLoginForm(),
                    const SizedBox(height: 20),
                    _buildLanguageToggle(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedBackground() {
    return AnimatedBuilder(
      animation: _backgroundAnimation,
      builder: (context, child) {
        return CustomPaint(
          painter: BackgroundPainter(_backgroundAnimation.value),
          child: Container(),
        );
      },
    );
  }

  Widget _buildSkipButton() {
    if (Get.arguments != null && Get.arguments[0] == true) {
      return Container();
    }
    return Align(
      alignment: Alignment.topRight,
      child: TextButton(
        onPressed: () {
          controller.autoRepo!.saveUserEmailAndName('', 'Guest');
          Get.offAll(() => NavHome());
          AppDi.init();
        },
        child: Text(
          'skip'.tr,
          style: robotoRegular.copyWith(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return ScaleTransition(
      scale: _logoAnimation,
      child: Center(
        child: Image.asset(
          'assets/images/logofadh.png',
          height: 120,
       
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return FadeTransition(
      opacity: _formAnimation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.5),
          end: Offset.zero,
        ).animate(_formAnimation),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'login'.tr,
                style: robotoBold.copyWith(fontSize: 24, color: Colors.black87),
              ),
              const SizedBox(height: 20),
              CustomTextfield(
              
                borderWidth: 1,
                label: 'phone'.tr,
                hint:'05xxxxxxxx',
                controller: controller.phoneController,
                prefixIcon: Icons.email,
              ),
              // const SizedBox(height: 16),
              // CustomTextfield(
              //   label: 'password'.tr,
              //   controller: controller.passwordController,
              //   prefixIcon: Icons.lock,
              //   isPassword: true,
              // ),
              const SizedBox(height: 24),
              CustomButton(
                color:const Color(0xffffc200),
                text: 'login'.tr,
                onPressed: () => controller.loginButtonClicked(),
                textColor: Colors.white,
              ),
              // const SizedBox(height: 16),
              // Center(
              //   child: TextButton(
              //     onPressed: () => Get.toNamed(Routes.FORGET_PASSWORD),
              //     child: Text(
              //       'forgot_password'.tr,
              //       style: robotoMedium.copyWith(color: Colors.blue),
              //     ),
              //   ),
              // ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('dont_have_account'.tr, style: robotoRegular),
                  TextButton(
                    onPressed: () => Get.to(() => RegisterView()),
                    child: Text(
                      'sign_up'.tr,
                      style: robotoMedium.copyWith(color: Color(0xffffc200)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageToggle() {
    return Center(
      child: Obx(() => TextButton(
        onPressed: () {
          final newLang = controller.language.value == 'en' ? 'ar' : 'en';
          controller.language.value = newLang;
          Get.updateLocale(Locale(newLang));
        },
        child: Text(
          controller.language.value == 'en' ? 'عربي' : 'English',
          style: robotoRegular.copyWith(color: Colors.white),
        ),
      )),
    );
  }
}

class BackgroundPainter extends CustomPainter {
  final double animationValue;

  BackgroundPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [
          Color(0xffffc200),
          Color.fromARGB(255, 234, 179, 2),
          Color.fromARGB(255, 234, 200,70),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final path = Path();
    path.moveTo(0, size.height * 0.7);
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * (0.7 + 0.1 * math.sin(animationValue)),
      size.width * 0.5,
      size.height * (0.7 + 0.1 * math.cos(animationValue)),
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * (0.7 + 0.1 * math.sin(animationValue + math.pi / 2)),
      size.width,
      size.height * 0.7,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}