import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:sacrapapp/app/modules/Cart/controllers/cart_controller.dart';
import 'package:sacrapapp/app/modules/Home/controllers/home_controller.dart';
import 'package:sacrapapp/app/widget/custom_button.dart';

import '../../../widget/styles.dart';

class AddToCartDialog extends StatelessWidget {
  final String price;
  final String mix_price;
  final bool? order_placed; 
  final int orderId; 
   AddToCartDialog({super.key, required this.price, required this.mix_price, this.order_placed, required this.orderId});

   var homeController=Get.put(HomeController());
   var cartController=Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return Container(
       width:Get.width,
      child: order_placed??false?
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
              child: Text('order_placed'.tr,textAlign:TextAlign.center,style: robotoBold.copyWith(fontSize: 16,color:Colors.black),)),
          ),
         
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: (){
                cartController.updateStatus(orderId, 'donation');
              },
              child: Text('donition'.tr,style: robotoRegular.copyWith(fontSize: 14,color:Colors.red),)),
          ),
          //spacer
          SizedBox(height: 10,),
          CustomButton(
            isLoding: false.obs,
            radius: 15,
            fontSize: 16,
            text: 'close'.tr,
            onPressed: () {
              Get.back();
            },
          ),
        ],
      ):
      int.parse(mix_price)<int.parse(price)?
      Column(
           mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         
          
          //image
          Container(
            height: 200,
           
            child:Image.asset("assets/images/order.png",fit: BoxFit.cover,),
          ),
          //description
          Container(
            width: Get.width*0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[100]
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("you_earn".tr +' $price ' +'SR'.tr,style: robotoRegular.copyWith(fontSize: 16,color:Colors.red),),
            ),
            //text
            Padding(
              padding: const EdgeInsets.only(left:12.0,right: 12.0),
              child: Text("confirm_order".tr ,style: robotoRegular.copyWith(fontSize: 12,color:Colors.grey),textAlign: TextAlign.center,),
               
            ),
            ],),
          ),
         
         
          //spacer
          SizedBox(height: 10,),
         
          Row(
            children: [
               //continue button or edit button
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButton(isLoding: cartController.place_loading, text: "place_order".tr, onPressed: (){
                    
                    
                    cartController.placeOrder();
                  },radius:10,fontSize: 14,),
                ),
              ),
            
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButton(
                    
                   backgroundColor:Colors.red,
                    isLoding: false.obs, text: "edit_order".tr, onPressed: (){
                    
                    Get.back();
                    homeController.controller.index=1;

                  },radius:10,fontSize: 14,),
                ),
              ),

            ],
          ),
          //button continue
        ],
      ):
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //close button
          
          //image
          Container(
            height: 200,
           
            child:Image.asset("assets/images/login_now.png",fit: BoxFit.cover,),
          ),
          //description
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("you_earn".tr +' $price ' +'SR'.tr,style: robotoRegular.copyWith(fontSize: 16,color:Colors.red),),
          ),
          //text
          Padding(
            padding: const EdgeInsets.only(left:12.0,right: 12.0),
            child: Text("to_complete_order".tr +' $mix_price ' +'SR'.tr,style: robotoRegular.copyWith(fontSize: 16,color:Colors.grey),textAlign: TextAlign.center,),
             
          ),
          //button continue
          //spacer
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(isLoding: false.obs, text: "continue".tr, onPressed: (){
              // Get.find<CartController>().addToCart(products.id, controller.quantity.value);
              Get.back();
            },radius:10,fontSize: 18,),
          ),
        ],
      ),

    
    );
  }
}