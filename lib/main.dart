import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sacrapapp/app/modules/Splash/views/splash_view.dart';
import 'package:sacrapapp/app/modules/onBording/views/on_bording_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/language/langauge.dart';
import 'app/modules/Login/views/login_view.dart';
import 'app/util/get_di.dart';
import 'app/util/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  AppDi.init().then((value) {
    language.value = AppDi.getLocale();
    runApp(MyApp());
  });

 
}
var language = 'ar'.obs;
 
class MyApp extends StatelessWidget {
  const MyApp({super.key});
   
  //get language from shared pref
 
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false, //remove debug banner
      locale: Locale(language.value),
      theme: ThemeData(
        //themeColor
        primarySwatch: Colors.amber,
        useMaterial3: false,
      ),
      translations: LanguageTr(),
      home: const   SplashView(),
    );
  }
}

