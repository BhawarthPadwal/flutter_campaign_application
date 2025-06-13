import 'package:campaign_application/screens/authentication/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../auth_services/auth_service.dart';
import '../../themes/theme.dart';

class Profile extends StatefulWidget {
  static const String rootName = 'profilePage';

  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: Text('Profile'),
          actions: [
            IconButton(
              onPressed: () {
                AuthService().signOutUser();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  LoginPage.rootName,
                  (route) => false,
                );
              },
              icon: Icon(Icons.logout),
            ),
          ],
        ),
        body: SafeArea(child: Center(child: Text('Profile Page'))),
      ),
    );
  }
}
