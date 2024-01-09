import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:get/get.dart';
import 'package:sacrapapp/app/widget/styles.dart';

class CustomButton extends StatelessWidget {
 //button
  final String? text;
  final String? error;
  final bool? isEnable;
  final bool? isShowIcon;
  final bool? isShowProgress;
  final bool? isShowBorder;
  final RxBool isLoding;
  final double? radius;
  final Function()? onPressed;
  final double? width;
  final double? height;
  final double? fontSize;
  final Color? backgroundColor;
   CustomButton({super.key, this.text, this.error, this.isEnable=true, this.isShowIcon, this.isShowProgress, this.isShowBorder, required this.isLoding, this.onPressed, this.width, this.height, this.radius, this.fontSize, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
  
    return Obx(() {
      return GestureDetector(
      onTap: onPressed,
      child:isEnable!? Container(
        width: width,
        height: height??50,
        decoration: BoxDecoration(
          color: backgroundColor??Colors.amber,
          borderRadius: BorderRadius.circular(radius!),
         
        ),
        child: Center(
          child: isLoding.value
              ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
              : Text(
                  text!,
                  style: robotoRegular.copyWith(
                    color: Colors.white,
                    fontSize: fontSize??18,
                    fontWeight: FontWeight.bold),
                ),
        ),
      ):Container(
        width: width,
        height: height??50,
        decoration: BoxDecoration(
          
          borderRadius: BorderRadius.circular(radius!),
          border: Border.all(color: Colors.amber, width: 1) ,
        ),
        child: Center(
          child: isLoding.value
              ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
              : Text(
                  text!,
                  style: robotoRegular.copyWith(
                    color: Colors.amber,
                    fontSize: fontSize??18,
                    fontWeight: FontWeight.bold)
                ),
        ),
      ),
    );
    });
  }
}