import 'package:get/get.dart';
import 'package:sacrapapp/app/data/repository/catgory_repo.dart';

import '../../../data/model/catgory.dart';
import '../../../data/model/sub_catgory.dart';

class CategoryController extends GetxController {
  
  List<Catgories> categories = [];
  List<Subcatgories> subcategories = [];
  CategoryRepo categoryRepo = Get.find<CategoryRepo>();
  //is loading
  RxBool isLoading = false.obs;
  RxBool isSubLoading = false.obs;
  //selected category
  RxInt selectedCategory = 0.obs;
  RxInt selectedSubCategory = 0.obs;
  RxInt category_id= 0.obs;
  @override
  void onInit() {
    super.onInit();
    getCategories();
    getSubCategories(1);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  //get categories
  Future<void> getCategories() async {
    isLoading.value = true;
    categories = await categoryRepo.getCategories();
    update();
    isLoading.value = false;
  }
  //sub categories by category id
  Future<void> getSubCategories(int id) async {
    isSubLoading.value = true;
    subcategories = await categoryRepo.getSubCategories(id);
    update();
    isSubLoading.value = false;
  }

  //get category name by locale
  String getCategoryName(int index) {
    if (Get.locale!.languageCode == 'en') {
      return categories[index].nameEn;
    } else if (Get.locale!.languageCode == 'ar') {
      return categories[index].nameAr??categories[index].nameEn;
  
    } else {
      return categories[index].nameEn;
    }
  }
  //get sub category name by locale
  String getSubCategoryName(int index) {
    if (Get.locale!.languageCode == 'en') {
      return subcategories[index].nameEn;
    } else if (Get.locale!.languageCode == 'ar') {
      return subcategories[index].nameAr==null?subcategories[index].nameEn:subcategories[index].nameAr;
    } else {
      return subcategories[index].nameEn;
    }
  } 
 
 

  
}
