//get important 
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class Alert{

//success alert
static void success(String title,String message){
  Get.snackbar(title, message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      //highet
      snackStyle: SnackStyle.FLOATING,
      colorText: Colors.white);
}

//error alert
static void error(String title,String message){
  Get.snackbar(title, message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white);
}

//loading dialog
static void loading(){
 //dialog with white background
  Get.dialog(Center(child: CircularProgressIndicator(backgroundColor: Colors.white,),),barrierDismissible: false);
}




}