import 'dart:convert';

import 'package:ecommarce/helpers/snack_helper.dart';
import 'package:ecommarce/views/screens/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductProvider extends ChangeNotifier {
  List<Product>? _allproducts;
  List<Product>? _homeproducts;
  List<Product>? _categoryProducts;
  List<Map<String, dynamic>>? _productSelected;

  void getAllProducts() async {
    var response = await http.get(Uri.parse("https://fakestoreapi.com/products"));
    _allproducts = List<Product>.from(jsonDecode(response.body).map((e) => Product.fromJson(e)));
    notifyListeners();
  }
  void getHomePageProducts() async {
    var response = await http.get(Uri.parse("https://fakestoreapi.com/products?limit=5&sort=desc"));
    _homeproducts = List<Product>.from(jsonDecode(response.body).map((e) => Product.fromJson(e)));
    notifyListeners();
  }
  void getcategoryProducts({required String title}) async {
    if (_categoryProducts != null){
      clearCategoryList();
    }
   var response = await http.get(Uri.parse("https://fakestoreapi.com/products/category/$title"));
    _categoryProducts = List<Product>.from(jsonDecode(response.body).map((e) => Product.fromJson(e)));
    notifyListeners();
  }
  void sendCardData(BuildContext context) async {
    _productSelected = _productSelected!.map((e) => {'productId' : e['productId'].toString(), 'quantity' : e['quantity'].toString()}).toList();
    var response = await http.post(Uri.parse("https://fakestoreapi.com/carts"),
    body: jsonEncode(
      {
      'userId': 5,
      'date': "2020 - 02 - 03",
      'products': _productSelected
      }
    ));
      
    
    if (response.statusCode == 200){
      _productSelected = null;
      notifyListeners();
      SnackHelper.showSnack(title: "Order Send Successfully", context: context);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_){return HomePage();}), (route) => false);
    }    
  }
  List<Product>? getAllData (){
    return _allproducts;
  }
  List<Product>? getHomeData (){
    return _homeproducts;
  }
  List<Product>? getOneTypeOfProducts(){
    return _categoryProducts;
  }
  List<Map<String, dynamic>>? productSelected(){
    return _productSelected;
  }
  void clearCategoryList(){
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _categoryProducts = null;
      notifyListeners();
     });
  }
  void addProductToCard(Map<String, dynamic> productSelected){
    _productSelected ??=[];
    _productSelected?.add(productSelected);
    notifyListeners();
  }
  void removeProductToCard(int productId){
    _productSelected?.removeWhere((e) {return e['productId'] == productId;});
    notifyListeners();
  }
  bool cartContainProduct(int productId){
    var result = _productSelected?.where((element) => element['productId'] == productId).toList();
    if(result?.isNotEmpty ?? false){
      return true;
    }
    else{
      return false;
    }
  }
  String getCardTotalPrice(){
    double totalPrice = 0;
    for (var product in _productSelected ?? []) {
      totalPrice += product['productPrice'] * product['quantity'];
    }
    return totalPrice.toString();
  }
  List<Map<String, String>> getCategoriesData(){
    return [
        {"title" : "electronics", "image" : "assets/electronics.png"},
        {"title" : "jewelery", "image" : "assets/jewelery.png"},
        {"title" : "men's clothing", "image" : "assets/man_clothes.png"},
        {"title" : "women's clothing", "image" : "assets/women.png"}
    ];
  }
}