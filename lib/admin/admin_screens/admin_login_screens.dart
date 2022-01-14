import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medskin/admin/widgets/adminButton.dart';
import 'package:medskin/admin/widgets/changescreens.dart';
import 'package:medskin/admin/widgets/myTextFormField.dart';
import 'package:medskin/admin/widgets/passwordTextField.dart';

import 'admin_signup_screen.dart';

class adminLogin extends StatefulWidget {
  const adminLogin({Key? key}) : super(key: key);

  @override
  State<adminLogin> createState() => _adminLoginState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
String p =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

RegExp regExp = new RegExp(p);
bool obserText = true;
late String email;
late String password;

Future<void> validation() async {
    final FormState? _form = _formKey.currentState;
    if(_form!.validate()){
      try{
        UserCredential result = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        print(result.user!.uid);
      }on PlatformException catch (e){
        print(e.message.toString());
      }
    }
    else{
      print("No");
    }
  }


class _adminLoginState extends State<adminLogin> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 300.0,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 50.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    myTextFormField(
                        // obserText: obserText,
                        validation: (value){
                          if(value == ""){
                            return "Plese Enter your Email";
                          }
                          else if(regExp.hasMatch(value!)==false){
                            return "Invalid Email";
                          }
                          return "";
                          },
                        name: "Email",
                      onChanged: (value) {
                        setState(() {
                          value = email;
                        });
                      },
                    ),

                    passwordTextField(
                        obserText: obserText,
                        validation: (value){
                          if(value == ""){
                            return "Plese Enter your Password";
                          }
                          else if(value!.length<8){
                            return "Password is too Short!";
                          }
                          return "";
                          },
                        name: "Password",
                      onChanged: (value) {
                        setState(() {
                          value = password;
                        });
                      },
                        onTap: (){
                          setState(() {
                            obserText = !obserText;
                          });
                          },
                    ),

                    myButton(
                      onPresssed:validation,
                      name: "Login",
                    ),

                    changeScreen(
                        name: "I don't have An Account",
                        onTap: (){
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>adminSignUp(),));
                          },
                      change: "SignUp",
                    ),


                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
