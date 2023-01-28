// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:jmc/Pages/NotificationPage.dart';
import 'package:jmc/Pages/NotificationPage.dart';
import 'package:jmc/Utils/NextScreen.dart';

import '../module/SessionController.dart';
import '../provider/SignInProvider.dart';
import 'DonationPage.dart';
import 'JmcAboutUs.dart';

class HomePage extends StatefulWidget {
  //for konw user login with google or facebook or not
  final String CheckUserLogin;
  const HomePage({
    Key? key,
    required this.CheckUserLogin,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //for page indicator in slider
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    // for show user data on screen (User Name)
    final sp = context.watch<SignInProvider>();

    //for showing user data
    //this data comes from Real time database
    final ref = FirebaseDatabase.instance.ref('users');

    return Scaffold(
      backgroundColor: HexColor("#FFFFFF"),

      //For app bar
      appBar: AppBar(
        backgroundColor: HexColor("#22E183"),
        title: TextButton(
          onPressed: () {
            nextScreen(context, JmcAboutUs());
          },
          child: Row(
            children: [
              //for logo
              Container(
                height: 50,
                width: 50,
                child: Image.asset('assets/icons/Logo.png'),
              ),

              SizedBox(width: 10),

              //for title
              Container(
                padding: EdgeInsets.only(top: 13),
                height: 50,
                width: 80,
                // color: Colors.white,
                child: const Text(
                  "JMC",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Gotham',
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                ),
              ),
            ],
          ),
        ),
        elevation: 0,
        actions: [
          IconButton(
            padding: const EdgeInsets.only(right: 30),
            onPressed: () {
              //move to notificationpage
              nextScreen(context, NotificationPage());
            },
            icon: const Icon(
              Icons.notifications_none,
              color: Colors.black,
              size: 35,
            ),
          )
        ],
      ),

      //for main column
      body: SingleChildScrollView(
        child: Column(
          children: [
            //for show user name
            if (FirebaseAuth.instance.currentUser == null) ...[
              Container(
                margin: const EdgeInsets.only(top: 17, left: 12),
                padding: const EdgeInsets.only(left: 6, top: 15),
                height: 60,
                width: 340,
                // color: Colors.pink,
                child: const Text(
                  "Hello, Donor ",
                  style: TextStyle(
                      fontFamily: "Gotham",
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ] else ...[
              if (widget.CheckUserLogin == 'true') ...[
                Container(
                  margin: const EdgeInsets.only(top: 17, left: 12),
                  padding: const EdgeInsets.only(left: 6, top: 15),
                  height: 60,
                  width: 340,
                  // color: Colors.pink,
                  child: Text(
                    "Hello, ${sp.name} ",
                    style: const TextStyle(
                        fontFamily: "Gotham",
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ] else ...[
                StreamBuilder(
                  //this data comes from Real time database
                  stream:
                      ref.child(SessionController().userId.toString()).onValue,
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      Map<dynamic, dynamic> map = snapshot.data.snapshot.value;
                      return Container(
                        margin: const EdgeInsets.only(top: 17, left: 12),
                        padding: const EdgeInsets.only(left: 6, top: 15),
                        height: 45,
                        width: 340,
                        // color: Colors.pink,
                        child: Text(
                          "Hello, " + map['Name'],
                          style: const TextStyle(
                              fontFamily: "Gotham",
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      );
                    }
                    return Container();
                  },
                ),
              ]
            ],

            //for show sub title name
            Container(
              margin: const EdgeInsets.only(left: 12),
              padding: const EdgeInsets.only(left: 6, top: 3),
              height: 50,
              width: 340,
              // color: Colors.yellow,
              child: const Text(
                "With just RS. 10/- you can help millions people",
                style: TextStyle(
                  fontFamily: "Gotham",
                  fontSize: 15,
                  height: 1.3,
                ),
              ),
            ),

            //for showing 2 boxes --> fund box & Total people Box
            Container(
              child: Row(
                children: [
                  //for Total Fund BOX and Total Fund Hading
                  Container(
                    child: Column(
                      children: [
                        //for Total Fund BOX
                        Container(
                          margin: const EdgeInsets.only(left: 23, top: 17),
                          padding: const EdgeInsets.only(top: 28, left: 6),

                          height: 90,
                          width: 150,
                          // color: Colors.yellow,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              border: Border.all(
                                  width: 2, color: HexColor('#22E183'))),

                          //show donation amount
                          child: Text(
                            "0",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "Gotham",
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: HexColor("#22E183")),
                          ),
                        ),

                        //for Total Fund Hading
                        Container(
                          height: 20,
                          width: 150,
                          // color: Colors.pink,
                          margin: const EdgeInsets.only(left: 20, top: 12.5),

                          child: const Text(
                            "Total Fund",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "Gotham",
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //for Benefited Life BOX an Benefited Life Hading
                  Container(
                    child: Column(
                      children: [
                        //for Total Fund BOX
                        Container(
                          margin: const EdgeInsets.only(left: 20, top: 17),
                          padding: const EdgeInsets.only(top: 28, left: 6),

                          height: 90,
                          width: 150,
                          // color: Colors.yellow,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              border: Border.all(
                                  width: 2, color: HexColor('#22E183'))),

                          //show donation amount
                          child: Text(
                            "0",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "Gotham",
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: HexColor("#22E183")),
                          ),
                        ),

                        //for Total Fund Hading
                        Container(
                          height: 20,
                          width: 150,
                          // color: Colors.pink,
                          margin: const EdgeInsets.only(left: 18, top: 12.5),

                          child: const Text(
                            "Benefited life",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "Gotham",
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            //add line
            Divider(
              height: 30,
              thickness: 1.7,
              color: HexColor("#D3FADE"),
            ),

            //add image slider
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: CarouselSlider(
                items: [
                  //for Adpotion Image
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                            image:
                                AssetImage("assets/images/Adpotin_Slider.png"),
                            fit: BoxFit.cover)),
                  ),

                  //for Foode Image
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                            image: AssetImage("assets/images/Foode_Slider.png"),
                            fit: BoxFit.cover)),
                  ),

                  //for Night-silters Image
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                            image: AssetImage(
                                "assets/images/NightSilters_Slider.png"),
                            fit: BoxFit.cover)),
                  ),

                  //for CowFood Image
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                            image:
                                AssetImage("assets/images/CowFood_Slider.png"),
                            fit: BoxFit.cover)),
                  ),

                  //for Women Skill Image
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                            image: AssetImage("assets/images/Women_Slider.png"),
                            fit: BoxFit.cover)),
                  ),

                  //for Canser Image
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                            image:
                                AssetImage("assets/images/Canser_Slider.png"),
                            fit: BoxFit.cover)),
                  ),
                ],
                //for slider option
                options: CarouselOptions(
                    height: 180,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    viewportFraction: 0.8,

                    //for page indicator
                    onPageChanged: (index, reason) {
                      setState(() {
                        activeIndex = index;
                      });
                    }),
              ),
            ),

            //for animated page Indicator
            Container(
              margin: const EdgeInsets.only(top: 13),
              child: AnimatedSmoothIndicator(
                activeIndex: activeIndex,
                count: 6,
                effect: SwapEffect(
                    activeDotColor: HexColor("#22E183"),
                    dotColor: HexColor("#D3FADE"),
                    dotHeight: 14,
                    dotWidth: 14),
              ),
            ),

            //for share app option
            Container(
              margin: const EdgeInsets.only(top: 25, bottom: 20),
              height: 190,
              width: 313,
              decoration: BoxDecoration(
                  color: HexColor("#D3FADE"),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  border: Border.all(width: 1, color: HexColor("#D3FADE"))),

              //for image and share option
              child: Row(
                children: [
                  //for image
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    height: 175,
                    width: 83,
                    // color: Colors.blue,
                    child: Image.asset("assets/images/ShareImage.png"),
                  ),

                  //for title and share option
                  Container(
                    child: Column(
                      children: [
                        //for Heading
                        Container(
                          margin: const EdgeInsets.only(top: 35, left: 10),
                          padding: const EdgeInsets.only(top: 7),
                          height: 30,
                          width: 190,
                          // color: Colors.blue,
                          child: const Text(
                            "Invite Your friends",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "Gotham",
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),

                        //for subHeading
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          padding: const EdgeInsets.only(top: 2),
                          height: 30,
                          width: 185,
                          // color: Colors.blue,
                          child: const Text(
                            "and fight for odds togather",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "Gotham",
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                        ),

                        //for invite freinds Button
                        Container(
                          margin: const EdgeInsets.only(top: 6, left: 3),
                          height: 40,
                          width: 115,
                          // color: Colors.white,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              border:
                                  Border.all(width: 1, color: Colors.black)),
                          child: TextButton(
                            //invite option shows
                            onPressed: () async {
                              await Share.share(
                                "જામનગર માં ચાલતા દાન નાં ભગીરથ કાર્ય માં હું તો જોડાય ગયો છું! તમે પણ આ એપ ડાઉનલોડ કરી આજે જ જોડાઈ શકો છો.\n https://play.google.com/store/apps/details?id=com.DhruvMavani.GtuAllInOne",
                              );
                            },

                            //for button text
                            child: const Text(
                              "Invite friends",
                              style: TextStyle(
                                letterSpacing: 0.4,
                                fontFamily: "Gotham",
                                fontSize: 13,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            //add line
            Divider(
              height: 15,
              thickness: 1.7,
              color: HexColor("#D3FADE"),
            ),
          ],
        ),
      ),
    );
  }
}
