import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sb_code_challenge/components/nav_drawer.dart';
import 'package:sb_code_challenge/helpers/nav_helper.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final FlutterAppAuth appAuth = FlutterAppAuth();
const FlutterSecureStorage secureStorage = FlutterSecureStorage();

const String AUTH0_DOMAIN = 'dev-hfkzcmvn.us.auth0.com';
const String AUTH0_CLIENT_ID = 'gXT31DY7Y0bWSgNJeoRhVfWB23yhseOk';
const String AUTH0_REDIRECT_URI =
   'com.grimshawcoding.code://login-callback';
const String AUTH0_ISSUER = 'https://$AUTH0_DOMAIN';

class HelloWorld extends StatefulWidget {
  static const String id = 'hello_world_screen';
  final isLoggedIn;
  final githubResponse;
  HelloWorld({this.isLoggedIn, this.githubResponse});

  @override
  _State createState() => _State();
}

class _State extends State<HelloWorld> {
  bool isBusy = false;
  bool isLoggedIn = false;
  String errorMessage;
  dynamic githubResponse;

  var weatherData;
  NavigationHelper navigationHelper = NavigationHelper();

  Map<String, dynamic> parseIdToken(String idToken) {
    final parts = idToken.split(r'.');
    assert(parts.length == 3);

    return jsonDecode(
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
  }

  Future<Map<String, dynamic>> getUserDetails(String accessToken) async {
    final url = 'https://$AUTH0_DOMAIN/userinfo';
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get user details');
    }
  }

  Future<void> loginAction() async {
    setState(() {
      isBusy = true;
      errorMessage = '';
    });

    try {
      final AuthorizationTokenResponse result =
      await appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          AUTH0_CLIENT_ID,
          AUTH0_REDIRECT_URI,
          issuer: 'https://$AUTH0_DOMAIN',
          scopes: ['openid', 'profile', 'offline_access'],
          // promptValues: ['login']
        ),
      );

      final idToken = parseIdToken(result.idToken);
      final profile = await getUserDetails(result.accessToken);

      await secureStorage.write(
          key: 'refresh_token', value: result.refreshToken);

      setState(() {
        isBusy = false;
        isLoggedIn = true;
        githubResponse = profile;
      });
    } catch (e, s) {
      print('login error: $e - stack: $s');

      setState(() {
        isBusy = false;
        isLoggedIn = false;
        errorMessage = e.toString();
      });
    }
  }

  void logoutAction() async {
    await secureStorage.delete(key: 'refresh_token');
    setState(() {
      isLoggedIn = false;
      isBusy = false;
    });
  }

  void initState() {
    super.initState();
    isLoggedIn = widget.isLoggedIn!=null ? widget.isLoggedIn? widget.isLoggedIn : false : false;
    if(widget.githubResponse!=null){
      githubResponse=widget.githubResponse;
    }
  }

  void initAction() async {
    final storedRefreshToken = await secureStorage.read(key: 'refresh_token');
    if (storedRefreshToken == null) return;

    setState(() {
      isBusy = true;
    });

    try {
      final response = await appAuth.token(TokenRequest(
        AUTH0_CLIENT_ID,
        AUTH0_REDIRECT_URI,
        issuer: AUTH0_ISSUER,
        refreshToken: storedRefreshToken,
      ));

      final idToken = parseIdToken(response.idToken);
      final profile = await getUserDetails(response.accessToken);

      secureStorage.write(key: 'refresh_token', value: response.refreshToken);

      setState(() {
        isBusy = false;
        isLoggedIn = true;
      });
    } catch (e, s) {
      print('error on refresh token: $e - stack: $s');
      logoutAction();
    }
  }

  void goHome(){
    NavigationHelper navigationHelper =
    new NavigationHelper(isLoggedIn: widget.isLoggedIn, githubResponse: widget.githubResponse);
    navigationHelper.goHome(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: NavDrawer(isLoggedIn: isLoggedIn, githubResponse: githubResponse),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hello World!',
              style: TextStyle(fontSize: 35.0),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),),
              color: Colors.lightBlueAccent,
              onPressed: () {
                print('test');
                !isLoggedIn? loginAction() : logoutAction();
              },
              child: Text(
                isLoggedIn? 'Logout' : 'Login',
                style: TextStyle(fontSize: 30.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
