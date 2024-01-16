
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sacrapapp/app/data/repository/auth_repo.dart';
import 'package:sacrapapp/app/modules/Cart/views/payment_type.dart';
import 'package:sacrapapp/app/modules/Cart/views/vehicle_type.dart';
import 'package:sacrapapp/app/widget/user_address.dart';

import '../../../widget/custom_button.dart';
import '../../../widget/styles.dart';
import '../../Login/views/login_view.dart';
import '../controllers/cart_controller.dart';
import 'cart_product.dart';


class CartScreen extends GetView<CartController>{
  
  const CartScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      bottomNavigationBar://contuine button
      Obx(() =>controller.cartlodding.value||controller.cart==null||controller.cart!.cart.isEmpty?
      SizedBox(height:0,):
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.only(left: 10, right: 10,bottom: 10),
          child: CustomButton(
            isLoding: controller.place_loading,
            radius: 15,
            fontSize: 16,
            text: 'place_order'.tr,
            onPressed: () {
              controller.placeOrder('',true);
            },
          ),
        ),
      )
      
      )
      ,

     appBar: AppBar(
        title: Text('cart'.tr,style: robotoBold.copyWith(color: Colors.black)),
        centerTitle: true,
        
        elevation: 0,
        backgroundColor: Colors.white,
           
      ),
      
      body:   Obx(() {
        return controller.cartlodding.value?
          Center(child: CircularProgressIndicator(),):
         Get.find<AuthRepo>().isLogin()?
          controller.cart==null||controller.cart!.cart.isEmpty?
            Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //image
                Container(
                  height: 150,

                  child: Image.asset("assets/images/empty_cart.png", fit: BoxFit.fill,width:200,),
                ),
                //spacer
                SizedBox(height: 10,),
                Text('cart_empty'.tr,style: robotoRegular.copyWith(fontSize: 16,fontWeight: FontWeight.bold),),
              ],
            )):
             Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: UserAddressSelect(),
              ),

              Expanded(
                child: Scrollbar(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(12), physics: BouncingScrollPhysics(),
                    child: Center(
                      child: SizedBox(
                       width: 400,
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                          // // Product
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.cart!.cart.length ,
                            itemBuilder: (context, index) {
                              return CartProduct(
                              products: controller.cart!.cart[index].product,
                             
                              total: controller.cart!.totalPrices,
                              CartId: controller.cart!.cart[index].id,
                              );
                            },
                          ),
                          SizedBox(height: 10,),
                          Container(
                          padding: EdgeInsets.all(10),
                          decoration:
                              BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
                           child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               //my kcalories
                            Text('details'.tr,style: robotoRegular.copyWith(fontWeight:FontWeight.bold),),
                            //Vehicle type
                            SizedBox(height: 5,),
                            Text('vehicle_type'.tr,style: robotoRegular,),
                             SizedBox(height: 2,),
                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                              
                            Flexible(child:  VehicleType()),
                              
                            ]),
                            SizedBox(height: 5,),
                            Text('payment_type'.tr,style: robotoRegular,),
                             SizedBox(height: 2,),
                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                              Flexible(child: PaymentType()),
                            ]),


                      
                            
      
                            ],
                           ),
                         ),
                         
                          SizedBox(height: 15),
                         Container(
                          padding: EdgeInsets.all(10),
                          decoration:
                              BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
                           child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               //my kcalories
                            Text('order_details'.tr,style: robotoRegular.copyWith(fontWeight:FontWeight.bold),),
                            //total kcalories
                            
                         
                            SizedBox(height: 5,),
                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                              Text('max_price'.tr,style: robotoRegular,),
                              Text(controller.max_price+' '+'SR'.tr,style: robotoRegular.copyWith(fontSize: 14),),
                            ]),

                          SizedBox(height: 5,),
                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                              Text('min_price'.tr,style: robotoRegular,),
                              Text(controller.min_price+' '+'SR'.tr,style: robotoRegular.copyWith(fontSize: 14),),
                            ]),
                            
                            SizedBox(height:5),
                         
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                              Text('total'.tr,style: robotoRegular,),
                              Text(controller.total_price.value.toStringAsFixed(2)+' '+'SR'.tr,style: robotoRegular.copyWith(fontSize: 14),),
                            ]),
                         
                            
                            SizedBox(height:5),
                         
                         
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 2),
                              child: Divider(thickness: 1, color: Theme.of(context).hintColor.withOpacity(0.5)),
                            ),
                         
                             Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                              Text('subtotal'.tr,style: robotoRegular,),
                              Text(controller.total_price.value.toStringAsFixed(2)+' '+'SR'.tr,style:robotoRegular.copyWith(fontSize: 14)),
                            ]),
                            ],
                           ),
                         ),

                          SizedBox(height: 10,)


                        ]),
                      ),
                    ),
                  ),
                ),
              ),

              // Padding(
              //   padding: const EdgeInsets.only(bottom: 20),
              //   child: Container(
              //     width: 233,
              //     padding: EdgeInsets.all(3),
              //     child: Text('22'),
              //   ),
              // ),

            ],
          ):
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //image
                Container(
                  height: 200,
                  child: Image.asset("assets/images/order.png", fit: BoxFit.cover,),
                ),
                //spacer
                SizedBox(height: 10,),
                //login button
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: CustomButton(
                   
                    isLoding: false.obs,
                    text: 'login_first'.tr,
                    onPressed: () {
                      Get.to(()=>LoginView(),arguments: [true]);
                    },
                    radius: 10,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          );
      },)

        
      );
    
  }
}
