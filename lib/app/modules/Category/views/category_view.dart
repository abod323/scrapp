import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sacrapapp/app/data/model/catgory.dart';
import 'package:sacrapapp/app/data/model/sub_catgory.dart';
import 'package:sacrapapp/app/util/app_constant.dart';
import 'package:shimmer/shimmer.dart';

import '../../../widget/styles.dart';
import '../../Products/controllers/products_controller.dart';
import '../controllers/category_controller.dart';

class CategoryView extends GetView<CategoryController> {
  var productController = Get.find<ProductsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.isLoading.value
          ? ShimmerCategoryView()
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.categories.length,
                      itemBuilder: (context, index) {
                        return ShimmerCategoryItem(
                          category: controller.categories[index],
                          isSelected: controller.selectedCategory,
                          onPressed: () {
                          
                            controller.selectedSubCategory.value = 0;
                            controller.selectedCategory.value = controller.categories[index].id;
                            controller.category_id.value =
                                controller.categories[index].id;
                            print(controller.category_id.value);
                            print(controller.selectedCategory.value);
                            
                                           //if all products
                            if (controller.categories[index].id == 0) {
                              productController.getAllProducts();
                              controller.getSubCategories(0);
                              
                            } else {
                              productController.getProductsByCategoryId(
                                  controller.categories[index].id);
                                  controller.getSubCategories(controller.categories[index].id);
                                
                            }
                           
                          },
                        );
                      },
                    ),
                  ),
                  //sub category
                  Obx(() {
                    return controller.isSubLoading.value
                        ? ShimmerSubCategoryView()
                        : Container(
                            height: 50,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.subcategories.length,
                              itemBuilder: (context, index) {
                                return Obx(() => ShimmerSubCategoryItem(
                                  subcategory: controller.subcategories[index],
                                  isSelected: controller.selectedSubCategory.value == index?true.obs:false.obs,
                                  onPressed: () {
                                    controller.selectedSubCategory.value = index;
                                  
                                    // //if all products
                                    if (controller.subcategories[index].id == 0) {
                                      productController.getProductsByCategoryId(
                                          controller.category_id.value);
                                    } else {
                                    
                                      productController
                                          .getProductsBySubCategoryId(
                                              controller.subcategories[index].id);
                                       

                                          
                                    }
                                  },
                                ));
                              },
                            ),
                          );
                  })
                ],
              ),
            );
    });
  }
}

class ShimmerCategoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5, // Adjust the count as needed
                itemBuilder: (context, index) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: ShimmerCategoryItemPlaceholder(),
                  );
                },
              ),
            ),
            Container(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5, // Adjust the count as needed
                itemBuilder: (context, index) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: ShimmerSubCategoryItemPlaceholder(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShimmerCategoryItem extends StatelessWidget {
  final Catgories category;
  final RxInt isSelected;
  final VoidCallback onPressed;

  ShimmerCategoryItem({
    required this.category,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Column(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(
                    AppConstants.IMAGE_BASE_URL + category.image,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 4,),
            Obx((){
              return isSelected.value==category.id
                  ? Text(
                Get.locale!.languageCode == 'en'
                    ? category.nameEn
                    : category.nameAr??category.nameEn,
                style: robotoRegular.copyWith(
                  fontSize: 12,
                  color: Colors.amber,
                ),
              )
                  : Text(
                Get.locale!.languageCode == 'en'
                    ? category.nameEn
                    : category.nameAr??category.nameEn,
                style: robotoRegular.copyWith(
                  fontSize: 12,
                  color: Colors.black,
                ),
              );
            } )
          ],
        ),
      ),
    );
  }
}

class ShimmerSubCategoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 50,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5, // Adjust the count as needed
          itemBuilder: (context, index) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: ShimmerSubCategoryItemPlaceholder(),
            );
          },
        ),
      ),
    );
  }
}

class ShimmerCategoryItemPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[200],
            ),
          ),
          const SizedBox(height: 4,),
          Container(
            width: 50,
            height: 10,
            color: Colors.grey[200],
          ),
        ],
      ),
    );
  }
}

class ShimmerSubCategoryItem extends StatelessWidget {
  final Subcatgories subcategory;
  final RxBool isSelected;
  final VoidCallback onPressed;

  ShimmerSubCategoryItem({
    required this.subcategory,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(left:5,right: 5),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isSelected.value ? Colors.amber.withOpacity(0.3) : Colors.grey[200],
          ),
          child:Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  Text(
                    Get.locale!.languageCode == 'en'
                        ? subcategory.nameEn
                        : subcategory.nameAr,
                    style: robotoRegular.copyWith(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ShimmerSubCategoryItemPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:5,right: 5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[200],
        ),
        child:Padding(
          padding: const EdgeInsets.all(5),
          child: Container(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                Container(
                  width: 50,
                  height: 10,
                  color: Colors.grey[200],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}