import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../widget/styles.dart';
import '../controllers/loction_controller.dart';

class MapSelect extends StatefulWidget {
  const MapSelect({super.key});

  @override
  State<MapSelect> createState() => MapSelectState();
}

class MapSelectState extends State<MapSelect> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  var location_controller = Get.put(LoctionController());
  
  //current location
  Position? position;

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

  @override
  void initState() {
    super.initState();
     _handleLocationPermission().then((value) {
      if(value){
        Geolocator.getCurrentPosition().then((value) async {
          position = value;
          List<Placemark> placemarks = await placemarkFromCoordinates(position!.latitude, position!.longitude);
          print(placemarks[0].toJson());
          setState(() {
            _kGooglePlex = CameraPosition(
              target: LatLng(position!.latitude, position!.longitude),
              zoom: 14.4746,
            );
            
          });
         _goToCurrentLocation();
          
        });
      }
    });
  }

 CameraPosition? _kGooglePlex;

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(24.746202, 46.715764),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  //moving marker
  Set<Marker> _createMarker() {
    return <Marker>[
      Marker(
          markerId: const MarkerId("marker_1"),
          position: LatLng(position!.latitude, position!.longitude),
          icon: BitmapDescriptor.defaultMarker,
          infoWindow: const InfoWindow(title: "marker_1"))
    ].toSet();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('select_location'.tr,style: robotoBold.copyWith(color: Colors.black)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      
      ),
      bottomSheet: //save
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: (){
                Get.back();
                var address = placemarkFromCoordinates(_kGooglePlex!.target.latitude, _kGooglePlex!.target.longitude);
                address.then((value) {
                  print(value[0].toJson());
                  
                    location_controller.currentAddress.value = value[0].country!+','+value[0].administrativeArea!+','+value[0].locality!;
                
                });
              },
              child: Text('save'.tr,style: robotoBold.copyWith(color: Colors.white),),
              style: ElevatedButton.styleFrom(
                
              ),
            ),
          ),
        ),
      body: Stack(
        children: [
          //map with pin
         GoogleMap(
          zoomControlsEnabled: false,
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex??_kLake,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
           onCameraMove: (CameraPosition _position){
            //  print(position.target);
             setState(() {
               _kGooglePlex=_position;
             });
             //save to shared pref
            SharedPreferences.getInstance().then((value) {
              value.setString('lat', _position.target.latitude.toString());
              value.setString('lng', _position.target.longitude.toString());
            });
           },
            
          ),
          //pin
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 100,
              width: 100,
              
              child: const Icon(
                Icons.location_on,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _goToTheLake,
      //   label: const Text('To the lake!'),
      //   icon: const Icon(Icons.directions_boat),
      // ),
    );
  }

  Future<void> _goToCurrentLocation() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex!));
  }
}