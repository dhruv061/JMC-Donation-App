// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:jmc/Utils/NextScreen.dart';

import 'FirstPage.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigatehome();
  }

  _navigatehome() async {
    await Future.delayed(Duration(milliseconds: 4500), () {});
    nextScreen(
        context,
        FirstPage(
          TempCheckUserLogin: 'false',
        ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Scaffold(
          body: Container(
            // child: Text(
            //   "splash screen",
            //   style: TextStyle(fontSize: 24),
            // ),
            height: 1000,
            width: 500,
            decoration: BoxDecoration(
                image: const DecorationImage(
                    image: AssetImage("assets/images/SplashScreen.png"),
                    fit: BoxFit.fill),
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(0)),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 250),
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                      image: const DecorationImage(
                          image:
                              AssetImage("assets/icons/SplashScreenLogo.png"),
                          fit: BoxFit.fill),
                      // color: Colors.lightBlueAccent,
                      borderRadius: BorderRadius.circular(0)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
