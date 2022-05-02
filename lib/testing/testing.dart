

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebaseAuthDemo extends StatefulWidget {
  @override
  State<FirebaseAuthDemo> createState() => _FirebaseAuthDemoState();
}

class _FirebaseAuthDemoState extends State<FirebaseAuthDemo> {
  final TextEditingController _textEditingController = TextEditingController();

  final CollectionReference collectionReference = FirebaseFirestore.instance.collection('doctorList');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 50),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Container(
          child: Expanded(
                  child: StreamBuilder(stream: collectionReference.snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if(snapshot.hasData){
                        return ListView(
                          children: snapshot.data.docs.map((e) => Column(
                            children: [
                              ListTile(
                                title: Text(e['Name']),
                                subtitle: Text(e["Age"]),
                              ),
                              ListTile(
                                title: Text(e['Name']),
                                subtitle: Text(e["Age"]),
                              ),

                              Divider(color: Colors.black.withOpacity(0.6), thickness: 2,)
                            ],
                          )).toList(),
                        );
                      }
                      return Center(child: CircularProgressIndicator(),);
                    },

                  )),
        )
          // ],
        ),
      // ),
    );
  }
}