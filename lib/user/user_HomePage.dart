import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class userHomePage extends StatelessWidget {
  // const userHomePage({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  Widget _buildhistorydiplay({required String image, required String name}){
    return Card(
      child: Container(
        height: 200.0,
        width: 170.0,
         color: Colors.white12,
        child: Column(
          children: [
            Container(
              height: 150.0,
              width: 150.0,
              // color: Colors.grey,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(image),
                  )
              ),
            ),
            Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Color(0xff9b96d6),
                )
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer:Drawer(),
      appBar: AppBar(
        title: Text(
          "User Home Page",
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
              // color: Colors.grey,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "History",
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
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _buildhistorydiplay(
                            image: "images/back.png",
                            name: "Tumar"
                        ),
                        _buildhistorydiplay(
                            image: "images/wallpaper.jpg",
                            name: "Pimples"
                        ),
                        // _buildhistorydiplay(
                        //     image: "images/drawer.png",
                        //     name: "Tumar"
                        // ),
                      ],
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
