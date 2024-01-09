import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:get/get.dart';
import 'package:sacrapapp/app/data/model/products.dart';

import '../../../util/app_constant.dart';
import '../../../widget/styles.dart';
import '../../Cart/controllers/cart_controller.dart';
import '../../Products/controllers/products_controller.dart';

class SearchProductCard extends StatelessWidget {
  final Products products;
  var controller = Get.put(ProductsController());
  var cartController = Get.put(CartController());

   SearchProductCard({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
              child: GestureDetector(
                onTap: () {
                //  Get.to(ProductsView(controller.products));
                //   // print(controller.products[index].id);
                // controller.productBottomSheet(products);

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
                              products.image,
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
                            controller.getLocalTitle(products),
                            
                            style: robotoRegular.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 200,
                            child: Text(
                              controller.getLocalDescription(products),
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
                                products.price.toString(),
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
                            // cartController.addToCart(products);
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
          }

        
        
        
  }
