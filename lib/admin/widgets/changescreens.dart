
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class changeScreen extends StatelessWidget {
  // const changeScreen({Key? key}) : super(key: key);

  final String name;
  final VoidCallback onTap;
  final String change;


  changeScreen({required this.name,required this.onTap,required this.change});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "I have Not Account!",
        ),
        SizedBox(width: 10.0,),
        GestureDetector(
          onTap: onTap,
          child: Text(
            change,
            style: TextStyle(
                color: Colors.cyan,
                fontSize: 25.0,
                fontWeight: FontWeight.bold
            ),
          ),
        )
      ],
    );
  }
}
