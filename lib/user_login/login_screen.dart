import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medskin/controllers/authentication.dart';
import 'package:medskin/screens/home.dart';
import 'package:medskin/screens/mysplashscreen.dart';
import 'package:medskin/user_login/register_screen.dart';

class userSignin extends StatefulWidget {
  const userSignin({Key? key}) : super(key: key);

  @override
  State<userSignin> createState() => _userSigninState();
}

class _userSigninState extends State<userSignin> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String _email, _password;

  checkAuthentication() async {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        print(user);

        Navigator.push(context,MaterialPageRoute(
            builder: (context)=> Home(),));

        // Navigator.pushReplacementNamed(context, "/");
      }
    });
  }
@override
    void initState(){
  super.initState();
  this.checkAuthentication();
    }
  userSignin() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        await _auth.signInWithEmailAndPassword(
            email: _email, password: _password);
      } catch (e) {
         // showError(e.errormessage);
        print(e);
      }
    }
  }
  showError(String errormessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ERROR'),
            content: Text(errormessage),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  navigateToSignUp() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
  }



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
              height: 550.0,
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
    FlutterLogo(
    size: 50.0,
    ),
    Padding(
    padding: EdgeInsets.symmetric(vertical: 20.0),
    child: Text(
    "Login Here",
    style: TextStyle(
    fontSize: 30.0,
    ),
    ),
    ),
    Container(
    width: MediaQuery.of(context).size.width * 0.90,
    child: Form(
      key: _formKey,
    child: Column(
    children: <Widget>[
    TextFormField(
    decoration: InputDecoration(
    border: OutlineInputBorder(), labelText: "Email"
    ),
      validator: (_val) {
        if (_val!.isEmpty) {
          return "Enter Email Address";
        } else {
          return null;
        }
      },
      onSaved: (val) {
        _email = val!;
      },
    ),

    Padding(
    padding: const EdgeInsets.symmetric(vertical: 20.0),
    child: TextFormField(
    obscureText: true,
    decoration: InputDecoration(
    border: OutlineInputBorder(),
    labelText: "Password"),
      validator: MultiValidator([
        RequiredValidator(
            errorText: "This Field Is Required."),
        MinLengthValidator(6,
            errorText: "Minimum 6 Characters Required.")
      ]),
      onSaved: (val) {
        _password = val!;
      },
    ),
    ),
    RaisedButton(
    // passing an additional context parameter to show dialog boxs
    onPressed: (){
      Navigator.of(context).pop();
    },//login,
    color: Colors.green,
    textColor: Colors.white,
    child: Text(
    "Login",
    ),
    ),
    ],
    ),
    ),
    ),
    MaterialButton(
    padding: EdgeInsets.zero,
    onPressed: () {
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
    MaterialPageRoute(builder: (context) => SignUpScreen()));
    },
    child: Text(
    "Sign Up Here",
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
