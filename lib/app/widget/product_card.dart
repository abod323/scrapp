import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:sacrapapp/app/data/model/products.dart';
import 'package:sacrapapp/app/util/app_constant.dart';
import 'package:sacrapapp/app/widget/styles.dart';
import 'package:shimmer/shimmer.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../data/model/cart.dart' as cart;
import '../modules/Cart/controllers/cart_controller.dart';
import '../modules/Products/controllers/products_controller.dart';

class ProductCard extends StatelessWidget {
  
  var controller = Get.put(ProductsController());
  var cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Obx((){
     return controller.isLoading.value?
     Container(
  height: 600, // Set a fixed height for the shimmer list
  child: ShimmerProductList(itemCount: 5),
):
     
      controller.products.isEmpty?
      Container(
         height: 600,
        child: Center(child: Text("No Products Found",style: TextStyle(fontSize: 20),))):
      Container(
     
        child: ListView.builder(
          itemCount: controller.products.length,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder:
        (context, index) {
         return  Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
            child: GestureDetector(
              onTap: () {
                // controller.productBottomSheet(item);
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
                          width: 150,
                          child: Text(
                            controller.getLocalDescription(controller.products[index]),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: robotoRegular.copyWith(
                              fontSize: 9,
                              
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
                   //quntity
                   Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 40,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[200],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                               //no less than 1
                                if(cartController.getQuantity(controller.products[index].id).value>1){
                                  // setState(() {
                                  //   // cartController.cartlodding.value=true;
                                  //   quantity--;
                                  //   cartController.total_price.value=cartController.total_price.value-price;
                                  //   cartController.cartRepo.updateQuantity(widget.CartId, quantity).then((value)=>cartController.cartlodding.value=false);
                                    
                                  // });
                                   print(cartController.getQuantity(controller.products[index].id));
                                  cartController.decreaseQuantity(controller.products[index].id);
                                }
                                //check if 0
                                else if(cartController.getQuantity(controller.products[index].id).value==1){
                                  //delete from cart
                                  cartController.decreaseQuantity(controller.products[index].id);
                                  cartController.deleteProductFromCart(controller.products[index].id);
                                }
                               
                              },
                              child: Icon(
                                Icons.remove,
                                size: 20,
                              ),
                            ),
                            Obx(() => Text(
                             cartController.cartlodding.value?
                              "0":cartController.getQuantity(controller.products[index].id).value.toString(),
                             
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[900],
                              ),
                            ),),
                            GestureDetector(
                              onTap: () {
                                
                                     if(cartController.getQuantity(controller.products[index].id).value<=0){
                                       cartController.addToCart(
                                    cart.CartElement(
                                    createdAt: DateTime.now(),
                                    id: controller.products[index].id,
                                    productId: controller.products[index].id,
                                    product: cart.Products(
                                      categoryId:controller.products[index].categoryId,
                                      description: controller.products[index].descriptionEn,
                                      id: controller.products[index].id,
                                      image: controller.products[index].image,
                                      name: controller.products[index].titleEn,
                                      nameAr: controller.products[index].titleAr,
                                      price: controller.products[index].price,
                                      
                                      status: int.parse(controller.products[index].status.toString()),
                                      updatedAt: controller.products[index].updatedAt,
                                      createdAt: controller.products[index].createdAt,
                                      subcategoryId:1,
                                      descriptionAr: controller.products[index].descriptionAr,
                                      descriptionBn: controller.products[index].descriptionBang,
                                      descriptionUr: controller.products[index].descriptionUrdo
                                    ),
                                    quantity: 0,
                                    userId: 0,
                                    updatedAt: DateTime.now(),
                                    price: double.parse(controller.products[index].price.toString(),
                                    )
                                  )
                                  );
                                     }
                                     else{
                                      cartController.increaseQuantity(controller.products[index].id);
                                     }
                                
                              
                                // cartController.getQuantity(controller.products[index].id).value=1;
                                // cartController.cartlodding.value=false;
            
                                    
                                
                               
            
                              },
                              child: Icon(
                                Icons.add,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
              
                  ],
                ),
              ),
            ),
          );
        },
         )
      );
      
    });
  }



}


class ShimmerProductList extends StatelessWidget {
  final int itemCount;

  const ShimmerProductList({required this.itemCount});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return ShimmerProductItem();
      },
    );
  }
}

class ShimmerProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
        child: GestureDetector(
          onTap: () {
            // Handle onTap if needed
          },
          child: Container(
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Row(
              children: [
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
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 150,
                      height: 15,
                      color: Colors.grey[200],
                    ),
                    const SizedBox(height: 5),
                    Container(
                      width: 200,
                      height: 10,
                      color: Colors.grey[200],
                    ),
                    const SizedBox(height: 5),
                    Container(
                      width: 100,
                      height: 10,
                      color: Colors.grey[200],
                    ),
                    const SizedBox(height: 5),
                    Container(
                      width: 50,
                      height: 10,
                      color: Colors.grey[200],
                    ),
                  ],
                ),
                // ... (remaining code)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

