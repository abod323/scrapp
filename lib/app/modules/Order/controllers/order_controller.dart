import 'package:get/get.dart';
import 'package:sacrapapp/app/data/model/orders.dart';

import '../../../data/model/order_details.dart';
import '../../../data/repository/order_repo.dart';
import '../views/order_details.dart';

class OrderController extends GetxController {
 Orders? order;
  RxBool isLoading = false.obs;
  var orderDetailsLoding = false.obs;
 OrdersDetails? orderDetails;
 OrderRepo orderRepo= Get.find<OrderRepo>();
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    // getAllOrders();
  
  }


  //get all orders
  Future<Orders> getAllOrders() async {
    isLoading.value = true;
    order = await orderRepo.getOrders();
    isLoading.value = false;
    return order!;
  }

  //stream orders
  Stream<Orders> streamOrders() async* {
    yield* Stream.periodic(Duration(seconds: 3), (_) async {
      return await orderRepo.getOrders();
    }).asyncMap((event) async => await event);
  }
  

  

  //format date 
  String formatDate(String date) {
    DateTime dateTime = DateTime.parse(date);
   var format_date="${dateTime.day}/${dateTime.month}/${dateTime.year}";
   //time
    var format_time="${dateTime.hour}:${dateTime.minute}";
    return format_date+" "+format_time;
  }

  //trans status
  String transStatus(String status) {
    switch (status) {
      case 'pending':
        return 'pending'.tr;
      case 'processing':
        return 'processing'.tr;
      case 'completed':
        return 'completed'.tr;
      case 'cancelled':
        return 'cancelled'.tr;
      case 'failed':
        return 'failed'.tr;
      case 'on_hold':
        return 'on_hold'.tr;
      case 'refunded':
        return 'refunded'.tr;
      case 'donation':
        return 'donation'.tr;
      case 'deliverd':
        return 'deliverd'.tr;
      case 'on_the_way':
        return 'on_the_way'.tr;

      default:
        return 'pending'.tr;
    }
  }

  //get order details
  Future<OrdersDetails> getOrderDetails(int orderId) async {
    orderDetailsLoding.value = true;
    orderDetails = await orderRepo.getOrderDetails(orderId);
    orderDetailsLoding.value = false;
    return orderDetails!;
  }
  

  
}
