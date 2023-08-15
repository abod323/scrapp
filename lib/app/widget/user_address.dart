import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class UserAddressSelect extends StatefulWidget {
  const UserAddressSelect({super.key});

  @override
  State<UserAddressSelect> createState() => _UserAddressSelectState();
}

class _UserAddressSelectState extends State<UserAddressSelect> {
  Future<bool> _handleLocationPermission() async {
  bool serviceEnabled;
  LocationPermission permission;
  
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Location services are disabled. Please enable the services')));
    return false;
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {   
      ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Text('location_denied'.tr)));
      return false;
    }
  }
  if (permission == LocationPermission.deniedForever) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Location permissions are permanently denied, we cannot request permissions.')));
    return false;
  }
  return true;
}
Position? position;
String currentAddress='';

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _handleLocationPermission().then((value) {
      if(value){
        Geolocator.getCurrentPosition().then((value) async {
          var address = placemarkFromCoordinates(value.latitude, value.longitude);
          //city
            address.then((value) {
              currentAddress = value[0].country!+','+value[0].administrativeArea!+','+value[0].locality!;
              print(currentAddress);
              setState(() {
                
              });
            });
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15,right: 15,top: 5),
      child: Container(
        height:60,
          decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey[200]),
              
          child: Row(
            children: [
                //current location
                const SizedBox(width: 10,),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200],
                  ),
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(width: 10,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'current_location'.tr,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                     currentAddress,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ), 
                //arrow
                const Spacer(),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child:  Icon(Icons.arrow_downward, color: Colors.grey[600],size: 20,),
                // ),
           
            ]
             
          ),
      ),
    );
  }
}