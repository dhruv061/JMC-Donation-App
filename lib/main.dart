import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:jmc/BackEnd/Auth.dart';
import 'package:jmc/Language/language_controller.dart';
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
import 'Language/app_constants.dart';
import 'Language/message.dart';
import 'module/NotificationApi.dart';
import 'Language/dep.dart' as dep;

//puch Notification
const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

//when background notification recived this method intalize firebase
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  //for language settings
  Map<String, Map<String, String>> _languages = await dep.init();

  //background Notification Handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  //firebase local notification implmentation
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  //for forground Notification
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  //for showing onbording screen only one time
  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;

  WidgetsFlutterBinding.ensureInitialized();

  runApp(SMC(
    showHome: showHome,
    languages: _languages,
  ));
}

//define nevigator key
final navigatorKey = GlobalKey<NavigatorState>();

class SMC extends StatelessWidget {
  final bool showHome;

  const SMC({Key? key, required this.showHome, required this.languages})
      : super(key: key);
  final Map<String, Map<String, String>> languages;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalizationController>(
        builder: (localizationController) {
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
        child: GetMaterialApp(
          locale: localizationController.locale,
          translations: Messages(languages: languages),
          fallbackLocale: Locale(AppConstants.languages[0].languageCode,
              AppConstants.languages[0].countryCode),
          // translations: Localestring(),
          // locale: Locale('en','US '),
          home: showHome ? SplashScreen() : const OnboardingScreen(),
        ),
      );
    });

    // return MultiProvider(
    //   providers: [
    //     ChangeNotifierProvider(
    //       create: ((context) => SignInProvider()),
    //     ),
    //     ChangeNotifierProvider(
    //       create: ((context) => InternetProvider()),
    //     ),
    //     ChangeNotifierProvider(
    //       create: (_) => NotificationService(),
    //     ),
    //   ],

    //   //for Homepage

    //   child: MaterialApp(
    //     home: showHome ? SplashScreen() : OnboardingScreen(),
    //     // home: FirstPage(TempCheckUserLogin: 'false'),
    //     // home: OnboardingScreen(),
    //     // home: SplashScreen(),
    //   ),
    // );
  }
}
