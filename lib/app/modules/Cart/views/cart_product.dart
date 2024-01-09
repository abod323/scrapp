import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:get/get.dart';
import 'package:sacrapapp/app/modules/Products/controllers/products_controller.dart';
import 'package:sacrapapp/app/util/app_constant.dart';


import '../../../data/model/cart.dart';
import '../../../widget/styles.dart';
import '../controllers/cart_controller.dart';


class CartProduct extends StatefulWidget {
  final Products products;

  final double total;
  final int CartId;
  const CartProduct({super.key, required this.products, required this.total, required this.CartId});

  @override
  State<CartProduct> createState() => _CartProductState();
}



class _CartProductState extends State<CartProduct> {

  double price=0;
var products_controller=Get.put(ProductsController());


var cartController=Get.put(CartController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
 
    price=double.parse(widget.products.price.toString());
    
  }
  @override
  Widget build(BuildContext context) {
    return 
  
      
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Dismissible(
          background: Container(
            padding: EdgeInsets.only(right: 20),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.red,
            ),
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          key: Key(widget.products.id.toString()),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            cartController.deleteProductFromCart(widget.products.id);
          },
          child: Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: Row(
                    children: [
                      //image
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                              onTap: () {
                                cartController.deleteProductFromCart(widget.products.id);
                              },
                              child: Icon(
                                Icons.close,
                                color: Colors.red,
                                size: 20,
                              ),
                            ),
                      ),
                      
                      Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[200],
                        ),
                        child: Image.network(
                          AppConstants.IMAGE_BASE_URL +
                              widget.products.image.toString(),
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
                          Container(
                            width: 150,
                            child: Text(
                              cartController.getLocalTitle(widget.products),
                              maxLines: 1,
                              
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          // SizedBox(
                          //   width: 150,
                          //   child: Text(
                          //     products.description,
                          //     maxLines: 2,
                          //     overflow: TextOverflow.ellipsis,
                          //     style: robotoRegular.copyWith(color: Colors.grey,fontSize: 12),
                          //   ),
                          // ),
                          Row(
                            children: [
                              Text(
                                widget.products.price.toString(),
                                style: robotoRegular.copyWith(fontSize: 12),
                      
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Text(
                                'SR'.tr,
        
                                style: robotoRegular.copyWith(color:Colors.amber,fontSize:12),
                              ),
                            ],
                          ),
                        ],
                      ),
                      //arrow
                      const Spacer(),
                      //quantity increment and decrement
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
                                   if(cartController.getQuantity(widget.products.id).value>1){
                                  // setState(() {
                                  //   // cartController.cartlodding.value=true;
                                  //   quantity--;
                                  //   cartController.total_price.value=cartController.total_price.value-price;
                                  //   cartController.cartRepo.updateQuantity(widget.CartId, quantity).then((value)=>cartController.cartlodding.value=false);
                                    
                                  // });
                                   print(cartController.getQuantity(widget.products.id));
                                  cartController.decreaseQuantity(widget.products.id);
                                }
                                },
                                child: Icon(
                                  Icons.remove,
                                  size: 20,
                                ),
                              ),
                              Obx(() => Text(
                             cartController.cartlodding.value?
                              "0":cartController.getQuantity(widget.products.id).value.toString(),
                             
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[900],
                              ),
                            ),),
                              GestureDetector(
                                onTap: () {
                                  cartController.increaseQuantity(widget.products.id);
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
    
  }
}