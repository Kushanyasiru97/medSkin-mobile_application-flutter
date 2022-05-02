// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:medskin/chatScreen/mainScreens/AuthUI/log_in.dart';
// import 'package:medskin/chatScreen/mainScreens/backEnd/firebase/Auth/email_and_pwd_auth.dart';
// import 'package:medskin/chatScreen/mainScreens/backEnd/firebase/Auth/google_auth.dart';
//
//
// class chatHomePage extends StatefulWidget {
//   const chatHomePage({Key key}) : super(key: key);
//
//   @override
//   _chatHomePageState createState() => _chatHomePageState();
// }
//
// class _chatHomePageState extends State<chatHomePage> {
//   final EmailAndPasswordAuth _emailAndPasswordAuth = EmailAndPasswordAuth();
//   final GoogleAuthentication _googleAuthentication = GoogleAuthentication();
//   // final FacebookAuthentication _facebookAuthentication =
//   // FacebookAuthentication();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         alignment: Alignment.center,
//         child: ElevatedButton(
//           child: Text('Log Out'),
//           onPressed: () async {
//             final bool googleResponse =
//             await this._googleAuthentication.logOut();
//
//             // // if (!googleResponse) {
//             //   // final bool fbResponse =
//             //   await this._facebookAuthentication.logOut();
//             //
//             //
//             //   if (!fbResponse) await this._emailAndPasswordAuth.logOut();
//             // }
//
//             Navigator.pushAndRemoveUntil(
//                 context,
//                 MaterialPageRoute(builder: (_) => LogInScreen()),
//                     (route) => false);
//           },
//         ),
//       ),
//     );
//   }
// }