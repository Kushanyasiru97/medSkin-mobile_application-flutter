import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medskin/camera_screen/pages/camera_screen.dart';
import 'package:medskin/home/home_screen.dart';
import 'package:medskin/models/skincaretip_model.dart';
import 'package:medskin/screens/home.dart';
import 'package:medskin/user/screens/login_screen.dart';
import 'package:medskin/user/screens/registration_screen.dart';

import '../main.dart';


class userbottomNavBar extends StatefulWidget {
  const userbottomNavBar({Key? key}) : super(key: key);

  @override
  _userHomeState createState() => _userHomeState();
}

class _userHomeState extends State<userbottomNavBar> {
  int index = 0;

  List<SkinCareTipModel> tipList  =[];

  void onTappedBar(int index){
    setState(() {
      _currentIndex = index;
    });
  }


  Widget skincaretipsContainer({required String image,required String topic,required String description}){
    return Column(
      children: [
        Container(
          height: 270.0,
          width: 400.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(image),
            ),
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),SizedBox(height: 10.0,),
        Text(topic, style: TextStyle(color: Colors.black,fontSize: 20.0),),
        Text(description, style: TextStyle(color: Colors.black,fontSize: 20.0),)
      ],
    );
  }

  Widget drawerItemList(@required String name,@required IconData icon){
    return ListTile(
      leading: Icon(icon,color: Colors.white,),
      title: Text(
        name,
        style: TextStyle(
          fontSize: 20.0,
          color: Colors.white,
        ),
      ),
    );
  }

  late final List<BottomNavigationBarItem> items ;

  int _currentIndex = 0;
  final List<Widget> _children = [
    userHomeScreen(),
    userLoginScreen(),
    userLoginScreen(),
    userLoginScreen(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTappedBar,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,size: 20),
            title: Text("Home"),
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat,size: 20),
            title: Text("Chat"),
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: IconButton(
                icon: Icon(Icons.camera,size: 40), onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => CameraScreen()));
            },),
            title: Text(""),
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on,size: 20),
            title: Text("Map"),
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,size: 20),
            title: Text("Profile"),
            backgroundColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}
