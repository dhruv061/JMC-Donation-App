import 'package:flutter/material.dart';
import 'package:jmc/BackEnd/Auth.dart';
import 'package:jmc/Pages/FirstPage.dart';
import 'package:jmc/Pages/HomePage.dart';
import 'package:jmc/Pages/OnBodingPage.dart';
import 'package:jmc/Pages/PaymentPage.dart';
import 'package:jmc/Pages/SignInPage.dart';
import 'package:jmc/Pages/SignUpPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:jmc/Pages/SplashScreen.dart';
import 'package:jmc/provider/InternetProvider.dart';
import 'package:jmc/provider/SignInProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'module/NotificationApi.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  //for showing onbording screen only one time
  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;

  WidgetsFlutterBinding.ensureInitialized();

  runApp(SMC(showHome: showHome));
}

//define nevigator key
final navigatorKey = GlobalKey<NavigatorState>();

class SMC extends StatelessWidget {
  final bool showHome;

  const SMC({Key? key, required this.showHome}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) => SignInProvider()),
        ),
        ChangeNotifierProvider(
          create: ((context) => InternetProvider()),
        ),
        ChangeNotifierProvider(
          create: (_) => NotificationService(),
        ),
      ],

      //for Homepage

      child: MaterialApp(
        home: showHome ? SplashScreen() : OnboardingScreen(),
        // home: FirstPage(TempCheckUserLogin: 'false'),
        // home: OnboardingScreen(),
        // home: SplashScreen(),
      ),
    );
  }
}
