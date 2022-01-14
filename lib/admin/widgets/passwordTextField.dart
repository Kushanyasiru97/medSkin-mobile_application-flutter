
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class passwordTextField extends StatelessWidget {

  // const passwordTextField({Key? key}) : super(key: key);

  final bool obserText;
  final FormFieldValidator<String>? validation;
  final String name;
  final VoidCallback onTap;
  final FormFieldValidator<String>? onChanged;

  passwordTextField({required this.obserText,required this.validation,required this.name,required this.onTap,required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      /********Validate*****************/
      obscureText: obserText,
      validator: validation,
      onChanged: onChanged,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: name,
          suffixIcon: GestureDetector(
            onTap: onTap,
            child: Icon(
              obserText == true? Icons.visibility: Icons.visibility_off,color: Colors.black,
            ),
          ),
          hintStyle: TextStyle(
            color: Colors.black,
          )
      ),
    );
  }
}
