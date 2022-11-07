import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:jmc/BackEnd/Auth.dart';
import 'package:jmc/Utils/NextScreen.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DefaultProfilePaege extends StatefulWidget {
  @override
  State<DefaultProfilePaege> createState() => _DefaultProfilePaegeState();
}

//this page show When User Is Not Login
class _DefaultProfilePaegeState extends State<DefaultProfilePaege> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          //full page
          child: Column(
            children: [
              //profile container
              Container(
                margin: const EdgeInsets.only(top: 30),
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.circular(100)),

                //show user profile Pictue if he was sign in with hlep og Google
                child: CircleAvatar(
                  radius: 30,
                  child: ClipRRect(
                    child: Image.asset('assets/icons/DefaultAccountPhoto.png'),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),

              //display User name
              Container(
                margin: EdgeInsets.only(top: 15, left: 15),
                child: const Text(
                  "Hello Donor",
                  style: TextStyle(
                      fontFamily: "Gotham",
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),

              SizedBox(height: 10),

              //for signup Option
              //sign up butten
              SizedBox(
                height: 50,
                width: 150,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: HexColor("#D3FADE"),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),

                  child: Row(
                    children: [
                      //for text
                      Container(
                        margin: const EdgeInsets.only(left: 13),
                        child: Text(
                          "Sign in",
                          style: TextStyle(
                              fontFamily: 'Gotham',
                              color: HexColor("#002C00"),
                              fontSize: 20),
                        ),
                      ),

                      //for Icone
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 22,
                          color: HexColor("#002C00"),
                        ),
                      ),
                    ],
                  ),

                  //goto SignUp Page
                  onPressed: () {
                    nextScreen(context, AuthPage());
                  },
                ),
              ),

              //add line
              Divider(
                height: 30,
                thickness: 1.7,
                color: HexColor("#D3FADE"),
              ),

              //Invite your friend
              //for share app option
              Container(
                margin: const EdgeInsets.only(top: 35, bottom: 20),
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
                                borderRadius: const BorderRadius.all(
                                    const Radius.circular(20)),
                                border:
                                    Border.all(width: 1, color: Colors.black)),
                            child: TextButton(
                              //invite option shows
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

              //contact Info
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 15),
                  height: 215,
                  width: 340,
                  // color: Colors.yellow,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      border: Border.all(width: 2, color: HexColor('#22E183'))),

                  //show donation amount
                  child: Column(
                    children: [
                      //heading
                      const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          "Contact With JMC",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "Gotham",
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                      ),

                      //add line
                      Divider(
                        height: 30,
                        thickness: 1.7,
                        color: HexColor("#D3FADE"),
                      ),

                      SizedBox(height: 5),

                      //Row for Address
                      Row(
                        children: const [
                          Text(
                            "Address: ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "Gotham",
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                          Text(
                            "  Jamnagar Municipal  Corporation,\n Jubilee Garden, Jamnagar",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "Gotham",
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                        ],
                      ),

                      SizedBox(height: 15),

                      //Row for Phone
                      Row(
                        children: const [
                          Text(
                            "Phone: ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "Gotham",
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                          Text(
                            "     (0288) - 2550231 - 235",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "Gotham",
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                        ],
                      ),

                      SizedBox(height: 15),

                      //Row for Phone
                      Row(
                        children: const [
                          Text(
                            "Toll Free: ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "Gotham",
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                          Text(
                            "     1800 233 0131",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "Gotham",
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                        ],
                      ),

                      SizedBox(height: 15),

                      //Row for Email
                      Row(
                        children: const [
                          Text(
                            "Email: ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "Gotham",
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                          Text(
                            "     mcjamnagar@gmail.com",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "Gotham",
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                        ],
                      ),

                      SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
