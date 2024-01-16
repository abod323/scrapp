
import 'dart:convert';

import 'package:sacrapapp/app/data/api/api_clinet.dart';
import 'package:sacrapapp/app/util/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/catgory.dart';
import '../model/sub_catgory.dart';

class CategoryRepo {
  final ApiClinet apiClinet;
  final SharedPreferences prefs;
  CategoryRepo({required this.apiClinet, required this.prefs});

  //get categories
  Future<List<Catgories>> getCategories() async {
    final response = await apiClinet.getData(AppConstants.CATEGORY_URI);
    if (response.statusCode == 200) {
      final List<dynamic> categories = catgoriesFromJson(response.body);
      print(categories.length);
      //add all 
      categories.insert(0, Catgories(subCatgories: [],image: 'list.png'
      ,id: 0, nameEn: "All",createdAt: DateTime.now(), updatedAt: DateTime.now(), nameAr: "الكل",));
      return categories as List<Catgories>;
    } else {
      throw Exception('Failed to load categories');
    }
  }
  //get sub categories by category id
  Future<List<Subcatgories>> getSubCategories(int id) async {
    final response = await apiClinet.getData(AppConstants.SUB_CATEGORY_BY_CATEGORY_ID_URI+id.toString());
    print(response.body);
    if (response.statusCode == 200) {
      final List<dynamic> categories = subcatgoriesFromJson(response.body);
      //add all
      categories.insert(0, Subcatgories(id: 0, nameEn: "All", point: 0, createdAt: DateTime.now(), updatedAt: DateTime.now(), categoryId: 0, nameAr: "الكل", nameUrdo: "All", nameBang: "All"));
      print(categories.length);
      return categories as List<Subcatgories>;
    } else {
      throw Exception('Failed to load categories');
    }
  }
  

  
}