

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class myButton extends StatelessWidget {
  // const myButton({Key? key}) : super(key: key);

  Function onPresssed;
  final String name;

  myButton({required this.onPresssed,required this.name});


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.0,
      width: double.infinity,
      child: RaisedButton(
        child: Text(
            name,
        ),
        color: Colors.grey,
        onPressed: () {
          onPresssed();
        }
    ),
    );
    }
  }
