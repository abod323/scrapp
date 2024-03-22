import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sacrapapp/app/data/model/orders.dart';
import 'package:sacrapapp/app/modules/Settings/controllers/settings_controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/repository/auth_repo.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/styles.dart';
import '../../Login/views/login_view.dart';
import '../controllers/order_controller.dart';
import 'order_details.dart';

class OrderView extends GetView<OrderController> {
  const OrderView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
        //whatssap button
        floatingActionButton: FloatingActionButton(
          onPressed: () {
           //url launch
           var settingsController=Get.put(SettingsController());
           var url =Uri.parse('https://wa.me/${settingsController.appsettings![10].value}');
           launchUrl(url,mode: LaunchMode.externalApplication);
          },
          child:  Image.asset('assets/images/whatsapp.png'),
          backgroundColor: Colors.white,
        ),
      appBar:  AppBar(
        title: Text('my_orders'.tr,style: robotoBold.copyWith(color: Colors.black)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      
      ),
      body: 
         Get.find<AuthRepo>().isLogin()?
          Obx(() {
            return controller.isLoading.value
          ? Center(
              child: CircularProgressIndicator(),
            )
          :
           controller.order!.orders.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       //image
                      SizedBox(
                          height: 200,
                          
                        child: Image.asset('assets/images/order.png',fit: BoxFit.cover,)),
                        //sizebox
                        SizedBox(height: 20,),
                      Text('no_orders'.tr,style: robotoBold,),
                    ],
                  ),
                )
              : StreamBuilder(
                 
                  stream: controller.streamOrders(),
                  builder: (context,AsyncSnapshot<Orders> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        
                        itemCount: snapshot.data!.orders.length,
                        itemBuilder: (context, index) {
                          return Card(
                      child: ListTile(
                        onTap: (){
                          Get.to(()=>OrderDetails(orderId:snapshot.data!.orders[index].id));
                        },
                        //highet
                        contentPadding: EdgeInsets.all(4),
                        title: Text('order_number'.tr+' '+snapshot.data!.orders[index].id.toString()+"#",style: robotoMedium.copyWith(color: Colors.black)),
                        subtitle: Text(controller.formatDate(snapshot.data!.orders[index].createdAt.toString()),style: robotoRegular.copyWith(color: Colors.grey,fontSize: 12)),
                        trailing:Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            padding: EdgeInsets.only(left: 10,right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: snapshot.data!.orders[index].status=='completed'||snapshot.data!.orders[index].status=='donation'?Color.fromARGB(95, 3, 170, 17):Color.fromARGB(96, 255, 229, 151)
                            ),
                            child: Text(controller.transStatus(snapshot.data!.orders[index].status).toUpperCase(),style: robotoRegular.copyWith(color: snapshot.data!.orders[index].status=='completed'||snapshot.data!.orders[index].status=='donation'?
                            Colors.white:Colors.amber
                            ,fontSize: 12))),
                        ),
                      ),
                    );
                        },
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                  });
          }): Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //image
                Container(
                  height: 200,
                  child: Image.asset("assets/images/order.png", fit: BoxFit.cover,),
                ),
                //spacer
                SizedBox(height: 10,),
                //login button
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: CustomButton(
                   
                    isLoding: false.obs,
                    text: 'login_first'.tr,
                    onPressed: () {
                      Get.to(()=>LoginView(),arguments: [true]);
                    },
                    radius: 10,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          )
    );
    
  }
}
