import 'package:climate_app/pages/CimateHome.dart';
import 'package:climate_app/pages/Location.dart';
import 'package:climate_app/pages/about.dart';
import 'package:flutter/material.dart';

// import 'pages/CimateHome.dart';

void main() => runApp(ClimateApp());

class ClimateApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Climate',
      theme: ThemeData(
        iconTheme: IconThemeData(color: Colors.black),
        textTheme: TextTheme(
          body1: TextStyle(
            fontFamily: 'Poppins',
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => ClimateHome(),
        '/locator': (context) => ClimateLocation(),
        '/about': (context) => AboutPage()
      },
    );
  }
}
