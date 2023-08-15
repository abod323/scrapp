import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sacrapapp/app/data/model/products.dart';
import 'package:sacrapapp/app/modules/Products/controllers/products_controller.dart';

class SearchController extends GetxController {
  //TODO: Implement SearchController

//controller
  var searchController = TextEditingController();
  var productController = Get.put(ProductsController());
  RxList<Products> searchList = <Products>[].obs;
  var loading = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  //serach product
  void searchProduct(String search) {
  
    searchList.clear();
    productController.products.forEach((element) {
      if (element.titleEn.toLowerCase().contains(search.toLowerCase())||
          element.titleAr!.toLowerCase().contains(search.toLowerCase())||
          element.descriptionEn.toLowerCase().contains(search.toLowerCase())||
          element.descriptionAr!.toLowerCase().contains(search.toLowerCase())||
          element.titleBang!.toLowerCase().contains(search.toLowerCase())||
          element.descriptionBang!.toLowerCase().contains(search.toLowerCase())||
          element.titleUrdo!.toLowerCase().contains(search.toLowerCase())||
          element.descriptionUrdo!.toLowerCase().contains(search.toLowerCase())
      ) {
        searchList.add(element);
        
      }
    });

    update();
  }


 
}
