import 'dart:convert';

import 'package:sacrapapp/app/util/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_clinet.dart';
import '../model/products.dart';

class ProductRepo {
 final ApiClinet apiClinet;
 final SharedPreferences prefs;
  ProductRepo({required this.apiClinet, required this.prefs});

  //get all products
  Future<List<Products>> getAllProducts() async {
    final response = await apiClinet.getData(AppConstants.PRODUCTS_URI);
    if (response.statusCode == 200) {
      final List<dynamic> products = productsFromJson(response.body);
      return products as List<Products>;
    } else {
      throw Exception('Failed to load products');
    }
  }
  //search products
  Future<List<Products>> searchProducts(String search) async {
    final response = await apiClinet.getData(AppConstants.SEARCH_PRODUCTS_URI+search);
    if (response.statusCode == 200) {
      final List<dynamic> products = productsFromJson(response.body);
      return products as List<Products>;
    } else {
      throw Exception('Failed to load products');
    }
  }
  //get products by category id
  Future<List<Products>> getProductsByCategoryId(int id) async {
    
    final response = await apiClinet.getData(AppConstants.PRODUCTS_BY_CATEGORY_ID_URI+id.toString());
    if (response.statusCode == 200) {
      //if status is 0 then remove
      final List<dynamic> products = productsFromJson(response.body);
      return products as List<Products>;
    } else {
      throw Exception('Failed to load products');
    }
  }
  //get products by sub category id
  Future<List<Products>> getProductsBySubCategoryId(int id) async {
    final response = await apiClinet.getData(AppConstants.PRODUCTS_BY_SUB_CATEGORY_ID_URI+id.toString());
    if (response.statusCode == 200) {
      final List<dynamic> products = productsFromJson(response.body);
      return products as List<Products>;
    } else {
      throw Exception('Failed to load products');
    }
  }
}
