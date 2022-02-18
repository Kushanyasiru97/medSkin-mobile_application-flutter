import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medskin/screens/mysplashscreen.dart';
import 'package:medskin/uh/bottom_page.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:tflite/tflite.dart';


class Home extends StatefulWidget {

  String imgPath;
  File image2;

  Home({this.imgPath});







  // const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _loading = true;
  List output;
  File image;
  String im2;

  final picker = ImagePicker();

  @override
  void initState() {








    super.initState();
    loadMode().then((value) {
      setState(() {});
    });
  }

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
      _loading = false;
    });
  }

  loadMode() async {
    await Tflite.loadModel(
        model: 'assets/model.tflite', labels: 'assets/labels.txt');
  }

  pickImage() async {
    var img = await picker.pickImage(source: ImageSource.camera);
    if (img == null) return null;

    setState(() {
      image = File(img.path);
    });

    detectImage(image);
  }

  pickGalleryImage() async {
    var img = await picker.pickImage(source: ImageSource.gallery);
    if (img == null) return null;

    setState(() {
      image = File(img.path);
    });

    detectImage(image);
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
            SizedBox(
              height: 20.0,
            ),

            SizedBox(
              height: 5.0,
            ),
            Text(
              'MedSkin',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 30.0),
            ),
            SizedBox(
              height: 50.0,
            ),
            Center(
              child: _loading
                  ? Container(
                width: MediaQuery.of(context).size.width - 100,
                child: Column(
                  children: [
                    Image.asset('images/medSkin.png'),

                    SizedBox(
                      height: 50.0,
                    )
                  ],
                ),
              )
                  : Container(
                child: Column(
                  children: [
                    FlatButton(

                      height: 250.0,
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => BottomPage()));
                      },
                      child: Image.file(image),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    output != null
                        ? Text(
                      '${output[0]['label']}',
                      style: TextStyle(
                          color: Colors.black, fontSize: 30.0),
                    )
                        : Container(),
                    SizedBox(
                      height: 10.0,
                    )
                  ],
                ),
              ),
            ),

            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      pickImage();
                    },
                    child: Container(
                      child: Text(
                        'Camera',
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 18.0),
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(6.0)),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      pickGalleryImage();
                    },
                    child: Container(
                      child: Text(
                        'gallery',
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 18.0),
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(6.0)),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<ByteData> getBytesFromFile() async{
    Uint8List bytes = File(widget.imgPath).readAsBytesSync() as Uint8List;
    return ByteData.view(bytes.buffer);
  }
}
