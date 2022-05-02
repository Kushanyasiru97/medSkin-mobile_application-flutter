import 'package:flutter/material.dart';


class dailytipContainer extends StatelessWidget {
  final String image;
  final String name;
  final Function onTap;

  dailytipContainer({@required this. onTap,@required this. image,@required this.name});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap ,
      child: Container(
        height: 270,
        width: 220,
        decoration: BoxDecoration(
            color: Color(0xff3a3e3e), borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(image),
            ),
            ListTile(
              leading: Text(
                name,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              trailing: Text(
                "\$ $name",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
            //
          ],
      ),
      ),
    );
  }
}