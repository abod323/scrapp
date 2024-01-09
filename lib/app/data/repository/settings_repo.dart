import 'dart:convert';

import 'package:sacrapapp/app/util/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_clinet.dart';
import '../model/app_settings.dart';

class SettingsRepo{
    final ApiClinet apiClinet;
  final SharedPreferences prefs;
  SettingsRepo({required this.apiClinet,required this.prefs});

  //get all settings
  Future getAllSettings() async {
    final response = await apiClinet.getData(AppConstants.SETTINGS_URI);
    print(response.body);
    
    if (response.statusCode == 200) {
      prefs.setString('min_order_price', response.body['settings']['min_order_price'].toString());
      prefs.setString('max_order_price', response.body['settings']['max_order_price'].toString());
      return response.body;
    } else {
      throw Exception('Failed to load settings');
    }
  }

  //get app settings
  Future<List<AppSettings>> getAppSettings() async {
    final response = await apiClinet.getData(AppConstants.APP_SETTINGS_URI);
    print(response.body);
    
    if (response.statusCode == 200) {
      var data =appSettingsFromJson(response.body);
      return data;
    } else {
      throw Exception('Failed to load settings');
    }
  }

  
  
  
  
}