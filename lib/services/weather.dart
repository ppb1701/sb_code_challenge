import 'package:sb_code_challenge/services/networking.dart';
import 'package:sb_code_challenge/services/location.dart';
import 'package:sb_code_challenge/owm_api_key.dart';


const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/forecast/daily';

class WeatherModel {

  //Requests the daily location weather data.  NOTE:  apiKey is a constant in a file called owm_api_key.dart.
  //This file is in .gitignore
  Future getLocationWeather([int days=1]) async {
    Location location = Location();
    await location.getCurrentLocation();
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?units=imperial&lat=${location.latitude}&lon=${location.longitude}&cnt=$days&appid=$apiKey');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }
}
