import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:sacrapapp/app/modules/Search/controllers/search_controller.dart';



import '../modules/Search/views/search_view.dart';

class SearchTextField extends StatefulWidget {
  final bool? isHome;
  const SearchTextField({super.key, this.isHome});

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  //controller
  var customSearchController = Get.put(CustomSearchController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15,right: 15,top: 15),
      child: Container(
       decoration: BoxDecoration(
         borderRadius: BorderRadius.circular(10),
          color: Colors.grey[200],
        ),
       
        child: TextFormField(
          controller:customSearchController.searchController,
          onTap: (){
            if(widget.isHome??false){
              FocusScope.of(context).requestFocus(FocusNode());
              customSearchController.searchController.clear();
              Get.to(()=>SearchView());
             
              //focus to search textfield
              
            }
          },
          onChanged: (value){
            customSearchController.searchProduct(value);
          },
          decoration: InputDecoration(
            
            hintText: 'search'.tr,
            prefixIcon: const Icon(Icons.search),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}