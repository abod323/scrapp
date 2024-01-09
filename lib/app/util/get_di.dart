//get di
import 'package:get/get.dart';
import 'package:sacrapapp/app/modules/Settings/controllers/settings_controller.dart';
import 'package:sacrapapp/app/modules/onBording/controllers/on_bording_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/api/api_clinet.dart';
import '../data/repository/auth_repo.dart';
import '../data/repository/cart_repo.dart';
import '../data/repository/catgory_repo.dart';
import '../data/repository/order_repo.dart';
import '../data/repository/product_repo.dart';
import '../data/repository/settings_repo.dart';
import '../modules/Cart/controllers/cart_controller.dart';
import '../modules/Category/controllers/category_controller.dart';
import '../modules/Loction/controllers/loction_controller.dart';
import '../modules/Login/controllers/login_controller.dart';
import '../modules/Order/controllers/order_controller.dart';
import '../modules/Products/controllers/products_controller.dart';
import '../modules/Profile/controllers/profile_controller.dart';
import '../modules/Register/controllers/register_controller.dart';
import '../modules/Search/controllers/search_controller.dart';
import 'app_constant.dart';


class AppDi {
  static Future<void> init() async {

     final sharedPreferences = await SharedPreferences.getInstance();
    Get.put<SharedPreferences>(sharedPreferences);
    Get.put<ApiClinet>(ApiClinet(appBaseUrl: AppConstants.API_BASE_URL, sharedPreferences: Get.find()));

    //Repository
    Get.put<AuthRepo>(AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
    Get.put<CategoryRepo>(CategoryRepo(apiClinet: Get.find(), prefs: Get.find()));
    Get.put<ProductRepo>(ProductRepo(apiClinet: Get.find(), prefs: Get.find()));
    Get.put<CartRepo>(CartRepo(apiClinet: Get.find(), prefs: Get.find()));
    Get.put<SettingsRepo>(SettingsRepo(apiClinet: Get.find(), prefs: Get.find()));
    Get.put<OrderRepo>(OrderRepo(apiClinet: Get.find(), prefs: Get.find()));
  

    //controller
    Get.put<LoginController>(LoginController());
    Get.put(OnBordingController());
    Get.lazyPut<RegisterController>(() => RegisterController());
    //category
    Get.lazyPut<CategoryController>(() => CategoryController());
    //product
    Get.lazyPut<ProductsController>(() => ProductsController());
    //setting
    Get.lazyPut<SettingsController>(() => SettingsController());
    //cart
    Get.lazyPut<CartController>(() => CartController());
    //order
    Get.lazyPut<OrderController>(() => OrderController());
    //profile
    Get.lazyPut<ProfileController>(() => ProfileController());
    //search
    Get.lazyPut<CustomSearchController>(() => CustomSearchController());
    //location
    Get.lazyPut<LoctionController>(() => LoctionController());



   //call app settings
    Get.find<SettingsController>().appsettings= await Get.find<SettingsRepo>().getAppSettings();
    

    
  }
  

  //get locale from shared pref
  static String getLocale() {
    final sharedPreferences = Get.find<SharedPreferences>();
    if (sharedPreferences.getString('languageCode') == null) {
      return 'en';
    } else {
      return sharedPreferences.getString('languageCode')!;
    }
  }
}