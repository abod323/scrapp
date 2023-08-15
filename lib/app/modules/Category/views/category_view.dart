import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sacrapapp/app/util/app_constant.dart';

import '../../../widget/styles.dart';
import '../../Products/controllers/products_controller.dart';
import '../controllers/category_controller.dart';

class CategoryView extends GetView<CategoryController> {

  var productController = Get.find<ProductsController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.isLoading.value?
      const Center(child: CircularProgressIndicator()):
      Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
             height: 100,
            child: ListView.builder(
             scrollDirection: Axis.horizontal,
             itemCount: controller.categories.length,
             itemBuilder: (context,index){
               //category image and name
               return Padding(
                 padding: const EdgeInsets.all(5),
                 child: Obx(() => GestureDetector(
                   onTap: (){
                    controller.selectedSubCategory.value=0;
                     controller.selectedCategory.value=index;
                     controller.category_id.value=controller.categories[index].id;
                     print(  controller.category_id.value);
                     print(controller.selectedCategory.value);
                     productController.getProductsByCategoryId(controller.categories[index].id);
                     controller.getSubCategories(controller.categories[index].id);
                   },
                   child: Column(
                     children: [
                       Container(
                         height: 50,
                         width: 50,
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                          
                            image: NetworkImage(
                              AppConstants.IMAGE_BASE_URL+controller.categories[index].image,
                              
                            ),
                            fit: BoxFit.cover,
                          ),
                             
                           
                         ),
                         
                       ),
                       const SizedBox(height: 4,),
                       Text(
                         controller.getCategoryName(index),
                         style: robotoRegular.copyWith(
                           fontSize: 12,
                           fontWeight: FontWeight.bold,
                           color: controller.selectedCategory.value==index?Colors.amber:Colors.grey[600],
                         ),
                       ),
                     ],
                   ),
                 ),)
               );
              
             }
            ),
          ),
          //sub category
          Obx(() {
           return controller.isSubLoading.value?
           const Center(child: CircularProgressIndicator()):
            Container(
             height: 50,
             child: ListView.builder(
               scrollDirection: Axis.horizontal,
               itemCount: controller.subcategories.length,
               itemBuilder: (context,index){
                 //category image and name
                 return GestureDetector(
                   onTap: (){
                      controller.selectedSubCategory.value=index;
                     //if all products
                     if(controller.subcategories[index].id==0){
                       productController.getProductsByCategoryId(controller.category_id.value);
                     }
                     else{
                        productController.getProductsBySubCategoryId(controller.subcategories[index].id);
                     }
                   },
                   child: Padding(
                     padding: const EdgeInsets.only(left:5,right: 5),
                     child:Obx(()=> Container(
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(10),
                         color: controller.selectedSubCategory.value==index?Colors.amber.withOpacity(0.3):Colors.grey[200],
                       ),
                       child:Padding(
                         padding: const EdgeInsets.all(5),
                         child: Container(
                           padding: const EdgeInsets.all(5),
                           child: Column(
                             children: [
                              
                               Text(
                                 controller.getSubCategoryName(index),
                                 style: robotoRegular.copyWith(
                                   fontSize: 12,
                               
                                 ),
                               ),
                              //  const SizedBox(height: 4,),
                              //   Text(
                              //    '${controller.subcategories[index].point.toString()} ${'points'.tr}',
                              //    style: TextStyle(
                              //      fontSize: 10,
                                  
                              //    ),
                              //  ),
                             ],
                           ),
                         ),
                       ),
                     ),)
                   ),
                 );
               
               }
             ),
           );
          })
        ],
      ),
    );
    });
  }
}
