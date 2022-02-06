//@dart=2.9


import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medskin/allwidgets/progressDialog.dart';
import 'package:medskin/camera_screen/pages/camera_screen.dart';
import 'package:medskin/google_map/Assistant/assistant_method.dart';
import 'package:medskin/google_map/dataHandler/appData.dart';
import 'package:medskin/screens/home.dart';
import 'package:medskin/uh/bottom_page.dart';
import 'package:medskin/uh/home_page.dart';
// import 'package:medskin/user/User_HomePage/main.dart';
import 'package:medskin/user/screens/login_screen.dart';
import 'package:medskin/user/user_bottomnavBar.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
// import 'doctors/screens/home_screen.dart';
import 'doctors/screens/login_screen.dart';
import 'google_map/screens/mainscreen.dart';
import 'home/home_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppData(),
      child: MaterialApp(
        title: 'skin diseases',

        home:
        // doctorsLoginScreen(),
        userLoginScreen(),
        // googleMapMainScreen(),
        // StreamBuilder(
          // stream: FirebaseAuth.instance.authStateChanges(),
          // builder: (context,snapshot){
          //   if(snapshot.hasData){
          //     return BottomPage();
          //   }
          //   else{
          //     return userLoginScreen();
          //   }
          // },
        // ),
       // MainScreen(),
        //  userLoginScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}




