import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import 'package:vt/screens/home.dart';
import 'package:vt/authentication/email_login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Poshtik',
      theme: ThemeData(
        primaryColor: Colors.purple,
        secondaryHeaderColor: Colors.orange[100],
      ),
      home: IntroScreen(),
    );
  }
}

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? result = FirebaseAuth.instance.currentUser;
    return new SplashScreen(
        useLoader: true,
        loadingTextPadding: EdgeInsets.all(0),
        loadingText: Text(""),
        navigateAfterSeconds: result != null ? Home(uid: result.uid) : EmailLogIn() ,
        seconds: 5,
        title: new Text(
          "Let's Eat!",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.white,
              fontStyle: FontStyle.italic,
              letterSpacing: 1.2),
        ),
        image: Image.asset('assets/logo.png', fit: BoxFit.scaleDown),
        backgroundColor: Colors.purple,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 150.0,
        loaderColor: Colors.red);
  }
}