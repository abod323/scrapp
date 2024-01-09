import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import '../../../widget/styles.dart';
import '../controllers/cart_controller.dart';

class VehicleType extends StatefulWidget {
  const VehicleType({super.key});

  @override
  State<VehicleType> createState() => _VehicleTypeState();
}

class _VehicleTypeState extends State<VehicleType> {
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
          hint: Text('vehicle_type'.tr),
          value: cartController.vehicle_type,
          items: <String>['car'.tr, 'truck'.tr, 'motorcycle'.tr,'pick_up'.tr]
              .map((String value) {
            return DropdownMenuItem<String>(
              value:   value ,
              child: Text(value, style: robotoRegular),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              cartController.vehicle_type = value!;
            });
          },
        ),
      ),
    );
  }
}