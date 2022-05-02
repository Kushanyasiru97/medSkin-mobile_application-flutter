

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:medskin/google_map/dataHandler/appData.dart';
import 'package:medskin/google_map/screens/mainscreen.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(mapApp());
}

class mapApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppData(),
      child: MaterialApp(
        title: 'skin diseases',

        home:
        googleMapMainScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}