// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:medskin/chatScreen/mainScreens/global_Uses/foreground_receive_notificaion_management.dart';
// import 'package:medskin/new/Backend/firebase/OnlineDatabaseManagement/cloud_data_management.dart';
// import 'package:medskin/new/FrontEnd/AuthUI/log_in.dart';
// import 'package:medskin/new/FrontEnd/NewUserEntry/new_user_entry.dart';
//
// class SelectScreen extends StatefulWidget {
//   const SelectScreen({Key key}) : super(key: key);
//
//   @override
//   _SelectScreenState createState() => _SelectScreenState();
// }
//
// class _SelectScreenState extends State<SelectScreen> {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar:AppBar(
//           title: Text("Select Screen"),
//
//         ),
//       body: Column(
//         children: [
//           ElevatedButton(
//               onPressed:() async {
//
//               },
//               child: Text("Doctor"),
//           ),
//           SizedBox(height: 10.0,),
//
//           ElevatedButton(
//               onPressed:(){},
//               child: Text("User"),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Future<Widget> differentContextDecisionTake() async {
//     if (FirebaseAuth.instance.currentUser == null) {
//       print("Login sucsess");
//       return LogInScreen();
//
//     } else {
//       print("Login Unsucsess");
//       final CloudStoreDataManagement _cloudStoreDataManagement =
//       CloudStoreDataManagement();
//
//       final bool _dataPresentResponse =
//
//
//       await _cloudStoreDataManagement.userRecordPresentOrNot(
//           email: FirebaseAuth.instance.currentUser.email.toString());
//
//       return _dataPresentResponse ? MainScreen() : TakePrimaryUserData();
//     }
//   }
//
//   Future<void> notificationInitialize() async {
//
//     await FirebaseMessaging.instance.subscribeToTopic("Generation_YT");
//
//
//     await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//   }
//
//
//   void _receiveAndShowNotificationInitialization(
//       {String title, String body}) async {
//     final ForegroundNotificationManagement _fgNotifyManagement =
//     ForegroundNotificationManagement();
//
//     print("Notification Activated");
//
//     await _fgNotifyManagement.showNotification(title: title, body: body);
//   }
//
//   Future<void> backgroundMsgAction(RemoteMessage message) async {
//     await Firebase.initializeApp();
//
//     _receiveAndShowNotificationInitialization(
//         title: message.notification.title.toString(),
//         body: message.notification.body.toString());
//   }
// }