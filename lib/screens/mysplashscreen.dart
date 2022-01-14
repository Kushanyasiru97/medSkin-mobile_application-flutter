import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import 'home.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 3,
      navigateAfterSeconds: Home(),
      title: Text(
        'Cat and Dog Classifier',
        style: TextStyle(
            color: Color(0x00FFFF),
            fontSize: 25.0,
            fontWeight: FontWeight.bold),
      ),
      image: Image.asset('images/wallpaper.jpg'),
      backgroundColor: Colors.blueAccent,
      photoSize: 80.0,
      loaderColor: Colors.white,
    );
  }
}
