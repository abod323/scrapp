import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sacrapapp/app/data/repository/order_repo.dart';
import 'package:sacrapapp/app/data/repository/settings_repo.dart';
import 'package:sacrapapp/app/modules/Login/views/login_view.dart';
import 'package:sacrapapp/app/util/alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/model/cart.dart';
import '../../../data/repository/auth_repo.dart';
import '../../../data/repository/cart_repo.dart';
import '../views/add_to_cart_diloag.dart';
import '../views/rid_it_diloag.dart';

class CartController extends GetxController {
  CartRepo cartRepo = Get.find<CartRepo>();
  Cart? cart;
  AuthRepo authRepo= Get.find<AuthRepo>();
  RxBool isLoading = false.obs;
  var cartlodding = false.obs;
  var place_loading = false.obs;
  var total_price = 0.0.obs;
  var max_price=''.obs;
  var min_price=''.obs;
  var payment_method='cash'.tr;
  var vehicle_type='car'.tr;
  @override
  void onInit() {
    super.onInit();
    //check login
    if(Get.find<AuthRepo>().isLogin()){
      getCart();
    }
    getMaxOrderPrice();
    getMinOrderPrice();
  }

  //get cart
  Future<void> getCart() async {
   cartlodding.value = true;
    cart = await cartRepo.getCart().then((value) {
      cartlodding.value = false;
      total_price.value = value.totalPrices;
      return value;
    
    });
    update();
  }

  
  //get quantity by product id
  RxInt getQuantity(int productId) {
    
    if (cart != null) {
      for (var i = 0; i < cart!.cart.length; i++) {
        if (cart!.cart[i].product.id == productId) {
          return cart!.cart[i].quantity.obs;
        }
      }
    }
    return 0.obs;
  }
  //increase quantity by product id
  void increaseQuantity(int productId) {
   cartlodding.value = true;
    if (cart != null) {
      for (var i = 0; i < cart!.cart.length; i++) {
        if (cart!.cart[i].product.id == productId) {
          cart!.cart[i].quantity++;
          total_price.value = total_price.value +double.parse( cart!.cart[i].product.price.toString());
          getQuantity(productId);

        }
       
      }
    }
    cartlodding.value = false;
  }
  //decrease quantity by product id
  void decreaseQuantity(int productId) {
    cartlodding.value = true;
    if (cart != null) {
      for (var i = 0; i < cart!.cart.length; i++) {
        if (cart!.cart[i].product.id == productId) {
          cart!.cart[i].quantity--;
          total_price.value = total_price.value -double.parse( cart!.cart[i].product.price.toString());
          getQuantity(productId); 
        }
      }
    }
    cartlodding.value = false;
  }

  //delete product from cart by cart id
  Future<void> deleteProduct(int productId) async {
    cart!.cart.forEach((element) {
      if (element.product.id == productId) {
        cartRepo.deleteProductFromCart(element.id).then((value) => getCart());
      }
    });

  }


  //add to cart
   addToCart(CartElement cartElement) async {
    //check login
    if(Get.find<AuthRepo>().isLogin()){

        //add to cart
        cartlodding.value = true;
    cart!.cart.add(cartElement);
    increaseQuantity(cartElement.product.id);
      
   
    }
    else{
      //show login dialog
      Get.defaultDialog(
        title: 'login_first'.tr,
        content: Text('login_first'.tr),
        actions: [
          TextButton(onPressed: (){
            Get.back();
            Get.to(()=>LoginView());
          }, child: Text('login'.tr))
        ],
      );
    }
    
  }

  //add to cart api
  Future<void> addToCartApi() async {
    cartlodding.value = true;
    //check login
    if(Get.find<AuthRepo>().isLogin()){
      //check if cart is empty
      if(cart!.cart.isNotEmpty){
        //add to cart
        cart!.cart.forEach((element) {
          cartRepo.addToCart(element.product, element.quantity).then((value) {
            print(value.body);
            if (value.statusCode == 200) {
              
              //show snackbar
             getCart().then((value) => cartlodding.value = false);
              //show snackbar
           
            }
            else{
              cartlodding.value = false;
              //print error
             
            }
          });
         });
    
    
      }
      

      //if cart is empty
      if(cart!.cart.isEmpty){
        cartlodding.value = false;
      }
    }
    else{
      //show login dialog
      Get.defaultDialog(
        title: 'login_first'.tr,
        content: Text('login_first'.tr),
        actions: [
          TextButton(onPressed: (){
            Get.back();
            Get.to(()=>LoginView());
          }, child: Text('login'.tr))
        ],
      );
    }
   
    
  }

  //get max order price from shared pref
  getMaxOrderPrice()  {
    max_price.value= Get.find<SharedPreferences>().getString('max_order_price').toString();
  }
  //get min order price from shared pref
  getMinOrderPrice()  {
    min_price.value= Get.find<SharedPreferences>().getString('min_order_price').toString();
  }

  //delete product from cart
Future<void> deleteProductFromCart(int productId) async {
  cartlodding.value = true;
  print('productId' + productId.toString());
    final response = await cartRepo.deleteProductFromCart(productId).then((value) {
      getCart().then((value) => cartlodding.value = false);
     
    });
    print(response.body);
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to delete product from cart');
    }

}
  //show dialog
  void showDialog(String price,bool isPlaced,int orderId,bool ridti) {
    Get.back();
    //show custom dialog
    Get.defaultDialog(
      title:isPlaced?'place_order'.tr:'congratulations'.tr,
      content: AddToCartDialog(price: price,mix_price:Get.find<SharedPreferences>().getString('min_order_price').toString()==null?'0':Get.find<SharedPreferences>().getString('min_order_price').toString(),
      order_placed: isPlaced,orderId:orderId,
      rid_it: ridti,
      ),
      
    );
  }
  void showRidItDialog(String price,bool isPlaced,int orderId) {
    Get.back();
    //show custom dialog
    Get.defaultDialog(
      title:isPlaced?'place_order'.tr:'congratulations'.tr,
      content: RidItOffDiloag(price: price,mix_price:Get.find<SharedPreferences>().getString('min_order_price').toString()==null?'0':Get.find<SharedPreferences>().getString('min_order_price').toString(),
   orderId:orderId,
      ),
      
    );
  }

  //place order
  Future<void> placeOrder(String statu,bool ridIt) async {
    place_loading.value = true;
    
    //CHECK MIN ORDER PRICE
    
    if(total_price>=int.parse(Get.find<SharedPreferences>().getString('min_order_price').toString())||statu!=''){
      //check max order price
      if(total_price<=int.parse(Get.find<SharedPreferences>().getString('max_order_price').toString())){
        //place order
        
        // //update cart
        // cart!.cart.forEach((element) {
        //   cartRepo.updateQuantity(element.id, element.quantity);
        // });
        //place order
        await Get.find<OrderRepo>().placeOrder(
        payment_method.toLowerCase()=='cash'?'cash on delivery':'bank transfer',vehicle_type.toLowerCase()=='car'?'car':vehicle_type.toLowerCase()=='truck'?'truck':vehicle_type.toLowerCase()=='motorcycle'?'motorcycle':'pick_up',
        statu,total_price.value,cart!
        ).then((value) {
          print(value.body);
          if (value.statusCode == 200) {
            //show dialog
             Get.back();
             //get order id
             int orderId = jsonDecode(value.body['order']['id'].toString());
             print(orderId);
            showDialog(total_price.toString(),true,orderId,ridIt);
            getCart();
            place_loading.value = false;
            
            //show snackbar
           
            place_loading.value = false;
          }
          else{
            place_loading.value = false;
            //print error
           
          }
        });

      }
      else{
        Get.showSnackbar(GetSnackBar(
          message: 'max_order_price'.tr,
          duration: Duration(seconds: 3),
        ));
        place_loading.value = false;
      }
    }
    else{
      showRidItDialog(
    total_price.toString(),true,2
    );
        place_loading.value = false;
    }
  }

  //updateStatus
  Future<void> updateStatus(int orderId, String status) async {
    await Get.find<OrderRepo>().updateStatus(orderId, status).then((value) {
      print(value.body);
      Get.back();
      if (value.statusCode == 200) {
        Get.showSnackbar(GetBar(
          message: 'dontion_success'.tr,
          duration: Duration(seconds: 3),
        ));
      }
    });
  }

    //get local title {en,ar,urdo,bangla}
  String getLocalTitle(Products product) {
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
  String getLocalDescription(Products product) {
    switch (Get.locale!.languageCode) {
      case 'en':
        return product.description;
      case 'ar':
        return product.descriptionAr??product.description;
    
      default:
        return product.description;
    }
  }


}
