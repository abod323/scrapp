import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

import '../../../widget/custom_textfield.dart';
import '../../Home/views/home_view.dart';
import '../../Login/views/login_view.dart';
import '../../Login/widgets/custom_button.dart';
import '../controllers/register_controller.dart';
import '../../../routes/app_pages.dart';
import '../../../widget/styles.dart';


class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> with TickerProviderStateMixin {
  late final AnimationController _backgroundAnimationController;
  late final AnimationController _formAnimationController;
  late final Animation<double> _backgroundAnimation;
  late final Animation<double> _formAnimation;
  late final Animation<double> _logoAnimation;

  final controller = Get.put(RegisterController());

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
                  
                    const SizedBox(height: 40),
                    _buildLogo(),
                    const SizedBox(height: 40),
                    _buildRegisterForm(),
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

  Widget _buildRegisterForm() {
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
                'register'.tr,
                style: robotoBold.copyWith(fontSize: 24, color: Colors.black87),
              ),
              const SizedBox(height: 20),
              CustomTextfield(
                borderWidth: 1,
                label: 'name'.tr,
                controller: controller.nameController,
                prefixIcon: Icons.person,
              ),
             
              const SizedBox(height: 16),
              CustomTextfield(
                borderWidth: 1,
                label: 'phone'.tr,
                hint:'05xxxxxxxx',
                controller: controller.phoneController,
                prefixIcon: Icons.phone,
              ),
              //  const SizedBox(height: 16),
              // CustomTextfield(
              //   borderWidth: 1,
              //   label: 'address'.tr,
              //   controller: controller.addressController,
              //   prefixIcon: Icons.location_on,
              // ),
              // // city
              // const SizedBox(height: 16),
              // CustomTextfield(
              //   borderWidth: 1,
              //   label: 'city'.tr,
              //   controller: controller.cityController,
              //   prefixIcon: Icons.location_city,
              // ),
              // const SizedBox(height: 16),
              // CustomTextfield(
              //   borderWidth: 1,
              //   label: 'password'.tr,
              //   controller: controller.passwordController,
              //   prefixIcon: Icons.lock,
              //   isPassword: true,
              // ),
              const SizedBox(height: 24),
              CustomButton(
                color: const Color(0xffffc200),
                text: 'sign_up'.tr,
                onPressed: () => controller.RegisterButtonClicked(),
                textColor: Colors.white,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('have_account'.tr, style: robotoRegular),
                  TextButton(
                    onPressed: () => Get.to(() => LoginView()),
                    child: Text(
                      'login'.tr,
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
          Color.fromARGB(255, 234, 200, 70),
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