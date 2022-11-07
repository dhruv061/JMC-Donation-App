import 'dart:ui';

import 'package:flutter/material.dart';
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
                      child: const Text(
                        "Choose Where to donate",
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
                            child: const Text(
                              "JMC delivers your donation",
                              style: TextStyle(
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
                              child: const Text(
                                "Food for needy",
                                style: TextStyle(
                                    fontFamily: "Gotham",
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              //box 1 information
                              margin: const EdgeInsets.only(top: 8),
                              padding: const EdgeInsets.only(left: 21),
                              child: const Text(
                                "There are several villages in gujarat, Where people are in below povert line facing a great challange for single say meal",
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
                          child: const Text(
                            "Donate",
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
                height: 365,
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
                            padding: const EdgeInsets.only(right: 55),
                            child: const Text(
                              "Help for night shelters",
                              style: TextStyle(
                                  fontFamily: "Gotham",
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            //box 2 information
                            margin: const EdgeInsets.only(top: 8),
                            padding: const EdgeInsets.only(left: 21),
                            child: const Text(
                              "In large cities, Many times we can see night shelter that have no amenites for sleep. this type of people sleeps at",
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
                        child: const Text(
                          "Donate",
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
                            child: const Text(
                              "Fodders for cow",
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
                            child: const Text(
                              "The cow is considered as mother in indian culture and feeding the cow is considers aspicious.",
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
                        child: const Text(
                          "Donate",
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
                height: 395,
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
                            child: const Text(
                              "Women Empowerment",
                              style: TextStyle(
                                  fontFamily: "Gotham",
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            //box 4 information
                            margin: const EdgeInsets.only(top: 7),
                            padding: const EdgeInsets.only(left: 21),
                            child: const Text(
                              "The road to gender equality remains long and ever-shifting particularly when it comes to the nuanced ways gender intersects eith race, class and sexuality",
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
                        child: const Text(
                          "Donate",
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
                            child: const Text(
                              "Orphan adoption",
                              style: TextStyle(
                                  fontFamily: "Gotham",
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            //box 4 information
                            margin: const EdgeInsets.only(top: 7),
                            padding: const EdgeInsets.only(left: 21),
                            child: const Text(
                              "To have a kid is a parent's biggest happiness. Adoption seems to be the most effective way of achieving this joy. It arises as to the panacea to those who crave children's plight. Adoption can be the loveliest option not only for single parent and childless couples but also for homeless kids. It enables a parent-child relationship to be established between not biologically related",
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
                        child: const Text(
                          "Donate",
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

              //sixth box
              Container(
                height: 385,
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
                            child: const Text(
                              "Support cancer patients",
                              style: TextStyle(
                                  fontFamily: "Gotham",
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            //box 4 information
                            margin: const EdgeInsets.only(top: 7),
                            padding: const EdgeInsets.only(left: 21),
                            child: const Text(
                              "There's almost always something to smile about you can do anything you set your mind to. When cancer happens, you don't put life on hold",
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
                        child: const Text(
                          "Donate",
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
