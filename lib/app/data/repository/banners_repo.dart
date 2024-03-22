import 'package:sacrapapp/app/data/api/api_clinet.dart';
import 'package:sacrapapp/app/util/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BannerRepo{
    final ApiClinet apiClinet;
  final SharedPreferences prefs;
  
  BannerRepo({required this.apiClinet,required this.prefs});

  Future getBanners() async {
    final response = await apiClinet.getData(AppConstants.BANNERS_URI,headers: {
      "Content-Type": "application/json",
       'Authorization': 'Bearer ${prefs.getString('token')}'
    });
    print(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load banners');
    }
  }
}