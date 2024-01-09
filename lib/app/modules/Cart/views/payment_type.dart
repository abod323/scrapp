import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import '../../../widget/styles.dart';
import '../controllers/cart_controller.dart';

class PaymentType extends StatefulWidget {
  const PaymentType({super.key});

  @override
  State<PaymentType> createState() => _PaymentTypeState();
}

class _PaymentTypeState extends State<PaymentType> {
    var cartController=Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    //drop down button
    return Container(
  
      padding: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text('payment_type'.tr),
          value: cartController.payment_method,
          items: <String>['cash'.tr, 'credit_card'.tr]
              .map((String value) {
            return DropdownMenuItem<String>(
              value:value,
              child: Text(value, style: robotoRegular),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              cartController.payment_method = value!;
            });
          },
        ),
      ),
    );
  }
}