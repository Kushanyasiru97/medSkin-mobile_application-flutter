//
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:medskin/chatScreen/mainScreens/AuthUI/log_in.dart';
// import 'package:medskin/chatScreen/mainScreens/backEnd/firebase/OnlineDatabaseManagement/cloud_data_management.dart';
// import 'package:medskin/chatScreen/mainScreens/global_Uses/foreground_receive_notificaion_management.dart';
// import 'package:medskin/chatScreen/mainScreens/newUserEntry/new_user_entry.dart';
// import 'package:medskin/uh/bottom_page.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//
//   // Initialize Notification Settings
//   await notificationInitialize();
//
//   // /For Background Message Handling
//   FirebaseMessaging.onBackgroundMessage(backgroundMsgAction);
//
//   // For Foreground Message Handling
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