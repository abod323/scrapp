import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:get/get.dart';

import '../../../widget/styles.dart';
import '../../Cart/views/cart_product.dart';
import '../controllers/order_controller.dart';
import 'order_product_card.dart';

class OrderDetails extends StatefulWidget {
  final int orderId;

  const OrderDetails({super.key, required this.orderId});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  var orderController = Get.put(OrderController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    orderController.getOrderDetails(widget.orderId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('details'.tr,
              style: robotoBold.copyWith(color: Colors.black)),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: Obx(() {
          return orderController.orderDetailsLoding.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : orderController.orderDetails == null
                  ? Center(
                      child: Text('no order found'),
                    )
                  : Column(
                      children: [
                        Expanded(
                            child: Scrollbar(
                          child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: Column(
                                children: [
                                  //image
                                  SizedBox(
                                      height: Get.height * 0.3,
                                      child: Image.asset(orderController
                                                      .orderDetails!
                                                      .order
                                                      .status
                                                      .toString() ==
                                                  "completed" ||
                                              orderController.orderDetails!
                                                      .order.status
                                                      .toString() ==
                                                  "donation"||orderController.orderDetails!.order.status.toString()=="deliverd"
                                          ? 'assets/images/checked.png'
                                          : 'assets/images/delivery-man.gif')),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text(
                                          orderController.orderDetails!.order
                                                      .status
                                                      .toString() ==
                                                  "pending"
                                              ? 'driver_out'.tr
                                              : orderController.orderDetails!
                                                          .order.status
                                                          .toString() ==
                                                      "completed"||orderController.orderDetails!.order.status.toString()=="deliverd"
                                                  ? 'order_completed'.tr
                                                  : orderController
                                                              .orderDetails!
                                                              .order
                                                              .status
                                                              .toString() ==
                                                          "donation"
                                                      ? 'donation_thanks'.tr
                                                      : 'driver_out'.tr,
                                          style: robotoRegular.copyWith(
                                              color: Colors.grey,
                                              fontSize: 14)),
                                    ),
                                  ),
                                  //sizebox
                                  SizedBox(
                                    height: 5,
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.all(8.0),
                                  //   child: Column(
                                  //     crossAxisAlignment: CrossAxisAlignment.start,
                                  //     children: [
                                  //              Row(
                                  //       children: [
                                  //         //order number
                                  //         Expanded(
                                  //           child: Padding(
                                  //             padding: const EdgeInsets.all(8.0),
                                  //             child: Text('order_number'.tr+' '+orderController.orderDetails!.order.id.toString()+"#",style: robotoMedium.copyWith(color: Colors.black)),
                                  //           ),
                                  //         ),
                                  //         //date time with icon
                                  //         Expanded(
                                  //           child: Padding(
                                  //             padding: const EdgeInsets.all(8.0),
                                  //             child: Row(
                                  //               mainAxisAlignment: MainAxisAlignment.end,
                                  //               children: [
                                  //                 Icon(Icons.calendar_today_outlined,color: Colors.grey,size: 16,),
                                  //                 SizedBox(width: 5,),
                                  //                 Text(orderController.formatDate(orderController.orderDetails!.order.createdAt.toString()),style: robotoRegular.copyWith(color: Colors.grey,fontSize: 12)),
                                  //               ],
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       ],
                                  //      ),
                                  //       //sizebox
                                  //         SizedBox(height: 5,),
                                  //       //status
                                  //       Padding(
                                  //         padding: const EdgeInsets.all(8.0),
                                  //         child: Row(
                                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //           children: [
                                  //             Text('status'.tr,style: robotoRegular.copyWith(color: Colors.grey,fontSize: 14)),
                                  //             SizedBox(width: 5,),
                                  //             Row(
                                  //               children: [
                                  //                 //green circle
                                  //                 Icon(Icons.circle,color: Colors.green,size: 9,),

                                  //                 Container(
                                  //                   padding:EdgeInsets.all(5),
                                  //                   decoration: BoxDecoration(
                                  //                     borderRadius: BorderRadius.circular(5),
                                  //                     color: Color.fromARGB(96, 255, 229, 151)
                                  //                   ),
                                  //                   child: Text(orderController.transStatus(orderController.orderDetails!.order.status),style: robotoRegular.copyWith(color: Colors.amber,fontSize: 14))),
                                  //               ],
                                  //             ),
                                  //           ],
                                  //         ),
                                  //       ),

                                  //     ],
                                  //   ),
                                  // ),
                                  Column(children: [
                                    //user details
                                    Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 1,
                                                  blurRadius: 1,
                                                  offset: Offset(0,
                                                      1), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            child: Column(
                                              children: [
                                                //user details
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      //user icon
                                                      Icon(
                                                        Icons.person,
                                                        color: Colors.grey,
                                                        size: 16,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text('user_details'.tr,
                                                          style: robotoRegular
                                                              .copyWith(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize:
                                                                      14)),
                                                    ],
                                                  ),
                                                ),
                                                //sizebox
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                //name
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      Text('name'.tr,
                                                          style: robotoRegular
                                                              .copyWith(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize:
                                                                      14)),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                          orderController
                                                              .orderDetails!
                                                              .user
                                                              .customer
                                                              .name,
                                                          style: robotoRegular
                                                              .copyWith(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      14)),
                                                    ],
                                                  ),
                                                ),
                                                //sizebox
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                //phone
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      Text('phone'.tr,
                                                          style: robotoRegular
                                                              .copyWith(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize:
                                                                      14)),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                          orderController
                                                              .orderDetails!
                                                              .user
                                                              .customer
                                                              .phone,
                                                          style: robotoRegular
                                                              .copyWith(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      14)),
                                                    ],
                                                  ),
                                                ),
                                                //sizebox
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                //address
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      Text('address'.tr,
                                                          style: robotoRegular
                                                              .copyWith(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize:
                                                                      14)),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                          orderController
                                                              .orderDetails!
                                                              .user
                                                              .customer
                                                              .address,
                                                          style: robotoRegular
                                                              .copyWith(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      14)),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ))),
                                  ]),
                                  //sizebox
                                  SizedBox(
                                    height: 5,
                                  ),
                                  //order details
                                  Column(children: [
                                    //user details
                                    Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 1,
                                                  blurRadius: 1,
                                                  offset: Offset(0,
                                                      1), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            child: Column(children: [
                                              //user details
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    //user icon
                                                    Icon(
                                                      Icons.shopping_bag,
                                                      color: Colors.grey,
                                                      size: 16,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text('order_details'.tr,
                                                        style: robotoRegular
                                                            .copyWith(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 14)),
                                                  ],
                                                ),
                                              ),
                                              //sizebox
                                              SizedBox(
                                                height: 5,
                                              ),
                                              //name
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Text('order_number'.tr,
                                                        style: robotoRegular
                                                            .copyWith(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 14)),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                        orderController
                                                            .orderDetails!
                                                            .order
                                                            .id
                                                            .toString(),
                                                        style: robotoRegular
                                                            .copyWith(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14)),
                                                  ],
                                                ),
                                              ),
                                              //sizebox
                                              SizedBox(
                                                height: 5,
                                              ),
                                              //phone
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Text('order_date'.tr,
                                                        style: robotoRegular
                                                            .copyWith(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 14)),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                        orderController.formatDate(
                                                            orderController
                                                                .orderDetails!
                                                                .order
                                                                .createdAt
                                                                .toString()),
                                                        style: robotoRegular
                                                            .copyWith(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14)),
                                                  ],
                                                ),
                                              ),
                                              //sizebox
                                              SizedBox(
                                                height: 5,
                                              ),
                                              //address
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(children: [
                                                    Text('status'.tr,
                                                        style: robotoRegular
                                                            .copyWith(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 14)),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                        orderController
                                                            .transStatus(
                                                                orderController
                                                                    .orderDetails!
                                                                    .order
                                                                    .status),
                                                        style: robotoRegular
                                                            .copyWith(
                                                                color: Colors
                                                                    .amber,
                                                                fontSize: 14)),
                                                  ]))
                                            ]))),
                                  ]),
                                  //products details
                                  Column(children: [
                                    //user details
                                    Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 1,
                                                  blurRadius: 1,
                                                  offset: Offset(0,
                                                      1), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            child: Column(children: [
                                              //user details
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    //user icon
                                                    Icon(
                                                      Icons.shopping_bag,
                                                      color: Colors.grey,
                                                      size: 16,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text('product_details'.tr,
                                                        style: robotoRegular
                                                            .copyWith(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 14)),
                                                  ],
                                                ),
                                              ),
                                              //sizebox
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: ListView.builder(
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemCount: orderController
                                                        .orderDetails!
                                                        .products
                                                        .length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return OrderProductCard(
                                                        product: orderController
                                                            .orderDetails!
                                                            .products[index],
                                                      );
                                                    }),
                                              ),
                                            ]))),
                                    //bill details
                                    Column(children: [
                                      //user details
                                      Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    spreadRadius: 1,
                                                    blurRadius: 1,
                                                    offset: Offset(0,
                                                        1), // changes position of shadow
                                                  ),
                                                ],
                                              ),
                                              child: Column(children: [
                                                //user details
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      //user icon
                                                      Icon(
                                                        Icons.money,
                                                        color: Colors.grey,
                                                        size: 16,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text('bill_details'.tr,
                                                          style: robotoRegular
                                                              .copyWith(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize:
                                                                      14)),
                                                    ],
                                                  ),
                                                ),
                                                //sizebox
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                //sub total
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      Text('subtotal'.tr,
                                                          style: robotoRegular
                                                              .copyWith(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize:
                                                                      14)),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      //rich
                                                      RichText(
                                                        text: TextSpan(
                                                          text: orderController
                                                              .orderDetails!
                                                              .order
                                                              .total
                                                              .toString(),
                                                          style: robotoRegular
                                                              .copyWith(
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                          ),
                                                          children: <TextSpan>[
                                                            TextSpan(
                                                              text:
                                                                  ' ' + 'SR'.tr,
                                                              style:
                                                                  robotoRegular
                                                                      .copyWith(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .amber,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                //sizebox
                                                SizedBox(
                                                  height: 5,
                                                ),

                                                //total
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      Text('total'.tr,
                                                          style: robotoRegular
                                                              .copyWith(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize:
                                                                      14)),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      RichText(
                                                        text: TextSpan(
                                                          text: orderController
                                                              .orderDetails!
                                                              .order
                                                              .total
                                                              .toString(),
                                                          style: robotoRegular
                                                              .copyWith(
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                          ),
                                                          children: <TextSpan>[
                                                            TextSpan(
                                                              text:
                                                                  ' ' + 'SR'.tr,
                                                              style:
                                                                  robotoRegular
                                                                      .copyWith(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .amber,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ]))),
                                    ]),
                                  ]),
                                ],
                              )),
                        ))
                      ],
                    );
        }));
  }
}
