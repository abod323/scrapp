import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:sacrapapp/app/util/app_constant.dart';
import 'package:sacrapapp/app/widget/styles.dart';

import '../modules/Cart/controllers/cart_controller.dart';
import '../modules/Products/controllers/products_controller.dart';
import '../modules/Products/views/products_view.dart';

class ProductCard extends StatelessWidget {
  var controller = Get.put(ProductsController());
  var cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex:1,
      child: Obx((){
       return controller.isLoading.value?
        const Center(child: CircularProgressIndicator()):
        controller.products.isEmpty?
         Center(child: Text("no_products".tr,style: robotoRegular,)):
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
          
          itemCount: controller.products.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
              child: GestureDetector(
                onTap: () {
                //  Get.to(ProductsView(controller.products));
                //   // print(controller.products[index].id);
                controller.productBottomSheet(controller.products[index]);
                },
                child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: Row(
                    children: [
                      //image
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[200],
                        ),
                        child: Image.network(
                          AppConstants.IMAGE_BASE_URL +
                              controller.products[index].image,
                          fit: BoxFit.fill,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.getLocalTitle(controller.products[index]),
                            style: robotoRegular.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 200,
                            child: Text(
                              controller.getLocalDescription(controller.products[index]),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: robotoRegular.copyWith(
                                fontSize: 12,
                                
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                controller.products[index].price.toString(),
                                style: robotoRegular.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[900],
                                ),
                      
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Text(
                                'SR'.tr,
                                style: robotoRegular.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.amber,
                                 
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      //arrow
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            cartController.addToCart(controller.products[index].id,1,int.parse(controller.products[index].price.toString()));
                          },
                          child: Icon(
                            Icons.add_shopping_cart,
                            color: Colors.amber,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
              ),
        );
      })
    );
  }
}