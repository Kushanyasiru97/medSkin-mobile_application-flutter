import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medskin/Person/page/fade_animator.dart';

class userProfile extends StatefulWidget {
  const userProfile({ Key key }) : super(key: key);

  @override
  _userProfileState createState() => _userProfileState();
}

class _userProfileState extends State<userProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                  expandedHeight: 450,
                  backgroundColor: Colors.black,
                  flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.pin,
                      background: Container(decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage('images/profilePicture.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.bottomRight,
                                  colors: [
                                    Colors.black,
                                    Colors.black.withOpacity(.3),
                                  ]
                              )
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                FadeAnimation(1, Text('Kushan Yasiru',style:
                                TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 40)
                                  ,)),
                                SizedBox(height: 20,),
                                // Row(
                                //     children: [
                                //       FadeAnimation(1.2,Text('96 posts',style:
                                //       TextStyle(color: Colors.grey,fontSize: 16)
                                //         ,)
                                //       ),
                                //       SizedBox(width: 50,),
                                //       FadeAnimation(1.3, Text('110 Millions followers',style: TextStyle(
                                //           color: Colors.grey,fontSize: 16
                                //       ),))
                                //     ]
                                // )
                              ],
                            ),
                          ),
                        ),
                      )
                  )
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // FadeAnimation(1.6, Text('Virat Kohli is an Indian cricketer and the current captain of the India national team. A right-handed top-order batsman, Kohli is regarded as one of the best contemporary batsmen in the world.',
                        //   style: TextStyle(color: Colors.grey,height: 1.4),
                        // )),
                        SizedBox(height: 20),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                FadeAnimation(1.6, Text('Date of Birth',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight:
                                FontWeight.bold,
                                ),
                                )),
                                SizedBox(height: 10,),
                                FadeAnimation(1.6,Text('1997/08/28',style: TextStyle(color: Colors.grey,fontSize: 15),)),
                              ],
                            ),
                            SizedBox(width: 150.0,),
                            Column(
                              children: [
                                FadeAnimation(1.6, Text('Age',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight:
                                FontWeight.bold,
                                ),),),
                                SizedBox(height: 10,),
                                FadeAnimation(1.6,Text('26',style: TextStyle(color: Colors.grey,fontSize: 15),)),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        // FadeAnimation(1.6,Text('1996/05/14',style: TextStyle(color: Colors.grey),)),
                        // SizedBox(height: 20,),
                        FadeAnimation(1.6, Text('Address',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight:
                        FontWeight.bold,
                        ),),),
                        SizedBox(height: 10,),
                        FadeAnimation(1.6,Text('334/4/B,Sandathenna, Kumbaloluwa,Veyangoda',style: TextStyle(color: Colors.grey,fontSize: 15),)),
                        SizedBox(height: 20,),

                        FadeAnimation(1.6, Text('Email',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight:
                        FontWeight.bold,
                        ),),),
                        SizedBox(height: 10,),
                        FadeAnimation(1.6,Text('kushan@gmail.com',style: TextStyle(color: Colors.grey,fontSize: 15),)),
                        SizedBox(height: 20,),

                        FadeAnimation(1.6, Text('Gender',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight:
                        FontWeight.bold,
                        ),),),
                        SizedBox(height: 10,),
                        FadeAnimation(1.6,Text('Male',style: TextStyle(color: Colors.grey,fontSize: 15),)),
                        SizedBox(height: 20,),
                        // FadeAnimation(1.6, Text("Videos",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight:
                        // FontWeight.bold,))),
                        // SizedBox(height: 20,),
                        // FadeAnimation(1.8, Container(
                        //   height: 200,
                        //   child: ListView(
                        //     scrollDirection: Axis.horizontal,
                        //     children: [
                        //       makeVideo(image: 'images/profilePicture.jpg'),
                        //       makeVideo(image: 'images/profilePicture.jpg'),
                        //       makeVideo(image: 'images/profilePicture.jpg'),
                        //     ],
                        //   ),
                        // )),
                        SizedBox(height: 120,),

                      ],

                    ),
                  )
                ]),
              )
            ],
          ),
          Positioned.fill(
            bottom: 20,
            child: Container(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: FadeAnimation(2,
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.blue[700]
                    ),
                    child: Align(child: Text("Edit", style: TextStyle(color: Colors.white),)),
                  ),

                ),

              ),
            ),
          )
        ],
      ),

    );
  }
}
// Widget makeVideo({image}){
//   return AspectRatio(
//     aspectRatio: 1.5/1,
//     child: Container(
//       margin: EdgeInsets.only(right: 20),
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//           image: DecorationImage(
//             image: AssetImage(image),
//             fit: BoxFit.cover,
//           )
//       ),
//       child: Container(
//         decoration: BoxDecoration(
//             gradient: LinearGradient(
//                 begin: Alignment.bottomRight,
//                 colors: [
//                   Colors.black.withOpacity(.9),
//                   Colors.black.withOpacity(.3),
//                 ]
//             )
//         ),
//         child: Align(
//           child: Icon(Icons.play_arrow,color: Colors.white,size: 70,),
//         ),
//       ),
//     ),
//   );
// }