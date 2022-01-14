import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class myTextFormField extends StatelessWidget {
  // const myTextFormField({Key? key}) : super(key: key);
// final bool obserText;
final FormFieldValidator<String>? validation;
final String name;
final FormFieldValidator<String>? onChanged;

myTextFormField({ required this.validation,required this.name,required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      /********Validate*****************/
      // obscureText: obserText,
      validator:validation,
      onChanged: onChanged,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: name,
          hintStyle: TextStyle(
            color: Colors.black,
          )
      ),
    );
  }
}
