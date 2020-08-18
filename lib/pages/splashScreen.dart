import 'package:flutter/material.dart';
import 'package:kutchmahamandalbhav/localization/transaltedValues.dart';
import 'package:kutchmahamandalbhav/routes/routesName.dart';
import 'package:kutchmahamandalbhav/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToHomePage();
  }

  void navigateToHomePage() async {
    FirebaseUser user = await Auth.getCurrentUser();
    if (user == null) {
      await Auth.signInAnonymously();
    }

    Future.delayed(Duration(milliseconds: 1500), () {
      Navigator.of(context).pushReplacementNamed(home);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          TransaltedValues.getTransaltedValues(
              context, 'home_page_app_bar_title'),
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
