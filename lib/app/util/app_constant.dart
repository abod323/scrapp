import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widget/no_internet.dart';

class AppConstants{

static const String APP_NAME = "Flutter Demo";
static const String APP_VERSION = "1.0.0";
static const Token="";
//api
//main url
static const String BASE_URL = "https://fadh.sa/public";
// static const String API_BASE_URL = "http://192.168.1.105:8000/api";
static const String API_BASE_URL = "https://fadh.sa/public/api";
//image 
// static const String IMAGE_BASE_URL = "http://192.168.1.105:8000/storage/";
static const String IMAGE_BASE_URL = "https://fadh.sa/public/storage/";


//products
static const String PRODUCTS_URI = "/products";
static const String LOGIN_URI = "/auth/login";
static const String REGISTER_URI = "/auth/register";
static const String FORGOT_PASSWORD_URI = "/forgot-password";
static const String VERIFY_CODE_URI = "/code-check";
static const String RESET_PASSWORD_URI = "/reset-password";
//search products
static const String SEARCH_PRODUCTS_URI = "/products/search/";
//products by category id
static const String PRODUCTS_BY_CATEGORY_ID_URI = "/products/category/";
//products by sub category id
static const String PRODUCTS_BY_SUB_CATEGORY_ID_URI = "/products/sub-catgory/";
//category
static const String CATEGORY_URI = "/catgories";
//sub category
static const String SUB_CATEGORY_URI = "/sub-catgories";
//sub category by category id
static const String SUB_CATEGORY_BY_CATEGORY_ID_URI = "/sub-catgories/";
//cart
static const String CART_URI = "/cart";
//delete product from cart
static const String DELETE_PRODUCT_FROM_CART_URI = "/cart/";
//settings
static const String SETTINGS_URI = "/settings";
//order
static const String ORDER_URI = "/order";
//updateStatus
static const String UPDATE_ORDER_STATUS_URI = "/order/";
//customer info
static const String CUSTOMER_INFO_URI = "/auth/customer";
//update quantity
static const String UPDATE_QUANTITY_URI = "/cart/";
//app settings
static const String APP_SETTINGS_URI = "/app-settings";
//otp
static const String OTP_URI = "/otp";
//resend otp
static const String RESEND_OTP_URI = "/resend-otp";

//banners
static const String BANNERS_URI = "/banners";





//show no internet dialog
static noInternetDialog(){
  Get.dialog(
    
    AlertDialog(
      
      title: Text('no_internet'.tr),
      content: NoInternet(),
      actions: [
        TextButton(onPressed: (){
          Get.back();
        }, child: Text('close'.tr))
      ],
    )
  );
}




}

//snackbar
void showSnackbar(String title,String message){
  //custom snackbar
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: kDarkYellow,
    colorText: Colors.white,
    duration: Duration(seconds: 3),
    margin: EdgeInsets.all(8),
    borderRadius: 8,
    isDismissible: true,
    forwardAnimationCurve: Curves.easeOutBack,
    reverseAnimationCurve: Curves.easeInBack,
    animationDuration: Duration(milliseconds: 500),
  );
}

// Colors
const Color kBlue = Colors.amber;
const Color kLightBlue = Colors.amberAccent;
const Color kDarkYellow = Color(0xFFE5A00D);
const Color kWhite = Color(0xFFFFFFFF);
const Color kGrey = Color(0xFFF4F5F7);
const Color kBlack = Color(0xFF2D3243);

// Padding
const double kPaddingS = 8.0;
const double kPaddingM = 16.0;
const double kPaddingL = 32.0;

// Spacing
const double kSpaceS = 8.0;
const double kSpaceM = 16.0;

// Animation
const Duration kButtonAnimationDuration = Duration(milliseconds: 600);
const Duration kCardAnimationDuration = Duration(milliseconds: 400);
const Duration kRippleAnimationDuration = Duration(milliseconds: 400);
const Duration kLoginAnimationDuration = Duration(milliseconds: 1500);

// Assets
const String kGoogleLogoPath = 'assets/images/google_logo.png';


 const String kFontFamily = 'Cairo';
  const FontWeight kFontWeightBold = FontWeight.w700;
  const FontWeight kFontWeightLight = FontWeight.w300;
  const FontWeight kFontWeightNormal = FontWeight.w400;
  const FontWeight kFontWeightSemiBold = FontWeight.w600;
  const FontWeight kFontWeightThin = FontWeight.w200;
  const FontWeight kFontWeightExtraLight = FontWeight.w100;
  const FontWeight kFontWeightExtraBold = FontWeight.w800;










var kFadeSlideTween = Tween<double>(begin: 0.0, end: 1.0);
var kClipperOffsetTween = Tween<double>(begin: Get.height, end: 0.0);



 Animation<double> kHeaderTextAnimation(AnimationController controller) {
  return kFadeSlideTween.animate(
    CurvedAnimation(
      parent: controller,
      curve: const Interval(
        0.0,
        0.6,
        curve: Curves.easeInOut,
      ),
    ),
  );
}

 Animation<double> kFormElementAnimation(AnimationController controller) {
  return kFadeSlideTween.animate(
    CurvedAnimation(
      parent: controller,
      curve: const Interval(
        0.7,
        1.0,
        curve: Curves.easeInOut,
      ),
    ),
  );
}

 Animation<double> kBlueTopClipperAnimation(AnimationController controller) {
  return kClipperOffsetTween.animate(
    CurvedAnimation(
      parent: controller,
      curve: const Interval(
        0.2,
        0.7,
        curve: Curves.easeInOut,
      ),
    ),
  );
}

 Animation<double> kGreyTopClipperAnimation(AnimationController controller) {
  return kClipperOffsetTween.animate(
    CurvedAnimation(
      parent: controller,
      curve: const Interval(
        0.35,
        0.7,
        curve: Curves.easeInOut,
      ),
    ),
  );
}

 Animation<double> kWhiteTopClipperAnimation(AnimationController controller) {
  return kClipperOffsetTween.animate(
    CurvedAnimation(
      parent: controller,
      curve: const Interval(
        0.5,
        0.7,
        curve: Curves.easeInOut,
      ),
    ),
  );
}