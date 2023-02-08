import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:jmc/Utils/NextScreen.dart';

import '../AboutsUsDonation/Adoption.dart';
import '../AboutsUsDonation/Canser.dart';
import '../AboutsUsDonation/CowFood.dart';
import '../AboutsUsDonation/FoodForNeady.dart';
import '../AboutsUsDonation/NightShelters.dart';
import '../AboutsUsDonation/Women.dart';
import 'PaymentPage.dart';

class DonationPage extends StatelessWidget {
  const DonationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor("#D3FADE"),

        // for app bar
        appBar: AppBar(
          backgroundColor: HexColor("#22E183"),
          toolbarHeight: 80,
          //for Heading & subheading
          title: Column(
            children: [
              Container(
                child: Column(
                  children: [
                    // sub container for main heading
                    Container(
                      margin: const EdgeInsets.only(top: 23, left: 8),
                      height: 25,
                      width: 361,
                      color: HexColor("#22E183"),
                      child: Text(
                        "Choose".tr,
                        style: TextStyle(
                            fontFamily: "Gotham",
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ),

                    // sub conatiner for both icon and sub heading
                    Container(
                      margin: const EdgeInsets.only(left: 4),
                      height: 40,
                      width: 361,
                      decoration: BoxDecoration(
                          color: HexColor("#22E183"),
                          borderRadius: BorderRadius.circular(100)),
                      child: Row(
                        //for adding icon and heading in row
                        children: [
                          Container(
                              //heart Icon
                              margin: const EdgeInsets.only(left: 5, top: 5),
                              height: 30,
                              width: 30,
                              child: Image.asset("assets/icons/Hart.png")),
                          Container(
                            //sub Heading
                            margin: const EdgeInsets.only(bottom: 7),
                            child: Text(
                              "JMC_delivers".tr,
                              style: const TextStyle(
                                  fontFamily: "Gotham",
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        body: SingleChildScrollView(
          child: Column(
            children: [
              //container for boxes -- that include image,info,collect button
              //for Box-1 --> Food for Needy
              Center(
                child: Container(
                  height: 365,
                  width: 303,
                  margin: const EdgeInsets.only(top: 30),
                  decoration: BoxDecoration(
                      color: HexColor("#FFFFFF"),
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      Container(
                        height: 202,
                        width: 303,
                        decoration: BoxDecoration(
                            image: const DecorationImage(
                                image: AssetImage(
                                    "assets/DonationPageImage/Foode.png"),
                                fit: BoxFit.fill),
                            color: Colors.lightBlueAccent,
                            borderRadius: BorderRadius.circular(20)),

                        //child: Image.asset("assets/images/Untitled.jpeg"),
                      ),
                      Container(
                        child: Column(
                          // for heading and details
                          children: [
                            Container(
                              //heading
                              margin: const EdgeInsets.only(top: 10),
                              padding: const EdgeInsets.only(right: 120),
                              child: Text(
                                "Food_for_needy".tr,
                                style: const TextStyle(
                                    fontFamily: "Gotham",
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              //box 1 information
                              margin: const EdgeInsets.only(top: 8),
                              padding: const EdgeInsets.only(left: 21),
                              child: Text(
                                "Food_quote".tr,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        //box 1 button
                        margin: const EdgeInsets.only(top: 20, left: 8),
                        height: 38,
                        width: 140,
                        child: TextButton(
                          onPressed: () {
                            //move to Payment Page
                            nextScreen(context, FoodForNeadyAboutUs());
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(HexColor("#22E183")),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),

                          //for button text
                          child: Text(
                            "Donate".tr,
                            style: TextStyle(
                                color: Colors.black,
                                letterSpacing: 0.4,
                                fontFamily: "Gotham",
                                fontSize: 19,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //second box
              Container(
                height: 400,
                width: 303,
                margin: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                    color: HexColor("#FFFFFF"),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    Container(
                      height: 202,
                      width: 303,
                      decoration: BoxDecoration(
                          image: const DecorationImage(
                              image: AssetImage(
                                  "assets/DonationPageImage/NightSilters.png"),
                              fit: BoxFit.fill),
                          color: Colors.lightBlueAccent,
                          borderRadius: BorderRadius.circular(20)),

                      //child: Image.asset("assets/images/Untitled.jpeg"),
                    ),
                    Container(
                      child: Column(
                        // for heading and details
                        children: [
                          Container(
                            //heading
                            margin: const EdgeInsets.only(top: 10),
                            padding: const EdgeInsets.only(right: 90),
                            child: Text(
                              "Help_for_homeless".tr,
                              style: const TextStyle(
                                  fontFamily: "Gotham",
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            //box 2 information
                            margin: const EdgeInsets.only(top: 8),
                            padding: const EdgeInsets.only(left: 21),
                            child: Text(
                              "Help_quote".tr,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      //box 2 button
                      margin: const EdgeInsets.only(top: 20, left: 8),
                      height: 38,
                      width: 140,
                      child: TextButton(
                        onPressed: () {
                          //move to  Page
                          nextScreen(context, NightAboutUs());
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(HexColor("#22E183")),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)))),

                        //for button text
                        child: Text(
                          "Donate".tr,
                          style: const TextStyle(
                              color: Colors.black,
                              letterSpacing: 0.4,
                              fontFamily: "Gotham",
                              fontSize: 19,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //third box
              Container(
                height: 360,
                width: 303,
                margin: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                    color: HexColor("#FFFFFF"),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    Container(
                      height: 202,
                      width: 303,
                      decoration: BoxDecoration(
                          image: const DecorationImage(
                              image: AssetImage(
                                  "assets/DonationPageImage/CowFood.png"),
                              fit: BoxFit.fill),
                          color: Colors.lightBlueAccent,
                          borderRadius: BorderRadius.circular(20)),

                      //child: Image.asset("assets/images/Untitled.jpeg"),
                    ),
                    Container(
                      child: Column(
                        // for heading and details
                        children: [
                          Container(
                            //heading
                            margin: const EdgeInsets.only(top: 10),
                            padding: const EdgeInsets.only(right: 110),
                            child: Text(
                              "Fodders_for_cow".tr,
                              style: const TextStyle(
                                  fontFamily: "Gotham",
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            //box 3 information
                            margin: const EdgeInsets.only(top: 8),
                            padding: const EdgeInsets.only(left: 21),
                            child: Text(
                              "Fooder_quote".tr,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      //box 3 button
                      margin: const EdgeInsets.only(top: 20, left: 8),
                      height: 38,
                      width: 140,
                      child: TextButton(
                        onPressed: () {
                          //move to  Page
                          nextScreen(context, CowAboutUs());
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(HexColor("#22E183")),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)))),

                        //for button text
                        child: Text(
                          "Donate".tr,
                          style: const TextStyle(
                              color: Colors.black,
                              letterSpacing: 0.4,
                              fontFamily: "Gotham",
                              fontSize: 19,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //fourth box
              Container(
                height: 480,
                width: 303,
                margin: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                    color: HexColor("#FFFFFF"),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    Container(
                      height: 202,
                      width: 303,
                      decoration: BoxDecoration(
                          image: const DecorationImage(
                              image: AssetImage(
                                  "assets/DonationPageImage/women.png"),
                              fit: BoxFit.fill),
                          color: Colors.lightBlueAccent,
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    Container(
                      child: Column(
                        // for heading and details
                        children: [
                          Container(
                            //heading
                            margin: const EdgeInsets.only(top: 13, left: 12),
                            padding: const EdgeInsets.only(right: 65),
                            child: Text(
                              "Women_Empowerment".tr,
                              style: const TextStyle(
                                  fontFamily: "Gotham",
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            //box 4 information
                            margin: const EdgeInsets.only(top: 7),
                            padding: const EdgeInsets.only(left: 21),
                            child: Text(
                              "Women_quote".tr,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      //box 4 button
                      margin: const EdgeInsets.only(top: 20, left: 8),
                      height: 38,
                      width: 140,
                      child: TextButton(
                        onPressed: () {
                          //move to  Page
                          nextScreen(context, WomanAboutUs());
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(HexColor("#22E183")),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)))),

                        //for button text
                        child: Text(
                          "Donate".tr,
                          style: TextStyle(
                              color: Colors.black,
                              letterSpacing: 0.4,
                              fontFamily: "Gotham",
                              fontSize: 19,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //fifth box
              Container(
                height: 460,
                width: 303,
                margin: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                    color: HexColor("#FFFFFF"),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    Container(
                      height: 202,
                      width: 303,
                      decoration: BoxDecoration(
                          image: const DecorationImage(
                              image: const AssetImage(
                                  "assets/DonationPageImage/Adpotin.png"),
                              fit: BoxFit.fill),
                          color: Colors.lightBlueAccent,
                          borderRadius: BorderRadius.circular(20)),

                      //child: Image.asset("assets/images/Untitled.jpeg"),
                    ),
                    Container(
                      child: Column(
                        // for heading and details
                        children: [
                          Container(
                            //heading
                            margin: const EdgeInsets.only(top: 10),
                            padding: const EdgeInsets.only(right: 100),
                            child: Text(
                              "Orphan_adoption".tr,
                              style: const TextStyle(
                                  fontFamily: "Gotham",
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            //box 4 information
                            margin: const EdgeInsets.only(top: 7),
                            padding: const EdgeInsets.only(left: 21),
                            child: Text(
                              "Orphan_quote".tr,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      //box 4 button
                      margin: const EdgeInsets.only(top: 20, left: 8),
                      height: 38,
                      width: 140,
                      child: TextButton(
                        onPressed: () {
                          //move to  Page
                          nextScreen(context, AdoptionAboutUs());
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(HexColor("#22E183")),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)))),

                        //for button text
                        child: Text(
                          "Donate".tr,
                          style: const TextStyle(
                              color: Colors.black,
                              letterSpacing: 0.4,
                              fontFamily: "Gotham",
                              fontSize: 19,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //sixth box
              Container(
                height: 450,
                width: 303,
                margin: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                    color: HexColor("#FFFFFF"),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    Container(
                      height: 202,
                      width: 303,
                      decoration: BoxDecoration(
                          image: const DecorationImage(
                              image: AssetImage(
                                  "assets/DonationPageImage/Canser.png"),
                              fit: BoxFit.fill),
                          color: Colors.lightBlueAccent,
                          borderRadius: BorderRadius.circular(20)),

                      //child: Image.asset("assets/images/Untitled.jpeg"),
                    ),
                    Container(
                      child: Column(
                        // for heading and details
                        children: [
                          Container(
                            //heading
                            margin: const EdgeInsets.only(top: 10),
                            padding: const EdgeInsets.only(right: 40),
                            child: Text(
                              "Support_cancer_patients".tr,
                              style: const TextStyle(
                                  fontFamily: "Gotham",
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            //box 4 information
                            margin: const EdgeInsets.only(top: 7),
                            padding: const EdgeInsets.only(left: 21),
                            child: Text(
                              "Cancer_quote".tr,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      //box 4 button
                      margin: const EdgeInsets.only(top: 20, left: 8),
                      height: 38,
                      width: 140,
                      child: TextButton(
                        onPressed: () {
                          //move to  Page
                          nextScreen(context, CanserAboutUs());
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(HexColor("#22E183")),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)))),

                        //for button text
                        child: Text(
                          "Donate".tr,
                          style: const TextStyle(
                              color: Colors.black,
                              letterSpacing: 0.4,
                              fontFamily: "Gotham",
                              fontSize: 19,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //for last
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
