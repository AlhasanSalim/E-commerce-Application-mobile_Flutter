import 'package:ecommarce/views/screens/splash_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class AppService {
  static SharedPreferences? _prefs;

  static void setUserData({required String token}){
    _prefs?.setString("token", token);
  }
  static String getEmail(){
    return _prefs?.getString("email") ?? "";
  }
  static String getToken(){
    return _prefs?.getString("token") ?? "";
  }
  static logOut(BuildContext context)async{
   await _prefs?.clear();
   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_){return SplashPage();}), (route) => false);
  }
  static void init() async {
    _prefs = await SharedPreferences.getInstance();
  }
  
}