import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class adminHomePage extends StatelessWidget {
  // const adminHomePage({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer:Drawer(),
      appBar: AppBar(
        title: Text(
          "Home Page",
        ),
        centerTitle: true,
        elevation: 0.0,
        // backgroundColor: Colors.transparent,
        leading: IconButton(icon: Icon(Icons.menu),
          onPressed: () {
          _key.currentState!.openDrawer();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none),
            onPressed: () {  },
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {  },
          )
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Container(
              height: 150.0,
              // color: Colors.blue,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Features",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Text(
                          "See All",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
