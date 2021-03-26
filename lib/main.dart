import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rental/Screens/Login/login_screen.dart';
import 'package:rental/Screens/ProductScreen/home/Home_Screen.dart';
import 'package:rental/Screens/Signup/signup_screen.dart';
import 'package:rental/Screens/Welcome/welcome_screen.dart';
import 'package:rental/screens/home.dart';
import 'package:splashscreen/splashscreen.dart';

import 'dart:async';

import 'Screens/Loading.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash2(),
    );
  }
}

class Splash2 extends StatelessWidget {
  Future<bool> _isLoggedIn() async {
    FlutterSecureStorage storage = new FlutterSecureStorage();
    if (await storage.read(key: 'token') != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 6,
      navigateAfterSeconds: new FutureBuilder(
        future: _isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == true) {
              return Home();
            } else {
              return LoginScreen();
            }
          } else {
            return Center(child: Loading());
          }
        },
      ),
      title: new Text(
        'WITTRADE',
        style: TextStyle(
          letterSpacing: 2.0,
        ),
        textScaleFactor: 2,
      ),
      backgroundColor: Colors.grey[300],
      image: new Image.asset('assets/wit.PNG'),
      loadingText: Text("Loading"),
      photoSize: 150.0,
      loaderColor: Colors.pink[400],
    );
  }
}
