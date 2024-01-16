import 'package:flutter/src/widgets/container.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sacrapapp/app/modules/Category/controllers/category_controller.dart';
import 'package:sacrapapp/app/modules/Products/views/products_view.dart';

import '../../../data/model/products.dart';
import '../../../data/repository/product_repo.dart';

class ProductsController extends GetxController {
  ProductRepo productRepo = Get.find<ProductRepo>();
  // List<Products> products = [];
   static const pageSize = 10;


   // PagedController for pagination
  final PagingController<int, Products> pagingController =
      PagingController(firstPageKey: 1);

  // List to store the loaded items
  RxList<Products> products = <Products>[].obs;

  RxBool isLoading = false.obs;
  var isAddToCart = false.obs;
  var selectedCategory = 1.obs;
  var quantity = 1.obs;
  var categoryController = Get.find<CategoryController>();
  @override
  void onInit() {
  
    super.onInit();
    getAllProducts();
       // Add listener to the PagingController
    // pagingController.addPageRequestListener((pageKey) {
    //   // Fetch data for the requested page
      
    //   getProductsByCategoryId(categoryController.selectedCategory.value,pageKey);
    //   getProductsBySubCategoryId(categoryController.selectedSubCategory.value);
    // });

   

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
  // Future<void> getAllProducts() async {
  //   print('get all products');
  //   products.clear();
  //   isLoading.value = true;
  //   products = await productRepo.getAllProducts();
    
  //   update();
  //   isLoading.value = false;
  // }

  Future<void> getAllProducts() async {
  try {
      products.clear();
    isLoading.value = true;
    products.value = await productRepo.getAllProducts();
    update();
    isLoading.value = false;
 
  } catch (error) {
    // Handle error
    print('Error fetching products: $error');
  } 
}

//search product
  Future<void> searchProduct(String search) async {
    products.clear();
    isLoading.value = true;
    products.value = await productRepo.searchProducts(search);
    update();
    isLoading.value = false;
  }

  // Future<void> getAllProducts(int pageKey) async {
  //   print(pageKey);
  //   try {
  
  //     final newItems = await productRepo.getAllProducts(pageKey, pageSize);
 
  //       //     // Check if there are more pages
  //     final bool hasMore = newItems.isNotEmpty && newItems.length!=0;
  
  //     if (hasMore ) {
  //       print('has more');
  //             products.addAll(newItems);
  //       final nextPageKey = pageKey + 1;
  //      pagingController.appendPage(newItems, nextPageKey);
  //     } else {
  //         pagingController.appendPage(newItems, pageKey);
  //     }
  //   } catch (error) {
  //     pagingController.error = error;
  //   }
  // }
  //  Future<void> _fetchProducts(int pageKey) async {
  //   try {
  //     // Set loading to true
  //     isLoading.value = true;

  //     // Fetch data from the repository
  //     final List<Products> newItems = await productRepo.getAllProducts(pageKey,10);

  //     // Check if there are more pages
  //     final bool hasMore = newItems.isNotEmpty;

  //     // If there are more pages, append the items to the list
  //     if (hasMore) {
  //       products.addAll(newItems);
  //       final nextPageKey = pageKey + 1;
  //       pagingController.appendPage(newItems, nextPageKey);
  //     } else {
  //       // If no more pages, mark it as the last page
  //       pagingController.appendPage(newItems, pageKey);
  //     }
  //   } catch (error) {
  //     // Handle error
  //     print('Error fetching products: $error');
  //   } finally {
  //     // Set loading to false
  //     isLoading.value = false;
  //   }
  // }

  //get products by category id
  Future<void> getProductsByCategoryId(int id) async {
    //use paging controller
    products.clear();
    isLoading.value = true;
    products.value = await productRepo.getProductsByCategoryId(id);
    update();
    isLoading.value = false;

  }


  //get products by sub category id
  Future<void> getProductsBySubCategoryId(int id) async {
    products.clear();
    isLoading.value = true;
    products.value = await productRepo.getProductsBySubCategoryId(id);
    update();
    isLoading.value = false;
  }

  //show bottom sheet
  // void productBottomSheet(Products product){
  //   Get.bottomSheet(

  //     Container(
  //       height: 400,
  //       child: ProductsView(product)),
  //     //higet
  //     isScrollControlled: true,

  //   );

  // }

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
