import 'package:flutter/src/widgets/container.dart';
import 'package:get/get.dart';
import 'package:sacrapapp/app/modules/Products/views/products_view.dart';

import '../../../data/model/products.dart';
import '../../../data/repository/product_repo.dart';

class ProductsController extends GetxController {
  ProductRepo productRepo = Get.find<ProductRepo>();
  List<Products> products = [];
  RxBool isLoading = false.obs;
  var isAddToCart = false.obs;
  var selectedCategory = 1.obs;
  var quantity = 1.obs;
  @override
  void onInit() {
    super.onInit();
    getAllProducts();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
  //decrement quantity
  void decrementQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }
  //increment quantity
  void incrementQuantity() {
    quantity.value++;
  }

  //get all products
  Future<void> getAllProducts() async {
    print('get all products');
    products.clear();
    isLoading.value = true;
    products = await productRepo.getAllProducts();
    
    update();
    isLoading.value = false;
  }

  //get products by category id
  Future<void> getProductsByCategoryId(int id) async {
    isLoading.value = true;
    products = await productRepo.getProductsByCategoryId(id);
    //check publish status

    update();
    isLoading.value = false;
  }
  //get products by sub category id
  Future<void> getProductsBySubCategoryId(int id) async {
    products.clear();
    isLoading.value = true;
    products = await productRepo.getProductsBySubCategoryId(id);
    update();
    isLoading.value = false;
  }

  //show bottom sheet
  void productBottomSheet(Products product){
    Get.bottomSheet(

      Container(
        height: 450,
        child: ProductsView(product)),
      //higet
      isScrollControlled: true,

    );

  }

  //get local title {en,ar,urdo,bangla}
  String getLocalTitle(Products product) {
    switch (Get.locale!.languageCode) {
      case 'en':
        return product.titleEn;
      case 'ar':
        return product.titleAr??product.titleEn;
      case 'ur':
        return product.titleUrdo??product.titleEn;
      case 'bn':
        return product.titleBang??product.titleEn;
      default:
        return product.titleEn;
    }
  }
  //get local description {en,ar,urdo,bangla}
  String getLocalDescription(Products product) {
    switch (Get.locale!.languageCode) {
      case 'en':
        return product.descriptionEn;
      case 'ar':
        return product.descriptionAr??product.descriptionEn;
      case 'ur':
        return product.descriptionUrdo??product.descriptionEn;
      case 'bn':
        return product.descriptionBang??product.descriptionEn;
      default:
        return product.descriptionEn;
    }
  }


}
