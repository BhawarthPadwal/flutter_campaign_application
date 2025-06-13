import 'package:campaign_application/routes/routes.dart';
import 'package:campaign_application/screens/splash_screen/splash_screen.dart';
import 'package:campaign_application/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: MaterialApp(
        title: 'CampaignApplication',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          primaryColor: primaryColor,
          scaffoldBackgroundColor: whiteColor,
        ),
        home: const SplashScreen(),
        initialRoute: SplashScreen.rootName,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
