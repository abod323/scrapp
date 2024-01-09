import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../widget/search_textfield.dart';
import '../../../widget/styles.dart';
import '../controllers/search_controller.dart';
import 'search_product_card.dart';

class SearchView extends StatelessWidget {
  final controller = Get.put(CustomSearchController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text('search'.tr,style: robotoRegular.copyWith(fontSize: 16,fontWeight:FontWeight.bold,color:Colors.black),),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      
      ),
      body: Column(
        children: [
          Expanded(
            child: Scrollbar(child: SingleChildScrollView(
              
              child: Column(
                children: [
                  SearchTextField(),
          
                  Obx(() {
                    return controller.searchList.value.isEmpty?
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(child: Text("no_products".tr,style: robotoRegular,)),
                  ):
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                       physics:
                                                        NeverScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                      itemCount: controller.searchList.length,
                      itemBuilder: (context,index){
                        return SearchProductCard(products: controller.searchList[index],);
                      },
                    
                    ),
                  );
                  })
          
          
          
                ],
              ),
            )),
          )
        ],
      )
    );
  }
}
