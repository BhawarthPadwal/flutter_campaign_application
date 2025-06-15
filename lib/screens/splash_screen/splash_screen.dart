import 'dart:async';
import 'package:campaign_application/screens/home_page/home_page.dart';
import 'package:campaign_application/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../authentication/login_page.dart';
import 'package:logger/logger.dart';

class SplashScreen extends StatefulWidget {
  static const String rootName = 'splashScreen';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Logger logger = Logger();

  @override
  void initState() {
    super.initState();
    navigateAfterDelay();
  }

  void navigateAfterDelay() {
    Timer(const Duration(milliseconds: 2500), () {
      Navigator.pushReplacementNamed(context, LoginPage.rootName);
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // If logged in, go to home
        logger.d(user.uid);
        Navigator.pushReplacementNamed(context, HomePage.rootName);
      } else {
        // If not logged in, go to login
        Navigator.pushReplacementNamed(context, LoginPage.rootName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: whiteColor,
        body: SafeArea(
          child: Center(
            child: Image(
              image: AssetImage('assets/images/logo2.png'),
              width: size.width * 0.7,
            ),
          ),
        ),
      ),
    );
  }
}
