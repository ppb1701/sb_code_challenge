import 'package:flutter/material.dart';
import 'package:sb_code_challenge/screens/hello_world.dart';
import 'package:sb_code_challenge/screens/home_screen.dart';
import 'package:sb_code_challenge/screens/weather_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smashing Boxes Code Challenge',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: HelloWorld.id,
      routes: {
        HelloWorld.id: (context) => HelloWorld(),
        WeatherScreen.id: (context) => WeatherScreen(),
        HomeScreen.id: (context) => HomeScreen(),
      },
    );
  }
}
