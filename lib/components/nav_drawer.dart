import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sb_code_challenge/helpers/nav_helper.dart';
import 'nav_tile.dart';

class NavDrawer extends StatefulWidget {
  final weatherData;
  final isLoggedIn;
  final githubResponse;
  NavDrawer({this.weatherData, this.isLoggedIn, this.githubResponse});
  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.blueAccent,
        child: ListView(
          padding: EdgeInsets.only(left: 15.0, top: 75.0),
          children: <Widget>[
            NavTile(
              text: 'Hello World',
              onTap: () async {
                NavigationHelper navigationHelper =
                new NavigationHelper(isLoggedIn: widget.isLoggedIn, githubResponse: widget.githubResponse);
                navigationHelper.goHelloWorld(context);
              },
            ),
            (widget.isLoggedIn || kIsWeb)
                ? NavTile(
                    text: 'Home Screen',
                    onTap: () async {
                      NavigationHelper navigationHelper =
                      new NavigationHelper(isLoggedIn: widget.isLoggedIn, githubResponse: widget.githubResponse);
                      navigationHelper.goHome(context);
                    },
                  )
                : Text(' '),
            (widget.isLoggedIn || kIsWeb)
                ? NavTile(
                    text: 'Weather',
                    onTap: () async {
                      NavigationHelper navigationHelper =
                          new NavigationHelper(isLoggedIn: widget.isLoggedIn, githubResponse: widget.githubResponse );
                      navigationHelper.goWeather(context);
                    },
                  )
                : Text(' '),
          ],
        ),
      ),
    );
  }
}
