//@dart=2.9

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:medskin/pages/login_screen.dart';
import 'package:medskin/user/screens/login_screen.dart';
import 'package:medskin/user/user_bottomnavBar.dart';




void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'skin diseases',

      home:
      userLoginScreen(),
      debugShowCheckedModeBanner: true,
    );
  }
}




