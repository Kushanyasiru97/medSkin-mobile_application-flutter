import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class progressDialog extends StatelessWidget {
  // const progressDialog({Key? key}) : super(key: key);

  String message;
  progressDialog({this.message});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.white60,
      child: Container(
        margin: EdgeInsets.all(20.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              SizedBox(width: 8.0,),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black,),
              ),
              SizedBox(width: 10.0,),
              Text(
                message,
                style: TextStyle(
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
