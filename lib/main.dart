//@dart=2.9

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:medskin/admin/admin_screens/admin_homepage.dart';
import 'package:medskin/admin/admin_screens/admin_login_screens.dart';
import 'package:medskin/pages/login_screen.dart';
import 'package:medskin/screens/home.dart';
import 'package:medskin/screens/mysplashscreen.dart';
import 'package:medskin/user/user_HomePage.dart';
import 'package:medskin/user/user_bottomnavBar.dart';
import 'package:medskin/user_login/login_screen.dart';
import 'package:provider/provider.dart';
import 'admin/admin_screens/admin_signup_screen.dart';
import 'controllers/authentication.dart';
import 'controllers/start.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'skin diseases',

      home:
      // MySplashScreen(),
      userbottomNavBar(),
      // userHomePage(),
    //     home:Consumer<AuthNotifier>(
    //     builder: (context, notifier, child){
    //   return notifier.user ! null ? feed(): adminLogin();
    // }
      debugShowCheckedModeBanner: true,
    );
  }
}




