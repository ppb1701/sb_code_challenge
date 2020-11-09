import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sb_code_challenge/components/nav_drawer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sb_code_challenge/services/location.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class HomeScreen extends StatefulWidget {
  final isLoggedIn;
  final githubResponse;
  HomeScreen({this.isLoggedIn, this.githubResponse});

  static const String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Location location = Location();
  dynamic lat;
  dynamic long;

  Future loadGps() async {
    await location.getCurrentLocation();
    lat = location.latitude;
    long = location.longitude;
  }

  @override
  void initState() {
    loadGps();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    String name;
    String nickname;
    String githubUrl;

    if(!kIsWeb) {
      name = widget.githubResponse['name'];
      nickname = widget.githubResponse['nickname'];
    }
    else{
      name='No profile loaded: linking default';
      nickname='ppb1701';
    }
    githubUrl = 'https://github.com/$nickname';


    _onAlertWithCustomContentPressed(context) {
      String latitude = 'Latitude: $lat';
      String longitude = 'Longitude: $long';
      Alert(
          context: context,
          title: "GPS Coordinates",
          content: Column(
            children: <Widget>[
              Text(latitude),
              Text(longitude),
            ],
          ),
          buttons: [
            DialogButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Close",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )
          ]).show();
    }

    return Scaffold(
      appBar: AppBar(),
      drawer: NavDrawer(
          isLoggedIn: widget.isLoggedIn, githubResponse: widget.githubResponse),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              name,
              style: TextStyle(
                color: Colors.black,
                fontSize: 50.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: FlatButton(
                onPressed: () {
                  launch(githubUrl);
                },
                child: Text(
                  'Github Profile',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 30.0,
                  ),
                ),
              ),
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              color: Colors.lightBlueAccent,
              onPressed: () async {
                setState(() {
                  _onAlertWithCustomContentPressed(context);
                });
                print(lat);
                print(long);
              },
              child: Text(
                'Show GPS Coordinates',
                style: TextStyle(fontSize: 30.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}