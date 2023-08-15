import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:sacrapapp/app/modules/Home/views/home_view.dart';
import 'package:sacrapapp/app/modules/Order/controllers/order_controller.dart';

import '../../../data/repository/auth_repo.dart';
import '../../Cart/views/cart_view.dart';
import '../../Order/views/order_view.dart';
import '../../Settings/views/settings_view.dart';
import '../controllers/home_controller.dart';

class NavHome extends StatefulWidget {
  const NavHome({super.key});

  @override
  State<NavHome> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<NavHome> {

var homeController=Get.put(HomeController());



List<Widget> _buildScreens() {
        return [
         HomeView(),
         CartScreen(),
          OrderView(),
         SettingsView(),
        

        ];
    } 
    
    List<PersistentBottomNavBarItem> _navBarsItems() {
        return [
            PersistentBottomNavBarItem(
                icon: Icon(CupertinoIcons.home),
                title: ('home'.tr),
                activeColorPrimary: Colors.amber,
                inactiveColorPrimary: CupertinoColors.systemGrey,
            ),
            //cart
            PersistentBottomNavBarItem(
                icon: Icon(CupertinoIcons.cart),
                title: ('cart'.tr),
                activeColorPrimary: Colors.amber,
                inactiveColorPrimary: CupertinoColors.systemGrey,
            ),

            //my orders
            PersistentBottomNavBarItem(
              onPressed:(p0) {
              var controller=Get.put(OrderController());
              if(Get.find<AuthRepo>().isLogin()){
              controller.getAllOrders();
              }
              homeController.controller.jumpToTab(2);
              },
                icon: Icon(CupertinoIcons.square_list),
                title: ('my_orders'.tr),
                activeColorPrimary: Colors.amber,
                inactiveColorPrimary: CupertinoColors.systemGrey,
            ),

            PersistentBottomNavBarItem(
                icon: Icon(CupertinoIcons.settings),
                title: ("settings".tr),
                activeColorPrimary: Colors.amber,
                inactiveColorPrimary: CupertinoColors.systemGrey,
            ),
        ];
    }




  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: homeController.controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style4, // Choose the nav bar style with this property.
    );
  }
}