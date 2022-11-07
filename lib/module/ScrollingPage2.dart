import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:jmc/Pages/FirstPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Pages/HomePage.dart';

class Scrolling_Page_2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Image.asset(
            "assets/images/Scroling_Fream_2.png",
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
          ),

          //for Heading
          Container(
            margin: const EdgeInsets.only(bottom: 100, left: 31, top: 122),
            padding: const EdgeInsets.only(top: 490),
            child: const Text("What",
                style: TextStyle(
                    fontFamily: "Gotham",
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            //child: const Text("Hi... How are you and are you ready for donation lets get started",style: TextStyle(fontFamily: "Gotham",fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white)),
          ),

          //for Skip Button
          Container(
            margin: const EdgeInsets.only(bottom: 100, left: 283),
            padding: const EdgeInsets.only(top: 56),
            child: TextButton(
              onPressed: () async {
                //only show only one time
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool('showHome', true);

                //move to Home-Page
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            FirstPage(TempCheckUserLogin: 'false')));
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xBFEB91)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)))),
              //for button text
              // ignore: prefer_const_constructors
              child: Text(
                "Skip",
                style: const TextStyle(
                    color: Colors.white,
                    letterSpacing: 0.4,
                    fontFamily: "Gotham",
                    fontSize: 19,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),

          //for SubHeading
          Container(
            margin: const EdgeInsets.only(bottom: 100, left: 32, top: 110),
            padding: const EdgeInsets.only(top: 540),
            //child: const Text("Welcome",style: TextStyle(fontFamily: "Gotham",fontSize: 32,fontWeight: FontWeight.bold,color: Colors.white,)),
            child: const Text("JMC app will help you to donate needy peoples",
                style: TextStyle(
                    fontFamily: "Gotham",
                    height: 1.2,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
