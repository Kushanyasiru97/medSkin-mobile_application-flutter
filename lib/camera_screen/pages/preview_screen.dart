
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:medskin/screens/home.dart';

class PreviewScreen extends StatefulWidget{
  String imgPath;
  File image;

  PreviewScreen({this.imgPath});

  @override
  _PreviewScreenState createState() => _PreviewScreenState(imgPath);

}
class _PreviewScreenState extends State<PreviewScreen>{

  String imgPath;
  File image2;
  _PreviewScreenState(this.imgPath);
  @override
  Widget build(BuildContext context) {
    print(imgPath);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(imgPath),
            Expanded(
              flex: 2,
              child: Image.file(File(widget.imgPath),fit: BoxFit.cover,),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: 60.0,
                color: Colors.black,
                child: Center(
                  child: IconButton(
                    icon: Icon(Icons.upload_file,color: Colors.white,),
                    onPressed: (){


                      image2=File(widget.imgPath);

                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Home(
                             image2:image2,
                            // imgPath:img,
                          )));
















                      // getBytesFromFile().then((bytes){
                      //   // Share.file('Share via', basename(widget.imgPath), bytes.buffer.asUint8List(),'image/path');
                      // });
                    },
                  ),
                ),
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
