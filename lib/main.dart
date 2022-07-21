import 'package:ecommarce/services/app_service.dart';
import 'package:ecommarce/views/screens/home_page.dart';
import 'package:ecommarce/views/screens/login_page.dart';
import 'package:ecommarce/views/screens/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/product_provider.dart';

void main() {
  AppService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Eccommarce App',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: Colors.white70)
          ),
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              color: Colors.deepOrange,
              fontSize: 20,
            ),
            titleMedium: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold
            )
          ),
          primarySwatch: Colors.deepOrange,
        ),
        home: const SplashPage(),
      ),
    );
  }
}