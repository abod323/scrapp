import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:sacrapapp/app/widget/styles.dart';

class CustomTextfield extends StatefulWidget {
 final String? hint;
  final String? label;
  final String? error;
   bool? isObscure;
   final bool? isPassword;
  final bool? isEnable;
  final bool? isReadOnly;
  final bool? isAutoFocus;
  final bool? isShowPrefixIcon;
  final bool? isShowSuffixIcon;
  final bool? isShowCounterText;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final int? maxLengthEnforced;
  final int? counterText;
  final double? width;
  final double? height;
  final double? radius;
  final double? fontSize;
  final double? prefixIconSize;
  final double? suffixIconSize;
  final double? borderWidth;
  final double? contentPadding;
  final double? prefixIconPadding;
  final double? suffixIconPadding;
  final double? prefixIconSpacing;
  final double? suffixIconSpacing;
  final double? contentHorizontalPadding;
  final double? contentVerticalPadding;
  final double? contentPaddingAll;
  final double? contentPaddingHorizontal;
  //keyb
  final TextInputType? keyboardType;
  //icon 
  final IconData? prefixIcon;
  //controller
  final TextEditingController? controller;

   CustomTextfield({super.key, this.hint, this.label, this.error, this.isObscure, this.isEnable, this.isReadOnly, this.isAutoFocus, this.isShowPrefixIcon, this.isShowSuffixIcon, this.isShowCounterText, this.maxLength, this.maxLines, this.minLines, this.maxLengthEnforced, this.counterText, this.width, this.height, this.radius, this.fontSize, this.prefixIconSize, this.suffixIconSize, this.borderWidth, this.contentPadding, this.prefixIconPadding, this.suffixIconPadding, this.prefixIconSpacing, this.suffixIconSpacing, this.contentHorizontalPadding, this.contentVerticalPadding, this.contentPaddingAll, this.contentPaddingHorizontal, this.controller, this.prefixIcon, this.keyboardType, this.isPassword});

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  var hidePassword=true;
  @override
  Widget build(BuildContext context) {
  
    return TextField(
      controller: widget.controller,
      obscureText: widget.isObscure??false,
      enabled: widget.isEnable??true,
      readOnly: widget.isReadOnly??false,
      autofocus: widget.isAutoFocus??false,
      maxLength: widget.maxLength,
      keyboardType: widget.keyboardType??TextInputType.text,
      style: robotoRegular.copyWith(fontSize: widget.fontSize??16),
      decoration: InputDecoration(
        hintStyle:robotoRegular.copyWith(fontSize: widget.fontSize??16),
        labelStyle: robotoRegular.copyWith(fontSize: widget.fontSize??16),
        
        hintText: widget.hint,
        labelText: widget.label,
        errorText: widget.error,
        counterText: widget.isShowCounterText == true ? widget.counterText.toString() : null,
        prefixIcon: widget.isShowPrefixIcon == true ? Icon(widget.prefixIcon) : null,
        suffixIcon:widget.isPassword==true? IconButton(
          icon: Icon(hidePassword == true ? Icons.visibility_off : Icons.visibility),
          onPressed: () {
            setState(() {
              hidePassword = !hidePassword;
              widget.isObscure = hidePassword;
            });
          },
        ) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radius??15),
          borderSide: BorderSide(
            width: widget.borderWidth!,
          ),
        ),
        contentPadding: EdgeInsets.all(widget.contentPadding??10),
         
        prefixIconConstraints: BoxConstraints(
          minWidth: widget.prefixIconSize??0,
          minHeight: widget.prefixIconSize??0,
        ),
        suffixIconConstraints: BoxConstraints(
          minWidth: widget.suffixIconSize??0,
          minHeight: widget.suffixIconSize??0,
        ),
  
      
      ),
    );
  }
}