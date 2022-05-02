

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:medskin/doctors/screens/model/doctor_model.dart';
import 'package:medskin/testing/constants.dart';
import 'package:medskin/testing/data.dart';
import 'package:medskin/testing/doctorsNotifier.dart';
import 'package:medskin/testing/second.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  final Stream<QuerySnapshot> doctors= FirebaseFirestore.instance.collection('doctorList').snapshots();
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // final CategoriesScroller categoriesScroller = CategoriesScroller();
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;

  List<Widget> itemsData = [];

  List<DoctorModel> doctorList=[];

  List<Data> dataList =[];


  void getPostsData() {
    List<dynamic> responseList = doctor_List;
    List<Widget> listItems = [];
    responseList.forEach((post) {
      listItems.add(Container(
          height: 150,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    StreamBuilder(
                        stream: FirebaseFirestore.instance.collection("doctorList").snapshots(),
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                          if(!snapshot.hasData){
                            return Text("No Value");
                          }
                          return Row(
                            children: snapshot.data.docs.map((document) {
                              return Text(document['Name'],
                                  style: const TextStyle(fontSize: 17, color: Colors.grey),
                              );
                            }).toList(),
                          );
                        }
                    ),
                    // Text(
                    //   post["name"],
                    //   style: const TextStyle(
                    //       fontSize: 28, fontWeight: FontWeight.bold),
                    // ),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance.collection("doctorList").snapshots(),
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                          if(!snapshot.hasData){
                            return Text("No Value");
                          }
                          return Row(
                            children: snapshot.data.docs.map((document) {
                              return Text(document["Age"],
                                style: const TextStyle(fontSize: 17, color: Colors.grey),
                              );
                            }).toList(),
                          );
                        }
                    ),
                    // Text(
                    //   post["brand"],
                    //   style: const TextStyle(fontSize: 17, color: Colors.grey),
                    // ),
                    SizedBox(
                      height: 10,
                    ),
                    // FlatButton(
                    //     onPressed: () async{
                    //       DocumentSnapshot variable = await FirebaseFirestore.instance.collection("doctorList")
                    //           .doc('aqTy9d0AUaOO2uNf06tI').get();
                    //
                    //       print(variable['Name']);
                    //     },
                    //
                    //     child: Text("Get Data"),
                    // ),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance.collection("doctorList").snapshots(),
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                          if(!snapshot.hasData){
                            return Text("No Value");
                          }
                          return Row(
                            children: snapshot.data.docs.map((document) {
                              return Text(document['Name'],
                                style: const TextStyle(fontSize: 17, color: Colors.grey),
                              );
                            }).toList(),
                          );
                        }
                    ),
                    // Text(
                    //
                    //
                    //   // "\$ ${post["age"]}",
                    //   style: const TextStyle(fontSize: 25,
                    //       color: Colors.black,
                    //       fontWeight: FontWeight.bold),
                    // )
                  ],
                ),
                Image.asset(
                  "images/${post["image"]}",
                  height: double.infinity,
                )
              ],
            ),
          )));
    });
    setState(() {
      itemsData = listItems;
    });
  }

  @override
  void initState() {
    doctorNotifier doctorsNotifier = Provider.of<doctorNotifier>(context, listen: false);
    super.initState();

    // getPostsData();
    // controller.addListener(() {
    //   double value = controller.offset / 119;
    //
    //   setState(() {
    //     topContainer = value;
    //     closeTopContainer = controller.offset > 50;
    //   });
    // });
    }


  @override
  Widget build(BuildContext context) {
    doctorNotifier doctorsNotifier = Provider.of<doctorNotifier>(context);
    final Size size = MediaQuery
        .of(context)
        .size;
    final double categoryHeight = size.height * 0.30;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: Icon(
            Icons.menu,
            color: Colors.black,
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search, color: Colors.black),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.person, color: Colors.black),
              onPressed: () {},
            )
          ],
        ),
        body: ListView.separated(
            itemBuilder: (BuildContext context, int index){
              return ListTile(
                title: Text(
                  doctorsNotifier.doctorList[index].Name),
                subtitle:Text(doctorsNotifier.doctorList[index].Age),
              );
            },
            separatorBuilder: (BuildContext context, int index){
              return Divider(
                color: Colors.black,
              );
            },
            itemCount: doctorsNotifier.doctorList.length
        )
        // Container(
        //   // height: size.height,
        //   child: Column(
        //     children: <Widget>[
        //       // Row(
        //       //   mainAxisAlignment: MainAxisAlignment.spaceAround,
        //       //   children: <Widget>[
        //       //     Text(
        //       //
        //       //       "Loyality Cards",
        //       //       style: TextStyle(color: Colors.grey,
        //       //           fontWeight: FontWeight.bold,
        //       //           fontSize: 20),
        //       //     ),
        //       //     Text(
        //       //       "Menu",
        //       //       style: TextStyle(color: Colors.black,
        //       //           fontWeight: FontWeight.bold,
        //       //           fontSize: 20),
        //       //     ),
        //       //   ],
        //       // ),
        //       // const SizedBox(
        //       //   height: 10,
        //       // ),
        //       AnimatedOpacity(
        //         duration: const Duration(milliseconds: 200),
        //         opacity: closeTopContainer ? 0 : 1,
        //         child: AnimatedContainer(
        //             duration: const Duration(milliseconds: 200),
        //             width: size.width,
        //             alignment: Alignment.topCenter,
        //             // height: closeTopContainer ? 0 : categoryHeight,
        //             // child:
        //             // categoriesScroller
        //         ),
        //       ),
        //       Expanded(
        //           child: ListView.builder(
        //               controller: controller,
        //               itemCount: itemsData.length,
        //               physics: BouncingScrollPhysics(),
        //               itemBuilder: (context, index) {
        //                 double scale = 1.0;
        //                 if (topContainer > 0.5) {
        //                   scale = index + 0.5 - topContainer;
        //                   if (scale < 0) {
        //                     scale = 0;
        //                   } else if (scale > 1) {
        //                     scale = 1;
        //                   }
        //                 }
        //                 return Opacity(
        //                   opacity: scale,
        //                   child: Transform(
        //                     transform: Matrix4.identity()
        //                       ..scale(scale, scale),
        //                     alignment: Alignment.bottomCenter,
        //                     child: Align(
        //                         heightFactor: 0.7,
        //                         alignment: Alignment.topCenter,
        //                         child: itemsData[index]),
        //                   ),
        //                 );
        //               })),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}