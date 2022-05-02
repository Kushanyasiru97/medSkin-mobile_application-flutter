// // import 'package:firebase_messaging/firebase_messaging.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/cupertino.dart';
// // import 'package:firebase_core/firebase_core.dart';
// //
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:medskin/chatScreen/mainScreens/AuthUI/log_in.dart';
// // import 'package:medskin/chatScreen/mainScreens/backEnd/firebase/OnlineDatabaseManagement/cloud_data_management.dart';
// // import 'package:medskin/chatScreen/mainScreens/fontEnd/mainScreens/chatMainScreen.dart';
// // import 'package:medskin/chatScreen/mainScreens/global_Uses/foreground_receive_notificaion_management.dart';
// // import 'package:medskin/chatScreen/mainScreens/newUserEntry/new_user_entry.dart';
// // import 'package:medskin/google_map/dataHandler/appData.dart';
// // import 'package:medskin/uh/bottom_page.dart';
// // import 'package:provider/provider.dart';
// //
// //
// // void main() async{
// //   WidgetsFlutterBinding.ensureInitialized();
// //   await Firebase.initializeApp();
// //   runApp(MyApp());
// // }
// //
// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return ChangeNotifierProvider(
// //       create: (context) => AppData(),
// //       child: MaterialApp(
// //         title: 'skin diseases',
// //
// //         home:
// //         // doctorsLoginScreen(),
// //         // await differentContextDecisionTake()
// //         MaterialApp(),
// //         // googleMapMainScreen(),
// //         // StreamBuilder(
// //         // stream: FirebaseAuth.instance.authStateChanges(),
// //         // builder: (context,snapshot){
// //         //   if(snapshot.hasData){
// //         //     return BottomPage();
// //         //   }
// //         //   else{
// //         //     return userLoginScreen();
// //         //   }
// //         // },
// //         // ),
// //         // MainScreen(),
// //         //  userLoginScreen(),
// //         debugShowCheckedModeBanner: false,
// //       ),
// //     );
// //   }
// // }
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:medskin/chatScreen/mainScreens/backEnd/firebase/OnlineDatabaseManagement/cloud_data_management.dart';
// import 'package:medskin/chatScreen/mainScreens/global_Uses/foreground_receive_notificaion_management.dart';
// import 'package:medskin/uh/bottom_page.dart';
//
// import 'chatScreen/mainScreens/AuthUI/log_in.dart';
// import 'chatScreen/mainScreens/newUserEntry/new_user_entry.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//
//    // Initialize Notification Settings
//   await notificationInitialize();
//
//   // /For Background Message Handling
//   FirebaseMessaging.onBackgroundMessage(backgroundMsgAction);
//
//    // For Foreground Message Handling
//   FirebaseMessaging.onMessage.listen((messageEvent) {
//     print(
//         "Message Data is: ${messageEvent.notification.title}     ${messageEvent.notification.body}");
//
//     _receiveAndShowNotificationInitialization(
//         title: messageEvent.notification.title.toString(),
//         body: messageEvent.notification.body.toString());
//   });
//
//   runApp(
//     MaterialApp(
//       title: 'medSkin',
//       debugShowCheckedModeBanner: false,
//       themeMode: ThemeMode.dark,
//       home: await differentContextDecisionTake(),
//     ),
//   );
// }
//
// Future<Widget> differentContextDecisionTake() async {
//   if (FirebaseAuth.instance.currentUser == null) {
//     return LogInScreen();
//   } else {
//     final CloudStoreDataManagement _cloudStoreDataManagement =
//     CloudStoreDataManagement();
//
//     final bool _dataPresentResponse =
//     await _cloudStoreDataManagement.userRecordPresentOrNot(
//         email: FirebaseAuth.instance.currentUser.email.toString());
//
//     return _dataPresentResponse ? BottomPage() : TakePrimaryUserData();
//   }
// }
//
// Future<void> notificationInitialize() async {
//   await FirebaseMessaging.instance.subscribeToTopic("medSkin");
//
//   await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//     alert: true,
//     badge: true,
//     sound: true,
//   );
// }
//
// void _receiveAndShowNotificationInitialization(
//     { title, String body}) async {
//   final ForegroundNotificationManagement _fgNotifyManagement =
//   ForegroundNotificationManagement();
//
//   print("Notification Activated");
//
//   await _fgNotifyManagement.showNotification(title: title, body: body);
// }
//
// Future<void> backgroundMsgAction(RemoteMessage message) async {
//   await Firebase.initializeApp();
//
//   _receiveAndShowNotificationInitialization(
//       title: message.notification.title.toString(),
//       body: message.notification.body.toString());
// }


/******************************************************/

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:medskin/new/FrontEnd/MainScreens/main_screen.dart';
import 'package:medskin/new/Global_Uses/foreground_receive_notificaion_management.dart';

import 'new/Backend/firebase/OnlineDatabaseManagement/cloud_data_management.dart';
import 'new/FrontEnd/AuthUI/log_in.dart';
import 'new/FrontEnd/NewUserEntry/new_user_entry.dart';

Future<void> function() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


  await notificationInitialize();


  FirebaseMessaging.onBackgroundMessage(backgroundMsgAction);


  FirebaseMessaging.onMessage.listen((messageEvent) {
    print(
        "Message Data is: ${messageEvent.notification.title}     ${messageEvent.notification.body}");

    _receiveAndShowNotificationInitialization(
        title: messageEvent.notification.title.toString(),
        body: messageEvent.notification.body.toString());
  });

  runApp(
    MaterialApp(
      title: 'medSkin',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      home: await differentContextDecisionTake(),
    ),
  );
}

Future<Widget> differentContextDecisionTake() async {
  if (FirebaseAuth.instance.currentUser == null) {
    return LogInScreen();
  } else {
    final CloudStoreDataManagement _cloudStoreDataManagement =
    CloudStoreDataManagement();

    final bool _dataPresentResponse =
    await _cloudStoreDataManagement.userRecordPresentOrNot(
        email: FirebaseAuth.instance.currentUser.email.toString());

    return _dataPresentResponse ? MainScreen() : TakePrimaryUserData();
  }
}

Future<void> notificationInitialize() async {

  await FirebaseMessaging.instance.subscribeToTopic("Generation_YT");


  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
}


void _receiveAndShowNotificationInitialization(
    {String title, String body}) async {
  final ForegroundNotificationManagement _fgNotifyManagement =
  ForegroundNotificationManagement();

  print("Notification Activated");

  await _fgNotifyManagement.showNotification(title: title, body: body);
}

Future<void> backgroundMsgAction(RemoteMessage message) async {
  await Firebase.initializeApp();

  _receiveAndShowNotificationInitialization(
      title: message.notification.title.toString(),
      body: message.notification.body.toString());
}
