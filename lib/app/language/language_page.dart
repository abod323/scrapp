import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:get/get.dart';
import 'package:sacrapapp/app/modules/Home/views/home_view.dart';
import 'package:sacrapapp/app/modules/Home/views/nav_home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../util/get_di.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  SharedPreferences? prefs;
  String _selectedLang = "";

  //save language
  void saveLanguage(String code) async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setString("languageCode", code);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _selectedLang = Get.locale!.languageCode;
    });
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          //bar
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios)),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "language".tr,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          //logo
          const SizedBox(
            height: 59,
          ),
          Center(
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                  image: AssetImage("assets/images/on_board_1.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedLang = "en";
                        saveLanguage(_selectedLang);
                      });
                    },
                    child: LangCard("English",_selectedLang=="en"))),
                  //arabic
                  Expanded(child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedLang = "ar";
                        saveLanguage(_selectedLang);
                      });
                    },
                    child: LangCard("العربية",_selectedLang=="ar"))),
                ],
              ),
            ),
            
            
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  //urdu
                  Expanded(child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedLang = "ur";
                        saveLanguage(_selectedLang);
                      });
                    },
                    child: LangCard("اردو",_selectedLang=="ur"))),
                  //bangladesh
                  Expanded(child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedLang = "bn";
                        saveLanguage(_selectedLang);
                      });
                    },
                    child: LangCard("বাংলা",_selectedLang=="bn"))),
                ],
              ),
            ),
             
            //sizebox
            const SizedBox(
              height: 30,
            ),

            //button
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GestureDetector(
                onTap: () {
                  Get.updateLocale(Locale(_selectedLang));
                  //save language
                  saveLanguage(_selectedLang);
                  Get.offAll(() => const NavHome());
                   AppDi.init();
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.amber,
                  ),
                  child: Center(
                    child: Text(
                      "save".tr,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),

        ],
      ),
    );
  }
}

Widget LangCard(String lang,bool isSelect){

  return Column(children: [
    //language card
    Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        height: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[200],
        ),
        child: Row(
          children: [
            //image
            const SizedBox(
              width: 10,
            ),
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200],
              ),
              child: Image.asset(
                "assets/images/lang.png",
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              lang,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const Spacer(),
            isSelect?const Icon(Icons.check_circle,color: Colors.amber,):const SizedBox(),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    ),
  ],);
}