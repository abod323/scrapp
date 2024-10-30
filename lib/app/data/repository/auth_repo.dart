import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../util/app_constant.dart';
import '../api/api_clinet.dart';
import '../model/sign_up.dart';

class AuthRepo {
   final ApiClinet apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({required this.apiClient,required this.sharedPreferences});


   Future<Response> registration(SignUpModel signUpBody) async {
    return await apiClient.postData(AppConstants.REGISTER_URI, signUpBody.toJson());
  }

  Future<Response> login({required String email,required String password ,String login_by='google',String? name}) async {
    return await apiClient.postData(AppConstants.LOGIN_URI, {"phone": email,'email':email, "password": password , "login_by":login_by,"name":name});
  }

  //get customer info
  Future<Response> getCustomerInfo() async {
    return await apiClient.getData(AppConstants.CUSTOMER_INFO_URI,
    headers: {
        "Content-Type": "application/json",
      "Authorization": "Bearer ${getToken()}"
      }
    );
  }
  //update customer info
  Future<Response> updateCustomerInfo(String name,String phone,String address,String city,String country) async {
    return await apiClient.postData(AppConstants.CUSTOMER_INFO_URI, {
      "name": name,
      "phone": phone,
      "address": address,
      "city": city,
      "country": country
    },
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${getToken()}"
      }
    );
  }

  //get token
  String? getToken() {
    return sharedPreferences.getString('token');
  }
  //save token
  Future<bool> saveToken(String token) async {
    return await sharedPreferences.setString('token', token);
  }

  //save user email and name
  Future<bool> saveUserEmailAndName(String email,String name) async {
    await sharedPreferences.setString('phone', email);
    return await sharedPreferences.setString('name', name);
  }
  //get user email
  String? getUserEmail() {
    return sharedPreferences.getString('phone');
  }
  //get user name
  String? getUserName() {
    return sharedPreferences.getString('name');
  }

  //forget password
  Future<Response> forgetPassword(String email) async {
    return await apiClient.postData(AppConstants.FORGOT_PASSWORD_URI, {"email": email});
  }
  //verify code
  Future<Response> verifyCode(String email,String code) async {
    return await apiClient.postData(AppConstants.VERIFY_CODE_URI, {"email": email,"token":code});
  }
  //reset password
  Future<Response> resetPassword(String token,String password) async {
    return await apiClient.postData(AppConstants.RESET_PASSWORD_URI, {"token": token,"password":password});
  }
 //logout
  Future<void> signOut() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
  }
 

  //logout
  Future<bool> logout() async {
    await signOut();
    return await sharedPreferences.remove('token');
  }
  //is login
  bool isLogin() {
    if (sharedPreferences.getString('token') != null) {
      return true;
    } else {
      return false;
    }
  }

  //delete user
  Future<Response> deleteUser() async {
    return await apiClient.deleteData(AppConstants.CUSTOMER_INFO_URI,
    headers: {
        "Content-Type": "application/json",
      "Authorization": "Bearer ${getToken()}"
      }
    );
  }

}