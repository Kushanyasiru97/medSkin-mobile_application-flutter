// // @dart=2.9
// import 'package:flutter/material.dart';
// // import 'package:plant/constants.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:timeago/timeago.dart' as timeago;
//
//
//
//
// class NotificationScreen extends StatefulWidget {
//   static const String id = 'notification_screen';
//
//   @override
//   _NotificationScreenState createState() => _NotificationScreenState();
// }
//
// class _NotificationScreenState extends State<NotificationScreen> {
//   final _firestore = FirebaseFirestore.instance;
//   final _auth = FirebaseAuth.instance;
//
//   var loggedInUser;
//   String useremail2 = ' ';
//   String messagetext;
//
// /*
//   void MessagesStram() async {
//
//   }
// */
//   void geturlfromup(String id3) async {
//     final messages1 = await _firestore.collection('doctorList').doc().get();
//     {
//       // print(messages1.data()['downloadURL']);
//       // messages1.data()['downloadURL'];
//     }
//   }
// /*
//   Future<String> Mgeturlfromuplord(value1) async {
//     final messages1 = await _firestore
//         .collection('uploads')
//         .where('itemid', isEqualTo: value1)
//         .get();
//     for (var m in messages1.docs) {
//       // print(m.data());
//       var xx = m.data()['downloadURL'];
//       print(xx.toString());
//       return xx.toString();
//     }
//   }*/
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getCurrentUser();
//     //print(geturlfromup("Khc1T6CRMmN0pCe1b6N1"));
//     //print(Mgeturlfromuplord("Khc1T6CRMmN0pCe1b6N1"));
//
//   }
//
//   void getCurrentUser() async {
//     final user = await _auth.currentUser;
//     if (user != null) {
//       print('checkpoint1');
//       setState(() {
//         useremail2 = user.email;
//       });
// //var loggedInUSer;
//       //loggedInUser==user;
//       print(user.email);
//     } else {
//       print('check2');
//     }
//   }
//
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(title: Text('notifications'),backgroundColor: Colors.black,),
//       body: StreamBuilder(
//           stream: _firestore.collection('doctors').snapshots(),
//           builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
//             if(!snapshot.hasData){
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//             return Row(
//               children: snapshot.data.docs.map((document)  {
//                 // String Timestamp timestamp = document['name'];
//                 return Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: Container(
//                       height: size.height*0.2,
//
//                       color: Colors.teal,
//                       child: Row(
//                         children: [
//                           Container(
//                             //height: size.height * 0.1,
//
//                             // images/comment.png
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(6.0),
//                               ),
//                               child: Container(
//                                   padding: const EdgeInsets.all(6.0),
//                                   //  height: size.height * 0.5,
//                                   width:size.width*0.4,
//                                   child:
//                                   Text(document['email']))),
//
//                           Column(
//                             children: [
//                               Align(
//                                 alignment: Alignment.centerRight,
//                                 child: Text(
//                                   document['firstName'],
//                                   overflow: TextOverflow.ellipsis,
//
//                                 ),
//                               ),
//                               // Text(timeago.format(DateTime.tryParse(timestamp.toDate().toString())).toString()),
//                             ],
//                           ),
//
//                         ],
//                       )),
//                 );
//
//               }).toList(),
//             );
//           }
//       ),
//     );
//   }
// }
//
//
//


import 'package:flutter/material.dart';
import 'package:medskin/lalindu/Provider.dart';
import 'package:medskin/lalindu/bottom_Container.dart';
import 'package:medskin/lalindu/doctor_model.dart';
import 'package:provider/provider.dart';

class doctorListPage extends StatefulWidget {
  @override
  _doctorListPageState createState() => _doctorListPageState();
}

class _doctorListPageState extends State<doctorListPage> {


  List<doctorListModel> singledoctorList = [];





  @override
  Widget build(BuildContext context) {
    MyProvider provider = Provider.of<MyProvider>(context);

    provider.getFoodList();
    singledoctorList = provider.throwFoodModleList;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Doctor List",
        style: TextStyle(
          color: Colors.white,
        )),
        actions: [
          Padding(
            padding: const EdgeInsets.all(9.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('images/profile.jpg'),
            ),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              decoration: InputDecoration(
                  hintText: "Search Food",
                  hintStyle: TextStyle(color: Colors.white),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  filled: true,
                  fillColor: Color(0xff3a3e3e),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10))),
            ),
          ),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: 510,
            child: GridView.count(
                shrinkWrap: false,
                primary: false,
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: singledoctorList
                    .map(
                      (e) => BottomContainer(
                    onTap: () {
                      // Navigator.of(context).pushReplacement(
                      //   MaterialPageRoute(
                      //     builder: (context) => DetailPage(
                      //       image: e.image,
                      //       name: e.name,
                      //       age: e.age,
                      //     ),
                      //   ),
                      // );
                    },
                    image: e.image,
                    age: e.age,
                    name: e.name,
                  ),
                )
                    .toList()
            ),
          )
        ],
      ),
    );
  }
}

