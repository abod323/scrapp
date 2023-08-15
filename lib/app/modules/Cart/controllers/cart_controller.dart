import 'dart:convert';

import 'package:get/get.dart';
import 'package:sacrapapp/app/data/repository/order_repo.dart';
import 'package:sacrapapp/app/data/repository/settings_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/model/cart.dart';
import '../../../data/repository/auth_repo.dart';
import '../../../data/repository/cart_repo.dart';
import '../views/add_to_cart_diloag.dart';

class CartController extends GetxController {
  CartRepo cartRepo = Get.find<CartRepo>();
  Cart? cart;
  RxBool isLoading = false.obs;
  var cartlodding = false.obs;
  var place_loading = false.obs;
  var total_price = 0.obs;
  var max_price=''.obs;
  var min_price=''.obs;
  @override
  void onInit() {
    super.onInit();
    //check login
    if(Get.find<AuthRepo>().isLogin()){
      getCart();
    }
    getMaxOrderPrice();
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

  //add to cart
  Future<void> addToCart(int productId, int quantity,int price) async {
    if(Get.find<AuthRepo>().isLogin()){
      isLoading.value = true;
    //check max order price
    if(total_price.value<int.parse(max_price.value)){
      await cartRepo.addToCart(productId, quantity,price).then((value) {
      //check response
      print(value.body);
      if (value.statusCode == 200) {
        //show dialog
       
        getCart().then((value) {
          showDialog(cart!.totalPrices.toString(),false,0);
          isLoading.value = false;
        }
        );
       
      }
      else{
        isLoading.value = false;
      }
    });
    }
    else{
      Get.showSnackbar(GetSnackBar(
          message: 'max_order_price'.tr,
          duration: Duration(seconds: 3),
        ));
         isLoading.value = false;
    }
    }
    else{
     Get.showSnackbar(GetSnackBar(
          message: 'login_first'.tr,
          duration: Duration(seconds: 3),
          snackPosition: SnackPosition.BOTTOM,
        ));
    }
    
  }

  //get max order price from shared pref
  getMaxOrderPrice()  {
    max_price.value= Get.find<SharedPreferences>().getString('max_order_price').toString();
  }

  //delete product from cart
  Future<void> deleteProductFromCart(int productId) async {
   await cartRepo.deleteProductFromCart(productId).then((value){
      if(value.statusCode==200){
        getCart();
      }
   } );
   
  }
  //show dialog
  void showDialog(String price,bool isPlaced,int orderId) {
    Get.back();
    //show custom dialog
    Get.defaultDialog(
      title:isPlaced?'place_order'.tr:'congratulations'.tr,
      content: AddToCartDialog(price: price,mix_price:Get.find<SharedPreferences>().getString('min_order_price').toString()==null?'0':Get.find<SharedPreferences>().getString('min_order_price').toString(),
      order_placed: isPlaced,orderId:orderId,
      ),
      
    );
  }

  //place order
  Future<void> placeOrder() async {
    place_loading.value = true;
    //CHECK MIN ORDER PRICE
    if(total_price>int.parse(Get.find<SharedPreferences>().getString('min_order_price').toString())){
      //check max order price
      if(total_price<int.parse(Get.find<SharedPreferences>().getString('max_order_price').toString())){
        //place order
        
        await Get.find<OrderRepo>().placeOrder().then((value) {
          print(value.body);
          if (value.statusCode == 200) {
            //show dialog
            Get.back();
            showDialog(total_price.toString(),true,value.body['order_id']);
            getCart();
            place_loading.value = false;
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
      Get.showSnackbar(GetSnackBar(
          message: 'to_complete_order'.tr+ ' '+Get.find<SharedPreferences>().getString('min_order_price').toString()+' '+'SR'.tr,
          duration: Duration(seconds: 3),
        ));
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


}
