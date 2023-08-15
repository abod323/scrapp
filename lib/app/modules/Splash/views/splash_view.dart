import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sacrapapp/app/modules/Home/views/home_view.dart';
import 'package:sacrapapp/app/modules/Home/views/nav_home.dart';
import 'package:sacrapapp/app/modules/Login/views/login_view.dart';
import 'package:sacrapapp/app/modules/onBording/views/on_bording_view.dart';

import '../../../data/api/api_clinet.dart';
import '../controllers/splash_controller.dart';

class SplashView extends StatefulWidget  {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
ApiClinet apiClinet = Get.find<ApiClinet>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      // check first time shared pref
      if(apiClinet.sharedPreferences.getBool('firstTime')==null){
        Get.offAll(() => const OnBordingView());
      }else if(apiClinet.sharedPreferences.getString('token')==null){
        Get.offAll(() => const LoginView());

      }
      else{
        Get.offAll(() => const NavHome());
      }
     
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Container(
        width: Get.width,
        height: Get.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
         
            // Image.asset('assets/images/logo.png',height: 200,width: 200,),
            const SizedBox(height: 20,),
            const Text('FADH',style: TextStyle(fontSize: 30,fontWeight:FontWeight.bold,color:Colors.amber),),
            //beutifull progress
            const SizedBox(height: 20,),
            const CircularProgressIndicator(
              color: Colors.amber,
            ),
          ],
        ),
      ),
    );
  }
}
