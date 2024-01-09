// import 'package:flutter/material.dart';

// import 'package:get/get.dart';
// import 'package:sacrapapp/app/modules/Cart/controllers/cart_controller.dart';
// import 'package:sacrapapp/app/util/app_constant.dart';
// import 'package:sacrapapp/app/widget/custom_button.dart';

// import '../../../data/model/products.dart';
// import '../../../widget/styles.dart';
// import '../controllers/products_controller.dart';

// class ProductsView extends GetView<ProductsController> {
//  final Products products;

//  var controller = Get.put(ProductsController());
// var cartController = Get.put(CartController());
//   ProductsView(this.products);
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(8.0),
   
//        color: Colors.white,
//       child: ListView(
//         children: [
        
//          Container(
//            height: 200,
//            width: 200,
//            decoration: BoxDecoration(
//              borderRadius: BorderRadius.circular(10),
//              color: Colors.grey[200],
//            ),
//            child: Image.network(
//              AppConstants.IMAGE_BASE_URL +
//                  products.image,
//              fit: BoxFit.fill,
//            ),
//          ),
//          const SizedBox(
//            width: 10, 
//          ),

//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    mainAxisAlignment: MainAxisAlignment.start,
//                    children: [
//              Text(controller.getLocalTitle(products),style: robotoRegular.copyWith(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),),
//              Text(controller.getLocalDescription(products),style: robotoRegular.copyWith(
//                 fontSize: 12,
//                  color: Colors.grey,
              
//              ),maxLines:3,),
//              Padding(
//                padding: const EdgeInsets.only(top: 8,bottom: 8),
//                child: Text(products.price.toString()+" "+'SR'.tr,style: robotoRegular.copyWith(
//                 color:Colors.amber,
//                 fontSize: 14,
//                ),),
//              ),
//              //quantity
//              //sizzbox
            
//              Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//                children: [
//                  Text('quantity'.tr +':',style: robotoRegular.copyWith(
//                    fontSize: 14,
//                    fontWeight: FontWeight.bold,
//                   ),), 
//                  const SizedBox(
//                    width: 10,
//                  ),
//                  Container(
//                    height: 35,
//                    width: 35,
//                    decoration: BoxDecoration(
//                      borderRadius: BorderRadius.circular(20),
//                      color: Colors.amber,
//                    ),
//                    child: IconButton(
          
//                      onPressed: () {
//                         if(cartController.getQuantity(products.id).value>1){
//                                     // setState(() {
//                                     //   // cartController.cartlodding.value=true;
//                                     //   quantity--;
//                                     //   cartController.total_price.value=cartController.total_price.value-price;
//                                     //   cartController.cartRepo.updateQuantity(widget.CartId, quantity).then((value)=>cartController.cartlodding.value=false);
                                      
//                                     // });
//                                      print(cartController.getQuantity(products.id));
//                                     cartController.decreaseQuantity(products.id);
//                                   }
//                      },
//                      icon: Icon(Icons.remove,color: Colors.white,size: 20,),
//                    ),
//                  ),
//                  Padding(
//                    padding: const EdgeInsets.all(9.0),
//                    child:  Obx(() => Text(
//                                cartController.cartlodding.value?
//                                 "0":cartController.getQuantity(products.id).value.toString(),
                               
//                                 style: TextStyle(
//                                   fontSize: 17,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.grey[900],
//                                 ),
//                               ),),
//                  ),
//                  Container(
//                    height: 35,
//                    width: 35,
//                    decoration: BoxDecoration(
//                      borderRadius: BorderRadius.circular(20),
//                      color: Colors.amber,
//                    ),
//                    child: IconButton(
//                      onPressed: () {
//                      if(cartController.getQuantity(products.id).value==0){
//                                     //add to cart
//                                      cartController.increaseQuantity(products.id);
//                                   print(cartController.getQuantity(products.id));
//                                     cartController.addToCart(
                                      
//                                     )
              
                                      
//                                   }
//                                   else{
//                                     //update quantity
//                                     cartController.increaseQuantity(products.id);
                                   
//                                   }
//                      },
//                      icon: Icon(Icons.add,color: Colors.white,size: 20,),
//                    ),
//                  ),
//                ],
//              ),
//              //sizebox
//               const SizedBox(
//                 height: 10,
//               ),
//              //add to cart
//             //  GestureDetector(
//             //    onTap: () {
                
                 
//             //     // cartController.showDialog();
//             //      cartController.addToCart(products.id, cartController.getQuantity(products.id).value,int.parse(products.price)).then((value) => controller.isAddToCart.value = false);
//             //    },
//             //    child: Padding(
//             //      padding: const EdgeInsets.only(left: 12, right: 12, top: 8,bottom: 10),
//             //      child: Center(
//             //        child: CustomButton(
//             //          text: 'add_to_cart'.tr,
//             //          width: 300,
//             //          height: 50,
//             //          fontSize:14,
//             //          isLoding:cartController.isLoading,
//             //          radius: 10,
//             //        ),
//             //      ),
//             //    ),
//             //  ),
//                    ],
//                   ),
//           )
//       ]),
//     );
    
//   }
// }
