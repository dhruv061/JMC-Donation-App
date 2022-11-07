// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:jmc/Pages/ChatBod.dart';

import 'package:jmc/Pages/DonationPage.dart';
import 'package:jmc/module/ProfilePage_AfterLogin.dart';
import 'package:jmc/module/defalutProfilePage.dart';

import '../provider/SignInProvider.dart';
import 'HomePage.dart';

class FirstPage extends StatefulWidget {
  //for konw user login with google or facebook or not
  final String TempCheckUserLogin;

  FirstPage({
    Key? key,
    required this.TempCheckUserLogin,
  }) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

//this is first page show after splach screen
class _FirstPageState extends State<FirstPage> {
  int indexValue = 0;
  late var Screens = [];

  @override 
  void initState() {
    //for change Screen
    Screens = [
      HomePage(),
      const DonationPage(),
      const Chatbod(),

      //show differtnt profile page for signin user and default users
      if (FirebaseAuth.instance.currentUser != null) ...[
        ProfilePage_Login(CheckUserLogin: widget.TempCheckUserLogin),
      ] else ...[
        DefaultProfilePaege(),
      ]
    ];

    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      //this is for when user touch nev bar then redirect thise corssponding pages
      indexValue = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Screens[indexValue],

          //for bottom navigation bar
          bottomNavigationBar: Container(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 9, vertical: 9),
              child: GNav(
                backgroundColor: Colors.white,
                color: Colors.black,
                activeColor: HexColor("#22E183"),
                tabBackgroundColor: HexColor("#D3FADE"),
                padding: const EdgeInsets.all(14),
                gap: 8,
                tabs: const [
                  GButton(
                    icon: Icons.home_filled,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.energy_savings_leaf_sharp,
                    text: 'Donation',
                  ),
                  GButton(
                    icon: Icons.chat,
                    text: 'Conversation',
                  ),
                  GButton(
                    icon: Icons.person_outline_rounded,
                    text: 'Profile',
                  ),
                ],

                //for changing Screen
                onTabChange: (index) {
                  setState(() {
                    this.indexValue = index;
                    // CheckInternert(index);
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
