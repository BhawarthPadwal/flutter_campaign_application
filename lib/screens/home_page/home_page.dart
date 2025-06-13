import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../themes/theme.dart';

class HomePage extends StatefulWidget {
  static const String rootName = 'homePage';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        body: SafeArea(child: Center(child: Text('Home Page'))),
      ),
    );
  }
}
