
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medskin/Person/page/fade_animator.dart';
import 'package:medskin/user/screens/login_screen.dart';

import 'detail_page.dart';

class HomePage extends StatelessWidget {
  static var screenHeight;
  static var screenWidth;

  Widget buildCoffeeCategory({categoryName, isSelected}) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        children: [
          Text(
            categoryName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isSelected ? Color(0xffd17842) : Color(0xff52555a),
            ),
          ),
          isSelected
              ? Text(
                  "",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xffd17842),
                  ),
                )
              : Text(""),
        ],
      ),
    );
  }

  Widget buildSingleItem({
    images,
    title,
    subTitle,
    price,
    context,
    rating,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => DetailPage()));
      },
      child: Container(
        width: screenWidth * 0.4 + 10,
        height: screenHeight * 0.3,
        margin: EdgeInsets.all(15.0),
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Color(0xff17191f),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 2.0,
                          spreadRadius: 1.0,
                          color: Color(0xff30221f),
                        ),
                      ],
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(images),
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        subTitle,
                        style: TextStyle(
                          color: Color(0xffaeaeae),
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Color(0xff141921),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      // child: Icon(
                      //   Icons.person,
                      //   color: Color(0xff4d4f52),
                      //   size: 20,
                      // ),
                    ),
                    Container(
                      // child: Button(
                      //     label: Text(""),
                      //     onPressed: () {
                      //       logout(context);
                      //     }),
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          color: Color(0xff141921),
                          borderRadius: BorderRadius.circular(15.0),
                          image: DecorationImage(
                            image: AssetImage("images/medSkin.png"),
                          )),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Hello User",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "Welcome back",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54,
                      ),
                    )
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      padding: EdgeInsets.all(12.0),
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      height: screenHeight * 0.2 - 10,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xff171b22),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 2.0,
                                    spreadRadius: 1.0,
                                    color: Color(0xff30221f),
                                  ),
                                ],
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    "images/wallpaper.jpg",
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Use the correct cleanser for \n your skin type ",
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                // Text(
                                //   "With Oat Milk",
                                //   style: TextStyle(
                                //     color: Color(0xffaeaeae),
                                //   ),
                                // ),

                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: ListTile(
                  leading: Text(
                    "History",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0,),
              // SingleChildScrollView(
              //   physics: BouncingScrollPhysics(),
              //   scrollDirection: Axis.horizontal,
              //   child: Row(
              //     children: [
                    FadeAnimation(1.8, Container(
                      height: 200,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          makeVideo(image: 'images/profilePicture.jpg'),
                          makeVideo(image: 'images/dis1.jpg'),
                          makeVideo(image: 'images/dis3.jpg'),
                        ],
                      ),
                    )),
                    // buildSingleItem(
                    //   context: context,
                    //   images: "images/wallpaper.jpg",
                    //   title: "Rashes",
                    //   subTitle: "Skin Rash",
                    //   // price: 4.20,
                    //   // rating: 4.5,
                    // ),
                    // buildSingleItem(
                    //   context: context,
                    //   images: "images/wallpaper.jpg",
                    //   title: "Pimples",
                    //   subTitle: "Face Pimples",
                    //   // price: 3.14,
                    //   // rating: 4.5,
                    // ),
                    // buildSingleItem(
                    //   context: context,
                    //   images: "images/wallpaper.jpg",
                    //   title: "Pimples",
                    //   subTitle: "Face pimples",
                    //   // price: 3.14,
                    //   // rating: 4.5,
                    // ),
                    // buildSingleItem(
                    //   images: "images/coffee4.jpeg",
                    //   title: "Cappuccino",
                    //   subTitle: "With Chocolate",
                    //   price: 3.14,
                    //   rating: 4.5,
                    // ),
                    // buildSingleItem(
                    //   context: context,
                    //   images: "images/coffee5.jpeg",
                    //   title: "Cappuccino",
                    //   subTitle: "With Chocolate",
                    //   price: 3.14,
                    //   rating: 4.5,
                    // ),
                    // buildSingleItem(
                    //   context: context,
                    //   images: "images/coffee6.jpeg",
                    //   title: "Cappuccino",
                    //   subTitle: "With Chocolate",
                    //   price: 3.14,
                    //   rating: 4.5,
                    // ),
                    // buildSingleItem(
                    //   context: context,
                    //   images: "images/coffee7.jpeg",
                    //   title: "Cappuccino",
                    //   subTitle: "With Chocolate",
                    //   price: 3.14,
                    //   rating: 4.5,
                    // ),
                  ],
                ),
              ),

            // ],
          ),
        // ),
      // ),
    );
  }
  // Future<void> logout(BuildContext context) async {
  //   await FirebaseAuth.instance.signOut();
  //   Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(builder: (context) => userLoginScreen()));
  // }

}

Widget makeVideo({image}) {
  return AspectRatio(
      aspectRatio: 1.5 / 1,
      child: Container(
        margin: EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
            )
        ),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  colors: [
                    Colors.black.withOpacity(.9),
                    Colors.black.withOpacity(.3),
                  ]
              )
          ),
          // child: Align(
          //   child: Icon(Icons.history, color: Colors.white, size: 70,),
          // ),
        ),
      )
  );
}
