
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medskin/firestore_test/Data.dart';
import 'package:medskin/firestore_test/doctorNotifier.dart';
import 'package:provider/provider.dart';

class firebaseHome extends StatefulWidget {
  const firebaseHome({Key key}) : super(key: key);

  @override
  _firebaseHomeState createState() => _firebaseHomeState();
}

class _firebaseHomeState extends State<firebaseHome> {

  // final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  var loggedInUser;
  String useremail2 = ' ';
  String messagetext;

/*
  void MessagesStram() async {

  }
*/
  void geturlfromup(String id3) async {
    final messages1 = await FirebaseFirestore.instance.collection('doctors').get();
    {
      // print(messages1.data()['downloadURL']);
      // messages1.data()['downloadURL'];
    }
  }
/*
  Future<String> Mgeturlfromuplord(value1) async {
    final messages1 = await _firestore
        .collection('uploads')
        .where('itemid', isEqualTo: value1)
        .get();
    for (var m in messages1.docs) {
      // print(m.data());
      var xx = m.data()['downloadURL'];
      print(xx.toString());
      return xx.toString();
    }
  }*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
    //print(geturlfromup("Khc1T6CRMmN0pCe1b6N1"));
    //print(Mgeturlfromuplord("Khc1T6CRMmN0pCe1b6N1"));

  }

  void getCurrentUser() async {
    final user = await _auth.currentUser;
    if (user != null) {
      print('checkpoint1');
      setState(() {
        useremail2 = user.email;
      });
//var loggedInUSer;
      //loggedInUser==user;
      print(user.email);
    } else {
      print('check2');
    }
  }




  // List<Data> doctorList = [];

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   DatabaseReference referenceData = FirebaseDatabase.instance.reference().child("doctorList");
  //   referenceData.once().then((dataSnapshot){
  //     doctorList.clear();
  //     var keys = dataSnapshot.value.keys;
  //     var values = dataSnapshot.value;
  //
  //     for(var key in keys){
  //       Data data = new Data(
  //         values[key]["imgUrl"],
  //           values[key]["name"],
  //           values[key]["age"],
  //       );
  //       doctorList.add(data);
  //     }
  //     setState(() {
  //
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        backgroundColor: Color(0xffff2fc3),
        title: Text("Firebase"),
      ),
      body: StreamBuilder(
      stream: FirebaseFirestore.instance.collection('doctors').snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
    if(!snapshot.hasData){
    return Center(
    child: CircularProgressIndicator(),
    );
    }

    return Row(
    children: snapshot.data.docs.map((document)  {
    String /*Timestamp*/ timestamp = document['firstName'];
    return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
    // height: size.height*0.2,

    // color: Colors.teal,
    child: Row(
    children: [
    Container(
    //height: size.height * 0.1,

    // images/comment.png
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(6.0),
    ),
    child: Container(
    padding: const EdgeInsets.all(6.0),
     // height: 50,
    width: 300,
    child:ListView(
      children: [
    ListTile(
    // leading: Image.network('image'),
    title: Text(document['email']),
      subtitle: Text(document['secondName']),
    ),
      ],

    ),

    ),
    // Column(
    // children: [
    // Align(
    // alignment: Alignment.centerRight,
    // child: Text(
    // document['firstName'],
    // overflow: TextOverflow.ellipsis,
    //
    // ),
    // ),
    // // Text(timeago.format(DateTime.tryParse(timestamp.toDate().toString())).toString()),
    // ],
    ),

    ],
    )
      ),
    );

    }).toList(),
    );
    }
    ),
    );
  }
}
