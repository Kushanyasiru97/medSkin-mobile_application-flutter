// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//           appBar: AppBar(
//             title: Text('Flutter Buttons - FlatButton'),
//           ),
//           body: Center(
//               child: Column(children: <Widget>[
//                 Container(
//                   margin: EdgeInsets.all(25),
//                   child: FlatButton(
//                     child: Text(
//                       'Button 1',
//                       style: TextStyle(fontSize: 20.0),
//                     ),
//                     onPressed: () {},
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.all(25),
//                   child: FlatButton(
//                     child: Text(
//                       'Button 2',
//                       style: TextStyle(fontSize: 20.0),
//                     ),
//                     color: Colors.cyan,
//                     textColor: Colors.black,
//                     onPressed: () {},
//                   ),
//                 ),
//               ]))),
//     );
//   }
// }

import 'package:flutter/material.dart';

class changeUser extends StatelessWidget {
  const changeUser({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: Text('Flutter Buttons - FlatButton'),
          ),
          body: Center(
              child: Column(children: <Widget>[
                Container(
                  margin: EdgeInsets.all(25),
                  child: FlatButton(
                    child: Text(
                      'DOCTOR',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    onPressed: () {},
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(25),
                  child: FlatButton(
                    child: Text(
                      'USER',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    color: Colors.cyan,
                    textColor: Colors.black,
                    onPressed: () {},
                  ),
                ),
              ]
              )
          )
    );
  }
}
