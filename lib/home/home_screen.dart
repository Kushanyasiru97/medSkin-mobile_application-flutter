
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class userHomeScreen extends StatelessWidget {
  // const userHomeScreen({Key? key}) : super(key: key);

  Widget skincareTips(){
    return  Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      height: 150.0,
      width: 360.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('images/wallpaper.jpg'),
        ),
        color: Colors.red,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 300.0,bottom:10.0),
                      // child: CircleAvatar(
                      //   radius: 30.0,
                      // ),
                      child: Container(
                        height: 60.0,
                        width: 100.0,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(50.0),
                            bottomLeft: Radius.circular(50.0),
                          ),
                        ),
                        child: Text(
                          "JAN 28",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25.0,
                              shadows: [
                                BoxShadow(
                                  color: Colors.red,
                                  blurRadius: 3.0,
                                  offset: Offset(3,3),
                                ),
                              ]
                          ),
                        ),
                      ),
                    ),
                  ],
                )
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: Column(
                children: [
                  Text(
                    "Use the correct cleanser for your skin type",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.lightGreenAccent,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 3.0,
                          offset: Offset(2,2),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );

  }

  Widget diseasesHistory(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      height: 220.0,
      width: 160.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex:2,
            child: Image.network("https://images.saymedia-content.com/.image/t_share/MTc2Mjk2NzE2MDYzMjIwOTI2/a-variety-of-skin-disorders.jpg"),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 5.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // SizedBox(height: 10.0,),
                  Text(
                    "Rashes",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    height: 30.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: OutlineButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "See more...",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            size: 20.0,
                            color: Colors.black,
                          )
                        ],
                      ),
                      onPressed: (){},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffcbcbcb),
      // drawer: Drawer(),
      appBar: AppBar(
        // iconTheme: IconThemeData(color: Colors.black),
        // title: Text(
        //   "User Home Page",
        //   style: TextStyle(
        //     color: Colors.black,
        //     fontWeight: FontWeight.bold,
        //     fontSize: 20.0,
        //   ),
        // ),
        actions: [
          // CircleAvatar(
          //   radius: 20.0,
          //   backgroundColor: Color(0xffd4d181),
          //   child: Icon(Icons.person,size: 20.0,color: Colors.black,),
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: CircleAvatar(
              radius: 20.0,
              backgroundColor: Color(0xffd4d181),
              child: Icon(Icons.logout,size: 20.0,color: Colors.black,),
            ),
          )
        ],
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
        child: Container(
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    skincareTips(),
                    skincareTips(),
                    skincareTips(),
                  ],
                ),
              ),
              SizedBox(height: 10.0,),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "skin History",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    Text(
                      "View All",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    diseasesHistory(),
                    diseasesHistory(),
                    diseasesHistory(),
                    diseasesHistory(),
                  ],
                ),
              ),
              SizedBox(height: 10.0,),
              Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Material(
                          elevation:8,
                          borderRadius: BorderRadius.circular(10.0),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: InkWell(

                            splashColor: Colors.grey,
                            onTap: (){},
                            child: Ink.image(
                              image: AssetImage("images/home.png",),
                              height: 60.0,
                              width: 60.0,
                            ),
                          ),
                        ),
                        SizedBox(width: 80,),
                        Material(
                          elevation:8,
                          borderRadius: BorderRadius.circular(10.0),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: InkWell(
                            splashColor: Colors.grey,
                            onTap: (){},
                            child: Ink.image(
                              image: AssetImage("images/person.png"),
                              height: 60.0,
                              width: 60.0,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Material(
                          elevation:8,
                          borderRadius: BorderRadius.circular(10.0),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: InkWell(
                            splashColor: Colors.grey,
                            onTap: (){},
                            child: Ink.image(
                              image: AssetImage("images/map.png"),
                              height: 60.0,
                              width: 60.0,
                              // fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 80,),
                        Material(
                          elevation:8,
                          borderRadius: BorderRadius.circular(10.0),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: InkWell(
                            splashColor: Colors.grey,
                            onTap: (){},
                            child: Ink.image(
                              image: AssetImage("images/chat.png"),
                              height: 60.0,
                              width: 60.0,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
