import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:jmc/Pages/FirstPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Pages/HomePage.dart';

class Scrolling_Page_3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Image.asset(
            "assets/images/Scrolling_Fream_3.png",
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
          ),

          //for Heading
          Container(
            margin: const EdgeInsets.only(bottom: 100, left: 32, top: 32),
            padding: const EdgeInsets.only(top: 490),
            child: Text("How_1".tr,
                style: TextStyle(
                    fontFamily: "Gotham",
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            //child: const Text("Hi... How are you and are you ready for donation lets get started",style: TextStyle(fontFamily: "Gotham",fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white)),
          ),

          // //for Skip Button
          // Container(
          //   margin: const EdgeInsets.only(bottom: 100, left: 285),
          //   padding: const EdgeInsets.only(top: 56),
          //   child: TextButton(
          //     onPressed: () async {
          //       //only show only one time
          //       final prefs = await SharedPreferences.getInstance();
          //       prefs.setBool('showHome', true);

          //       //move to Home-Page
          //       Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //               builder: (context) =>
          //                   FirstPage(TempCheckUserLogin: 'false')));
          //     },
          //     style: ButtonStyle(
          //         backgroundColor: MaterialStateProperty.all(Color(0xBFEB91)),
          //         shape: MaterialStateProperty.all(RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(20)))),
          //     //for button text
          //     // ignore: prefer_const_constructors
          //     child: Text(
          //       "Skip",
          //       style: const TextStyle(
          //           color: Colors.white,
          //           letterSpacing: 0.4,
          //           fontFamily: "Gotham",
          //           fontSize: 19,
          //           fontWeight: FontWeight.bold),
          //     ),
          //   ),
          // ),

          //For Sub Heading
          Container(
            margin: const EdgeInsets.only(bottom: 100, left: 32, top: 18),
            padding: const EdgeInsets.only(top: 540),
            //child: const Text("Welcome",style: TextStyle(fontFamily: "Gotham",fontSize: 32,fontWeight: FontWeight.bold,color: Colors.white,)),
            child: Text("Quote_3".tr,
                style: const TextStyle(
                    fontFamily: "Gotham",
                    fontSize: 16,
                    height: 1.2,
                    fontWeight: FontWeight.w400,
                    color: Colors.white)),
          ),

          //final Button
          Container(
            margin: EdgeInsets.only(top: 620, left: 105),
            height: 50,
            width: 160,
            // color: Colors.white,
            decoration: BoxDecoration(
              color: HexColor("#22E183"),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
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

              //for button text
              child: Text(
                "Begin_1".tr,
                style: const TextStyle(
                    letterSpacing: 0.4,
                    fontFamily: "Gotham",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
