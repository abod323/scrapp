import 'dart:convert';

import 'package:sacrapapp/app/data/api/api_clinet.dart';
import 'package:sacrapapp/app/data/model/cart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../util/app_constant.dart';
import '../model/order_details.dart';
import '../model/orders.dart';

class OrderRepo {

final ApiClinet apiClinet;
  final SharedPreferences prefs;

  OrderRepo({required this.apiClinet,required this.prefs});

 Future<Orders> getOrders() async {
    final response = await apiClinet.getData(AppConstants.ORDER_URI,
    headers: {
       "Content-Type": "application/json",
       'Authorization': 'Bearer ${prefs.getString('token')}'
    }
    
    );
    print(response.body);
    if (response.statusCode == 200) {
      final orders = ordersFromJson(response.body);
   
      return orders ;
    } else {
      throw Exception('Failed to load orders');
    }
  }

  //place order
  Future placeOrder(String payment_method,String vehicle_type,String status,double total,Cart cart) async {
    //get products id and quantity
    List<Map<String, dynamic>> products = [];
    cart.cart.forEach((element) {
      products.add({
        "product_id": element.product.id,
        "quantity": element.quantity,
      });
    });
    
    final response = await apiClinet.postData(AppConstants.ORDER_URI,{
    'payment_method': payment_method,
    'vehicle_type': vehicle_type,
    'total': total,
    'products': jsonEncode(products),
    'status':status
    }
    ,headers: {
       "Content-Type": "application/json",
       'Authorization': 'Bearer ${prefs.getString('token')}'
    },);
    

    print(response.body);
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to place orders');
    }
  }

  //updateStatus
  Future updateStatus(int orderId, String status) async {
    final response = await apiClinet.postData(AppConstants.UPDATE_ORDER_STATUS_URI+orderId.toString(),{
    
      "status": status
    }
    ,headers: {
       "Content-Type": "application/json",
       'Authorization': 'Bearer ${prefs.getString('token')}'
    },);
    

    print(response.body);
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to place orders');
    }
  }

  //get order details
  Future<OrdersDetails> getOrderDetails(int orderId) async {
    final response = await apiClinet.getData(AppConstants.UPDATE_ORDER_STATUS_URI+orderId.toString(),
    headers: {
       "Content-Type": "application/json",
       'Authorization': 'Bearer ${prefs.getString('token')}'
    }
    
    );
    print(response.body);
    if (response.statusCode == 200) {
      final ordersDetails = ordersDetailsFromJson(response.body);
   
      return ordersDetails ;
    } else {
      throw Exception('Failed to load orders details');
    }
  }

  

}