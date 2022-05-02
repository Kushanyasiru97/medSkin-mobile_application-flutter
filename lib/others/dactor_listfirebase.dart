import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:medskin/daily_Tips/Provider.dart';
import 'package:medskin/daily_Tips/query.dart';
import 'package:medskin/lalindu/Provider.dart';

import 'package:medskin/lalindu/query.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(doctorDetails());
}

class doctorDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MyProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: Color(0xff2b2b2b),
          appBarTheme: AppBarTheme(
            color: Color(0xff2b2b2b),
          ),
        ),
        home:
        // dailytipListPage(),
        doctorListPage(),
        // home: StreamBuilder(
        //     stream: FirebaseAuth.instance.authStateChanges(),
        //     builder: (index, sncpshot) {
        //       if (sncpshot.hasData) {
        //         return HomePage();
        //       }
        //       return LoginPage();
        //     }),
      ),
    );
  }
}