import 'package:flutter/material.dart';
import 'package:sacrapapp/app/util/app_constant.dart';


class CustomInputField extends StatelessWidget {
  final String label;
  final IconData prefixIcon;
  final bool obscureText;
  final bool isNumber;
    final TextEditingController controller;

  const CustomInputField({
    required this.label,
    required this.controller,
    required this.prefixIcon,
    this.obscureText = false,  this.isNumber = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(kPaddingM),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
        ),
        hintText: label,
        hintStyle: TextStyle(
          color: kBlack.withOpacity(0.5),
          fontWeight: FontWeight.w500,
        ),
        prefixIcon: prefixIcon==Icons.phone_android? Directionality(
          textDirection: TextDirection.ltr,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text('+966',style: TextStyle(color: kBlack.withOpacity(0.5),fontWeight: FontWeight.w500,fontSize:16),),
          ),
        ): Icon(
          prefixIcon,
          color: kBlack.withOpacity(0.5),
        ),
      ),
      obscureText: obscureText,
    );
  }
}
