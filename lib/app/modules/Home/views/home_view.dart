import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sacrapapp/app/modules/Banners/views/banners_view.dart';
import 'package:sacrapapp/app/modules/Settings/controllers/settings_controller.dart';
import 'package:url_launcher/url_launcher.dart';

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
        //whatssap button
        floatingActionButton: FloatingActionButton(
          onPressed: () {
           //url launch
           var settingsController=Get.put(SettingsController());
           var url =Uri.parse('https://wa.me/${settingsController.appsettings![10].value}');
           launchUrl(url,mode: LaunchMode.externalApplication);
          },
          child:  Image.asset('assets/images/whatsapp.png'),
          backgroundColor: Colors.white,
        ),
        
        body: ListView(
          children: [
          const SizedBox(height: 20,),
                 
                 SearchTextField(isHome: true),
                 SizedBox(height: 5,),
                 CategoryView(),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: BannersView(),
                 ),
                 ProductCard(),
                 SizedBox(height: 50,)
          ],
        )
      ),
    );
  }
}
