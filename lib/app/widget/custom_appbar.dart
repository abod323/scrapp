import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:sacrapapp/app/widget/styles.dart';

class CustomAppBar {
 static AppBar buildAppBar(BuildContext context, String title, {bool isShowBackButton = true}) {
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: Text(title, style:  robotoRegular.copyWith(color: Colors.white)),
      leading: isShowBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Get.back();
              },
            )
          : null,
    );
  }
}