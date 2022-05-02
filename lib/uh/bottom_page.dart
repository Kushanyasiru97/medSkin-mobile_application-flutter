import 'package:flutter/material.dart';
import 'package:medskin/Person/page/profile_page.dart';
import 'package:medskin/buttons.dart';
import 'package:medskin/camera_screen/pages/camera_screen.dart';
import 'package:medskin/new/FrontEnd/MainScreens/main_screen.dart';
import 'package:medskin/try.dart';

import 'home_page.dart';

class BottomPage extends StatefulWidget {
  @override
  _BottomPageState createState() => _BottomPageState();
}

class _BottomPageState extends State<BottomPage> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static List<Widget> _widgetOption = <Widget>[
    HomePage(),
    MainScreen(),
    CameraScreen(),
    mapApp(),
    userProfile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0c0f14),
      body: Center(
        child: _widgetOption.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: BottomNavigationBar(
          elevation: 0.0,
          backgroundColor: Color(0xff0c0f14),
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 30,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.chat,
                  size: 30,
                ),
              label: "Business",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.camera,
                size:40,
              ),
              label: "favorite",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.place,
                size: 30,
              ),
              label: "notifications",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: 30,
              ),
              label: "notifications",
            ),
          ],

          currentIndex: _selectedIndex,
          unselectedItemColor: Color(0xff4e5053),
          selectedItemColor: Color(0xffd17842),
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
