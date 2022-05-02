
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medskin/others/dactor_listfirebase.dart';
import 'package:medskin/screens/mysplashscreen.dart';
import 'package:medskin/testing/first.dart';
import 'package:medskin/uh/bottom_page.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:tflite/tflite.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as paths;



class Home extends StatefulWidget {

  String imgPath;
  File path;
  File image2;

  Home({this.image2});

  // const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState(image2);
}

class _HomeState extends State<Home> {
  bool _loading = true;
  List output;
  File image;
  String im2;
  File image2;
  String Uemail;
  _HomeState(this.image2);

  final picker = ImagePicker();

  final _firestore = FirebaseFirestore.instance;

  final _auth = FirebaseAuth.instance;

  @override
  void initState() {

    super.initState();
    loadMode().then((value) {
      setState(() {
        image=image2;
        detectImage(image);
      }
      );
      //image=image2;

    });
    // getCurrentUser();
  }

  // void getCurrentUser() async {
  //   final user = await _auth.currentUser;
  //   if (user != null) {
  //     print('checkpoint1');
  //     print(user.email);
  //     setState(() {
  //       Uemail = user.email;
  //     });
  //   } else {
  //     print('check2');
  //   }
  // }


  detectImage(File image) async {
    var res = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.6,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      output = res;
      print(output);
      _loading = false;
    });
  }

  loadMode() async {
    await Tflite.loadModel(
        model: 'assets/model.tflite', labels: 'assets/labels.txt');
  }




  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(''),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),

      // backgroundColor: Colors.lightBlueAccent,

      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          /* ElevatedButton(onPressed:(){
             detectImage(image);
           }, child: Text("ueueu")),*/
          //  Text('${output[0]['confidence']}'),
            SizedBox(
              height: 5.0,
            ),
            Text(
              'MedSkin',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 50.0),
            ),
            SizedBox(
              height: 10.0,
            ),
            Center(
              child: _loading
                  ? Container(
                width: MediaQuery.of(context).size.width - 100,
                height: MediaQuery.of(context).size.height - 50,
                child: Column(
                  children: [
                    Image.asset('images/medSkin.png'),

                    SizedBox(
                      height: 5.0,
                    )
                  ],
                ),
              )
                  : Container(
                child: Column(
                  children: [
                    FlatButton(

                      height: 50.0,
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => doctorDetails()));
                        // uploadImageToFirebase();
                      },
                      child: Container
                        (
                        height:400,
                        width:500,
                        child: Image.file(image),
                      ),
                    ),
                    SizedBox(
                      height: 2.0,
                    ),
                    output != null
                        ? Text(
                      '${output[0]['label']}',
                      style: TextStyle(
                          color: Colors.black, fontSize: 30.0),
                    )
                        : Container(),

                  ],
                ),
              ),
            ),




          ],
        ),
      ),
    );
  }

  Future uploadImageToFirebase() async{
    String fileName = paths.basename(image2.path);
    Reference ref= FirebaseStorage.instance.ref().child('uploads').child('/$fileName');
    await ref.putFile(image2);
    var downloadUrl = await ref.getDownloadURL();

    // _firestore.collection('history').add({
    //   'downloadURL': downloadUrl,
    //   'sender': Uemail,
    // });
    BottomPage();
    
  }

}
