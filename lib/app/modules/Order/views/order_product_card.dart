import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:get/get.dart';

import '../../../data/model/order_details.dart';
import '../../../util/app_constant.dart';
import '../../../widget/styles.dart';


class OrderProductCard extends StatelessWidget {
 final Product product;

   OrderProductCard({super.key, required this.product});
  String getLocalTitle(Product product) {
    switch (Get.locale!.languageCode) {
      case 'en':
        return product.name;
      case 'ar':
        return product.nameAr??product.name;

      default:
        return product.name;
    }
  }
  //get local description {en,ar,urdo,bangla}
  String getLocalDescription(Product product) {
    switch (Get.locale!.languageCode) {
      case 'en':
        return product.description;
      case 'ar':
        return product.descriptionAr??product.description;
    
      default:
        return product.description;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
              child: GestureDetector(
                onTap: () {
                // //  Get.to(ProductsView(controller.products));
                // //   // print(controller.products[index].id);
                // controller.productBottomSheet(controller.products[index]);
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
                              product.image,
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
                            getLocalTitle(product),
                            style: robotoRegular.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 200,
                            child: Text(
                              getLocalDescription(product),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: product.price.toString(),
                                  style: robotoRegular.copyWith(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: ' '+'SR'.tr,
                                      style: robotoRegular.copyWith(
                                        fontSize: 12,
                                        color: Colors.amber,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //quantity
                              SizedBox(width: 10,),
                              Text(
                                'x'+product.quantity.toString(),
                                style: robotoRegular.copyWith(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                     
                    ],
                  ),
                ),
              ),
            );
  }
}