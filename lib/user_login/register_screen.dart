import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medskin/screens/mysplashscreen.dart';
import 'package:medskin/user_login/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}



class _SignUpScreenState extends State<SignUpScreen> {
  _googleSignUp() async {
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: ['email'],
      );
      final FirebaseAuth _auth = FirebaseAuth.instance;

      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final User? user = (await _auth.signInWithCredential(credential)).user;
      // print("signed in " + user.displayName);

      return user;
    } catch (e) {

      //print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('images/wallpaper.jpg'),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 700.0,
              width: double.infinity,
              //color: Colors.red,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Text("Signin to Continue"),
                  Text(
                    "MedSkin",
                    style: TextStyle(
                        fontSize: 70.0,
                        color: Colors.blue,
                        shadows: [
                          BoxShadow(
                            blurRadius: 5.0,
                            color: Colors.white,
                            offset: Offset(3,3),
                          )
                        ]
                    ),
                  ),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                FlutterLogo(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    "Signup Here",
                    style: TextStyle(
                      fontSize: 30.0,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.90,
                  child: Form(

                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(), labelText: "Email"),

                        ),
                        SizedBox(height: 5.0,),
                        TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(), labelText: "Email"),

                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(), labelText: "Email"),

                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Password"),
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: "This Field Is Required."),
                              MinLengthValidator(6,
                                  errorText: "Minimum 6 Characters Required.")
                            ]),
                          ),
                        ),
                        RaisedButton(
                          onPressed: (){},//handleSignup,
                          color: Colors.green,
                          textColor: Colors.white,
                          child: Text(
                            "Sign Up",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                MaterialButton(
                  padding: EdgeInsets.zero,
                  onPressed: (){
                    _googleSignUp().then((value)=> Navigator.of(context).pushReplacement(MaterialPageRoute(
                                      builder: (context)=> MySplashScreen(),),),);
                  },
                  child: Image(
                    image: AssetImage('images/signin.png'),
                    width: 200.0,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                InkWell(
                  onTap: () {
                    // send to login screen
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => userSignin()));
                  },
                  child: Text(
                    "Login Here",
                  ),
                ),
              ],
            ),
          ),


                  // Column(
                  //   children: [
                  //     SignInButton(
                  //         Buttons.Google,
                  //         text: 'Sign in with Google',
                  //         onPressed: (){
                  //           _googleSignUp().then((value)=> Navigator.of(context).pushReplacement(MaterialPageRoute(
                  //               builder: (context)=> MySplashScreen(),),),);
                  //         }
                  //         ),
                  //   ],
                  // ),
                  Column(
                    children: [
                      Text("By Signing in you are agreeing with our ",style: TextStyle(color: Colors.grey),),
                      Text("Terms & Conditions ",style: TextStyle(color: Colors.grey),),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

