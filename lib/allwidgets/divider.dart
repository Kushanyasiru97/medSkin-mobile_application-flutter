import 'package:flutter/material.dart';

class dividerWidget extends StatelessWidget {
  const dividerWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 2.0,
      color: Colors.black,
      thickness: 1.0,
    );
  }
}
