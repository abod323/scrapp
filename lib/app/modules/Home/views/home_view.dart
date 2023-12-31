import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../widget/product_card.dart';
import '../../../widget/search_textfield.dart';
import '../../../widget/user_address.dart';
import '../../Category/views/category_view.dart';
import '../../Search/views/search_view.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        
        body: Column(
          children: [
            //sixebox
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: UserAddressSelect(),
            ),
            SearchTextField(isHome: true),
            SizedBox(height: 5,),
            CategoryView(),
            
            ProductCard(),
            SizedBox(height: 20,),
          ],
        )
      ),
    );
  }
}
