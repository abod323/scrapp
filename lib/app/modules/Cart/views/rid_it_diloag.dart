import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:get/get.dart';
import 'package:sacrapapp/app/modules/Cart/controllers/cart_controller.dart';
import 'package:sacrapapp/app/modules/Home/controllers/home_controller.dart';
import 'package:sacrapapp/app/modules/Settings/controllers/settings_controller.dart';
import 'package:sacrapapp/app/widget/custom_button.dart';

import '../../../widget/styles.dart';

class RidItOffDiloag extends StatelessWidget {
  final String price;
  final String mix_price;
 
  final int orderId; 
   RidItOffDiloag({super.key, required this.price, required this.mix_price, required this.orderId});

   var homeController=Get.put(HomeController());
   var cartController=Get.put(CartController());
   var settingController=Get.find<SettingsController>();
  @override
  Widget build(BuildContext context) {
    return Container(
       width:Get.width,
      child: 
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //image
          Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/driver.png'),
                fit: BoxFit.cover
              )
            ),
          ),
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: Get.width*0.8,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[100]
              ),
              child: Text('min_order_not_reached'.tr,textAlign:TextAlign.center,style: robotoBold.copyWith(fontSize: 16,color:Colors.black),)),
          ),
         
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: GestureDetector(
          //     onTap: (){
          //       cartController.updateStatus(orderId, 'donation');
          //     },
          //     child: Text('donition'.tr,style: robotoRegular.copyWith(fontSize: 14,color:Colors.red),)),
          // ),
          //spacer
          SizedBox(height: 10,),
          CustomButton(
            isLoding: cartController.place_loading,
            radius: 15,
            fontSize: 16,
            text: 'rid_it'.tr,
            onPressed: () {
             
              cartController.placeOrder('rid_it',false);
            },
          ),
          //cancel
          SizedBox(height: 10,),
          CustomButton(
            isLoding: cartController.place_loading,
            radius: 15,
            fontSize: 16,
            text: 'cancel'.tr,
            onPressed: () {
              Get.back();
            },
          ),
            SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('agrre_rid_it'.tr,style: robotoRegular.copyWith(color: Colors.grey,fontSize:12),
              textAlign:TextAlign.center,
              ),
            )
        ],
      ));
      
          
  }
}