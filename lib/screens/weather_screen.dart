import 'package:flutter/material.dart';
import 'package:sb_code_challenge/components/grid_cell.dart';
import 'package:sb_code_challenge/models/weather_data.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:intl/intl.dart';
import 'package:recase/recase.dart';
import 'package:sb_code_challenge/components/nav_drawer.dart';

class WeatherScreen extends StatefulWidget {
  static const String id = 'weather_screen';
  final weatherData;
  final isLoggedIn;
  final githubResponse;
  WeatherScreen({this.weatherData, this.isLoggedIn, this.githubResponse});
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  List<WeatherData> weather = [];
  var isPortrait = true;

  @override
  void initState() {
    updateWeatherList(widget.weatherData);
    super.initState();
  }

  void updateWeatherList(dynamic data, [bool isPortrait = true]) {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('MM/dd/yyyy');
    final String formatted = formatter.format(now);
    weather.clear();
    weather.add(WeatherData(name: 'Date (mm/dd/yyyy)', data: formatted));
    weather.add(WeatherData(
        name: 'Temperature (F)',
        data: data['list'][0]['temp']['day'].toString()));
    if (!isPortrait) {
      weather.add(WeatherData(
          name: 'Description',
          data: data['list'][0]['weather'][0]['description']
              .toString()
              .sentenceCase));
      weather.add(WeatherData(
          name: 'Main',
          data: data['list'][0]['weather'][0]['main'].toString().sentenceCase));
      weather.add(WeatherData(
          name: 'Pressure', data: data['list'][0]['pressure'].toString()));
      weather.add(WeatherData(
          name: 'Humidity', data: data['list'][0]['humidity'].toString()));
    }
    setState(() {});
  }

  void checkScreenWeatherSize() {
    isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    isPortrait = kIsWeb
        ? false
        : MediaQuery.of(context).orientation == Orientation.portrait;
    updateWeatherList(widget.weatherData, isPortrait);
  }

  @override
  Widget build(BuildContext context) {
    checkScreenWeatherSize();
    return Scaffold(
      appBar: AppBar(),
      drawer: NavDrawer(weatherData: widget.weatherData, isLoggedIn: widget.isLoggedIn, githubResponse: widget.githubResponse),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GridView.builder(
                  clipBehavior: Clip.none,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: weather.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: weather.length,
                    mainAxisSpacing: 0.5,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            GridTile(
                              child: GridCell(
                                  weather[index].name, weather[index].data),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
