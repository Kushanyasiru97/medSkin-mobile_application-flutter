import 'package:flutter/material.dart';


class BottomContainer extends StatelessWidget {
  final String image;
  final String name;
  final String age;
  final Function onTap;

  BottomContainer({@required this. onTap,@required this. image, @required this. age, @required this.name});

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
                "\$ $age",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 12),
            //   child: Row(
            //     children: [
            //
            //       Icon(
            //         Icons.star,
            //         size: 20,
            //         color: Colors.white,
            //       )
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}