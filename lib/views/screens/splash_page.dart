import 'package:ecommarce/services/app_service.dart';
import 'package:ecommarce/views/screens/home_page.dart';
import 'package:ecommarce/views/screens/login_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    init();
    super.initState();
  }

  void init ()async{
    await Future.delayed(const Duration(seconds: 1));
    if (AppService.getToken() != ""){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_){return const HomePage();}), (route) => false);
    }else{
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_){return LoginPage();}), (route) => false);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                "Ecommarce App",
                style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}