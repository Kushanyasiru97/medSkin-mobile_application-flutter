// import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medskin/admin/admin_screens/admin_login_screens.dart';
import 'package:medskin/admin/widgets/adminButton.dart';
import 'package:medskin/admin/widgets/changescreens.dart';
import 'package:medskin/admin/widgets/myTextFormField.dart';
import 'package:medskin/admin/widgets/passwordTextField.dart';

class adminSignUp extends StatefulWidget {
  const adminSignUp({Key? key}) : super(key: key);

  @override
  State<adminSignUp> createState() => _adminSignUpState();
}

final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

String p =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

RegExp regExp = new RegExp(p);
bool obserText = false;
late String email;
late String password;


class _adminSignUpState extends State<adminSignUp> {

  Future<void> validation() async {
    final FormState? _form = _formkey.currentState;
    if(_form!.validate()){
      try{
        UserCredential result = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        print(result.user!.uid);
      }on PlatformException catch (e){
        print(e.message.toString());
        // _scaffoldKey.currentState!.showSnackBar(SnackBar(content: String?Text(e.message),),);
        _scaffoldKey.currentState!.showSnackBar(SnackBar(content:Text("Hello")));
      }
    }
    else{ }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Form(
          key: _formkey,
          child: Container(
            child: Column(
              children: [
                Container(
                  height: 180.0,
                  width: double.infinity,
                  color: Colors.blue,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 50.0,
                          fontWeight:FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0,),
                Container(
                  height: 400.0,
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  width: double.infinity,
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      myTextFormField(
                          // obserText: obserText,
                          validation: (value){
                            if(value == ""){
                              return "Please Fill User Name ";
                            }
                            else if(value!.length<6){
                              return "Your User name is too short";
                            }
                            return "";
                          },
                          name: "User Name",
                        onChanged: (String? value) {  },
                      ),

                      myTextFormField(
                          // obserText: obserText,
                          validation: (value){
                            if(value==""){
                              return "Please Enter your Email";
                            }
                            else if(regExp.hasMatch(value!)==false){
                              return "Email is Invalid";
                            }
                            return "";
                          },
                          name: "Email",
                        onChanged: (value){
                            setState(() {
                              email = value! ;
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
                              password = value!;
                            });
                          },
                          onTap: (){
                            setState(() {
                              obserText = obserText;
                            });
                            FocusScope.of(context).unfocus();
                          },
                      ),

                      passwordTextField(
                          obserText: !obserText,
                          validation: (value){
                            if(value == ""){
                              return "Plese Comfirm your Password";
                            }
                            else if(value!.length<8){
                              return "Password is too Short!";
                            }
                            return "";
                          },
                          name: "Comfirm Password",
                          onChanged: (value) {
                            setState(() {
                              password = value!;
                            });
                          },
                          onTap: (){
                            setState(() {
                              obserText = !obserText;
                            });
                            FocusScope.of(context).unfocus();
                          },
                      ),

                      myButton(
                          onPresssed:validation,
                          name: "SignUp",
                      ),
                      changeScreen(
                          name: 'I have Already An Account',
                          onTap: (){
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>adminLogin(),));
                        },
                        change: "Login",
                      )

                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
