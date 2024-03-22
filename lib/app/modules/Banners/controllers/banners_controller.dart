import 'package:get/get.dart';
import 'package:sacrapapp/app/data/model/banners.dart';
import 'package:sacrapapp/app/data/repository/banners_repo.dart';

class BannersController extends GetxController {
  //TODO: Implement BannersController
  //isloding
    BannerRepo bannersRepo = Get.find<BannerRepo>();
  var isLoading = true.obs;
  final count = 0.obs;
  Banners? banners;
  @override
  void onInit() {
    super.onInit();
    getBanners();
  }

  //get banners
  Future<void> getBanners() async {
    isLoading.value = true;
    await bannersRepo.getBanners().then((value) {
     
      //set banners
      banners = bannersFromJson(value);
     
       isLoading.value = false;
    });
 
  }



  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
