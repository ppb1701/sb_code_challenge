import 'package:flutter/material.dart';
import 'package:sb_code_challenge/screens/hello_world.dart';
import 'package:sb_code_challenge/screens/home_screen.dart';
import 'package:sb_code_challenge/screens/weather_screen.dart';
import 'package:sb_code_challenge/services/weather.dart';

class NavigationHelper {
  var weatherData;
  final isLoggedIn;
  final githubResponse;
  NavigationHelper({this.isLoggedIn, this.githubResponse});

  void getLocation() async {
    weatherData = await WeatherModel().getLocationWeather();
  }

  void goWeather(BuildContext context) async {
    if (weatherData == null) {
      await getLocation();
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return WeatherScreen(
            weatherData: weatherData,
            isLoggedIn: isLoggedIn,
            githubResponse: githubResponse,
          );
        },
      ),
    );
  }

  void goHome(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return HomeScreen(
            isLoggedIn: isLoggedIn,
            githubResponse: githubResponse,
          );
        },
      ),
    );
  }

  void goHelloWorld(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return HelloWorld(
            isLoggedIn: isLoggedIn,
            githubResponse: githubResponse,
          );
        },
      ),
    );
  }
}
