import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:get/get.dart';
import 'package:sacrapapp/app/widget/styles.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height:250,
      child: Column(
        children: [
          //image
          SizedBox(
            height: 150,
            
            child: Image.asset(
              "assets/images/no_internet.png",
              fit: BoxFit.cover,
            ),
          ),
          //sizebox
          SizedBox(
            height: 20,
          ),
          //text
          Text(
            'no_internet'.tr,
            style: robotoRegular,
          ),
        ],
      ),
    );
  }
}