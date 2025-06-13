import 'package:campaign_application/screens/home_page/home_page.dart';
import 'package:campaign_application/screens/profile/profile.dart';
import 'package:campaign_application/screens/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../screens/authentication/login_page.dart';
import '../screens/authentication/signup_page.dart';

class Routes {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomePage.rootName:
        return getPageTransition(const HomePage(), settings);
      case LoginPage.rootName:
        return getPageTransition(const LoginPage(), settings);
      case SignupPage.rootName:
        return getPageTransition(const SignupPage(), settings);
      case SplashScreen.rootName:
        return getPageTransition(const SplashScreen(), settings);
      case Profile.rootName:
          return getPageTransition(const Profile(), settings);
      default:
        MaterialPageRoute(
          builder: (_) {
            return const Scaffold(
              body: Center(child: Text("No route defined")),
            );
          },
        );
    }
    return null;
  }

  static getPageTransition(dynamic screenName, RouteSettings settings) {
    return PageTransition(
      type: PageTransitionType.theme,
      child: screenName,
      settings: settings,
      alignment: Alignment.center,
      duration: const Duration(milliseconds: 1000),
      maintainStateData: true,
      curve: Curves.easeInOut,
    );
  }
}
