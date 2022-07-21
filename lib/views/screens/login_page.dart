import 'dart:convert';

import 'package:ecommarce/helpers/snack_helper.dart';
import 'package:ecommarce/services/app_service.dart';
import 'package:ecommarce/views/screens/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:matcher/matcher.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatelessWidget {

  TextEditingController emailController = TextEditingController(text: "mor_2314");
  TextEditingController passWordController = TextEditingController(text: "83r5^_");
  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Ecommarce App",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 40),
                  Text(
                    "Sign in",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 15.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Email",
                        hintText: "Email"
                      ),
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: TextField(
                      obscureText: true,
                      controller: passWordController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Password",
                        hintText: "Password"
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ElevatedButton(
                      onPressed: (){
                        onSignInClicked(context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)
                        ),
                        primary: Theme.of(context).primaryColor
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Sign in", style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white)),
                      ),
                    )
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  void onSignInClicked(BuildContext context) async {
    if (emailController.text != "" && passWordController.text != ""){
      // Logic
      var response = await 
       
       http.post(Uri.parse("https://fakestoreapi.com/auth/login"),
        body: 
          {
          'username' : emailController.text,
          'password' : passWordController.text
          }
      );
      if (response.statusCode == 200){
        // Save Token
        AppService.setUserData(token: jsonDecode(response.body)['token']);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_){return HomePage();}), (route) => false);
      }
      else if (response.statusCode == 401){
        SnackHelper.showSnack(title: "Email and Password must be Correct ...", context: context);
      }
    }
    else{
      SnackHelper.showSnack(title: "Email and Password must be Filled ...", context: context);
    }
  }
}