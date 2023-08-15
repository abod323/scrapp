import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sacrapapp/app/modules/Login/views/login_view.dart';

import '../controllers/on_bording_controller.dart';

class OnBordingView extends GetView<OnBordingController> {
  const OnBordingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 50,
        width: Get.width,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                   controller.saveFirstTime();
              },
              child: const Text(
                'Skip',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            Obx(() => Row(
              children: [
                Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                    color: controller.index.value == 0
                        ? Colors.amber
                        : Colors.grey,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                    color: controller.index.value == 1
                        ? Colors.amber
                        : Colors.grey,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                    color: controller.index.value == 2
                        ? Colors.amber
                        : Colors.grey,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ],
            ),),
            TextButton(
              onPressed: () {
                if(controller.index.value!=2){
                  controller.index.value++;
                controller.pageController.animateToPage(
                  controller.index.value,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
                }
                else{
                  //save first time to shared pref
                  controller.saveFirstTime();
          
                }
              },
              child:  Obx(() => Text(
                controller.index.value == 2 ? 'Start' : 'Next',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),),
            ),
          ],
        ),
      ),
   
      body:PageView(
        controller: controller.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Container(
           
            child: SingleChildScrollView(child:onBoardingItem('assets/images/on_board_3.png', 'onboarding_title1'.tr, 'onboarding_subtitle1'.tr),)
          ),
          Container(
            child: SingleChildScrollView(child:onBoardingItem('assets/images/on_board_2.png', 'onboarding_title2'.tr, 'onboarding_subtitle2'.tr),)
          ),
          Container(
            child: SingleChildScrollView(child:onBoardingItem('assets/images/on_board_1.png', 'onboarding_title3'.tr, 'onboarding_subtitle3'.tr),)
          ),
        ],
      )
    );
  }
}

Widget onBoardingItem(String image, String title, String description) {
  return Container(
    height: Get.height,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          image,
          height: 250,
          width: 250,
          fit: BoxFit.fill,
        ),
    
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style:  TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
        ),
      ],
    ),
  );
}
