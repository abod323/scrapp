import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widget/no_internet.dart';

class AppConstants{

static const String APP_NAME = "Flutter Demo";
static const String APP_VERSION = "1.0.0";
static const Token="";
//api
// static const String API_BASE_URL = "http://127.0.0.1:8000/api";
static const String API_BASE_URL = "https://scrap.alhiwri.com/public/api";
//image 
// static const String IMAGE_BASE_URL = "http://127.0.0.1:8000/storage/";
static const String IMAGE_BASE_URL = "https://scrap.alhiwri.com/public/storage/";
//products
static const String PRODUCTS_URI = "/products";
static const String LOGIN_URI = "/auth/login";
static const String REGISTER_URI = "/auth/register";
static const String FORGOT_PASSWORD_URI = "/forgot-password";
static const String VERIFY_CODE_URI = "/code-check";
static const String RESET_PASSWORD_URI = "/reset-password";
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