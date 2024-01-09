import 'package:shared_preferences/shared_preferences.dart';

import '../../util/app_constant.dart';
import '../api/api_clinet.dart';
import '../model/cart.dart';

class CartRepo{
  final ApiClinet apiClinet;
  final SharedPreferences prefs;

  CartRepo({required this.apiClinet,required this.prefs});

  Future<Cart> getCart() async {
    final response = await apiClinet.getData(AppConstants.CART_URI,headers: {
      "Content-Type": "application/json",
       'Authorization': 'Bearer ${prefs.getString('token')}'
    });
    print(response.body);
    if (response.statusCode == 200) {
      final cart = cartFromJson(response.body);
      
      return  cart ;
    } else {
      throw Exception('Failed to load cart');
    }
  }

  //update quantity
  Future updateQuantity(int cartid,int quantity) async {
    final response = await apiClinet.postData('${AppConstants.UPDATE_QUANTITY_URI}$cartid', {
      "quantity": quantity
    },
    headers: {
      "Content-Type": "application/json",
       'Authorization': 'Bearer ${prefs.getString('token')}'
    }

    );
    print(response.body);
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to update quantity');
    }
  }
  Future addToCart(Products product,int quantity) async {
    
 
    final response = await apiClinet.postData(AppConstants.CART_URI, {
      "product_id": product.id,
      "quantity": quantity,
     

    },
    headers: {
      "Content-Type": "application/json",
       'Authorization': 'Bearer ${prefs.getString('token')}'
    }

    );
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to add cart');
    }
  }

  //delete product from cart
  Future deleteProductFromCart(int productId) async {
    final response = await apiClinet.deleteData(AppConstants.DELETE_PRODUCT_FROM_CART_URI+productId.toString(),
    headers: {
      "Content-Type": "application/json",
       'Authorization': 'Bearer ${prefs.getString('token')}'
    }
    );
    print(response.body);
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to delete product from cart');
    }
  }


  
 


}