// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:jmc/BackEnd/Auth.dart';
import 'package:jmc/Language/language_screen2.dart';
import 'package:jmc/Pages/FirstPage.dart';
import 'package:jmc/module/MyRewarda.dart';
import 'package:jmc/Utils/NextScreen.dart';
import 'package:share_plus/share_plus.dart';

import '../Classes/UserTotalPayment.dart';
import '../Utils/SnackBar.dart';
import '../Classes/SessionController.dart';

class Tab1_HomeTab extends StatefulWidget {
  @override
  State<Tab1_HomeTab> createState() => _Tab1_HomeTabState();
}

class _Tab1_HomeTabState extends State<Tab1_HomeTab> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Container(
          height: height,
          width: width / 1.05,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white60,
          ),
          child: Column(
            children: [
              //my rewads
              ResuableContainer(
                icone: Icons.card_giftcard_outlined,
                title: 'My Rewards',
                function: () {
                  nextScreen(context, MyRewards());
                },
                padding: 93,
              ),

              //language settings
              ResuableContainer(
                  icone: Icons.settings,
                  title: 'language Setting',
                  function: () {
                    nextScreen(context, LanguageScreen2());
                  },
                  padding: 43),

              //share App
              ResuableContainer(
                  icone: Icons.share,
                  title: 'Share App',
                  function: () async {
                    await Share.share(
                      "જામનગર માં ચાલતા દાન નાં ભગીરથ કાર્ય માં હું તો જોડાય ગયો છું! તમે પણ આ એપ ડાઉનલોડ કરી આજે જ જોડાઈ શકો છો.\n https://play.google.com/store/apps/details?id=com.DhruvMavani.GtuAllInOne",
                    );
                  },
                  padding: 105),

              //Logout
              ResuableContainer(
                  icone: Icons.logout_outlined,
                  title: 'LogOut',
                  function: () async {
                    try {
                      //log out and clear user id from session controller
                      FirebaseAuth auth = FirebaseAuth.instance;
                      GoogleSignIn _googleSignIn = GoogleSignIn();
                      FacebookAuth facebookAuth = FacebookAuth.instance;

                      //for email signout
                      await auth.signOut().then((value) {
                        SessionController().userId = '';
                        nextScreenReplace(
                            context,
                            FirstPage(
                              TempCheckUserLogin: 'false',
                            ));
                      });

                      //for google signout
                      await _googleSignIn.signOut().then((value) {
                        SessionController().userId = '';

                        nextScreenReplace(
                            context,
                            FirstPage(
                              TempCheckUserLogin: 'false',
                            ));
                      });

                      //for facbook signout
                      await facebookAuth.logOut().then((value) {
                        SessionController().userId = '';

                        nextScreenReplace(
                            context,
                            FirstPage(
                              TempCheckUserLogin: 'false',
                            ));
                      });

                      // ignore: use_build_context_synchronously
                      nextScreenReplace(
                          context, FirstPage(TempCheckUserLogin: 'false'));
                    } catch (e) {
                      openSnackbar(context, e.toString(), Colors.red);
                    }
                  },
                  padding: 132),
            ],
          ),
        ),
      ),
    );
  }
}

//Resuable Containers
class ResuableContainer extends StatelessWidget {
  IconData icone;
  String title;
  Function function;
  double padding;

  ResuableContainer({
    Key? key,
    required this.icone,
    required this.title,
    required this.function,
    required this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: InkWell(
        onTap: () {
          function();
        },
        child: Container(
          height: 50,
          width: width / 1.1,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1.2,
                blurRadius: 5.5,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            children: [
              //for Icone
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Icon(
                  icone,
                  size: 33,
                  color: Colors.black,
                ),
              ),

              //for Title
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 3),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: "Gotham",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),

              //for Forword Icone
              Padding(
                padding: EdgeInsets.only(left: padding),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 33,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
