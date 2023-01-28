// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:jmc/module/SetImage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Pages/FirstPage.dart';
import '../Utils/NextScreen.dart';
import '../Utils/SnackBar.dart';
import '../provider/SignInProvider.dart';
import 'SessionController.dart';
import 'Tab1_HomeTab.dart';
import 'Tab2_HistoryTab.dart';

class ProfilePage_AfterLogin extends StatefulWidget {
  //for konw user login with google or facebook or not
  String? CheckUserLogin;

  //check image uploaded or not
  bool? isImageUploaded;

  ProfilePage_AfterLogin({
    Key? key,
    this.CheckUserLogin,
  }) : super(key: key);

  @override
  State<ProfilePage_AfterLogin> createState() => _ProfilePage_AfterLoginState();
}

class _ProfilePage_AfterLoginState extends State<ProfilePage_AfterLogin> {
  // List of Tab Bar Item
  List<String> items = [
    "Home",
    "History",
  ];

  // List of body for Tab Bar
  List<Widget> TabPage = [Tab1_HomeTab(), Tab2_HistoryTab()];

  int current = 0;

  //Use for in tab bar page changes
  final _pageController = PageController();

  //for getting image URL From firebase storage
  String? _imageUrl;

  @override
  void initState() {
    widget.CheckUserLogin;
    super.initState();

    getData();

    getImageUrl();
  }

  void getImageUrl() async {
    // Fetch the image URL from the Realtime Database
    final ref = FirebaseDatabase.instance
        .ref()
        .child("users")
        .child(SessionController().userId.toString())
        .child('image_url');
    ref.once().then((DatabaseEvent event) {
      setState(() {
        _imageUrl = event.snapshot.value as String?;
      });
    });
  }

  //for getting data from firebase for google or facebook signin users
  @override
  Future getData() async {
    final sp = context.read<SignInProvider>();
    sp.getDataFromSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    //show user data when it signin using Google and FB
    final sp = context.watch<SignInProvider>();

    //for showing user data
    //this data comes from Real time database
    final ref = FirebaseDatabase.instance.ref('users');
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          //for Top part --> Photo,name,email,donation amount
          Container(
            height: height / 3.5,
            width: width,
            decoration: BoxDecoration(
              color: HexColor("#002C00"),
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
            ),
            child: Column(
              children: [
                //for Image and name,E-mail
                Padding(
                  padding: const EdgeInsets.only(top: 13),
                  child: Container(
                    // color: Colors.amber,
                    height: height / 7,
                    width: width,
                    child: Column(
                      children: [
                        //for showing user data from database --> Image , name and email if they Login withGooglw Or FB
                        if (widget.CheckUserLogin != 'true') ...[
                          //for showing user data from database --> Image , name and email if they Login with E-mail
                          Expanded(
                            child: StreamBuilder(
                              //this data comes from Real time database
                              stream: ref
                                  .child(SessionController().userId.toString())
                                  .onValue,
                              builder: (context, AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  Map<dynamic, dynamic> map =
                                      snapshot.data.snapshot.value;
                                  return Column(
                                    children: [
                                      Row(
                                        children: [
                                          //for Image
                                          InkWell(
                                            onTap: () {
                                              nextScreen(
                                                  context, const SetImage());
                                            },
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15),
                                                child: CircleAvatar(
                                                  radius: 55,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50.0),
                                                    child: _imageUrl == null
                                                        ? Image.asset(
                                                            'assets/icons/DefaultAccountPhoto.png')
                                                        : CachedNetworkImage(
                                                            imageUrl:
                                                                _imageUrl!),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),

                                          //for name & emial
                                          Column(
                                            children: [
                                              //name
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 25),
                                                child: Text(
                                                  map['Name'],
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 28,
                                                    fontFamily: "Gotham",
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),

                                              //E-mail
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 3),
                                                child: Text(
                                                  map['Email'],
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontFamily: "Gotham",
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                }

                                return Center(
                                  child: CircularProgressIndicator(
                                    color: HexColor("#F5F6EA"),
                                  ),
                                );
                              },
                            ),
                          ),
                        ] else ...[
                          Row(
                            children: [
                              //for Image
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 15, top: 2),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    backgroundImage:
                                        NetworkImage("${sp.imageUrl}"),
                                    radius: 50,
                                  ),
                                ),
                              ),

                              //for name and email
                              Column(
                                children: [
                                  //for name
                                  Padding(
                                    padding: const EdgeInsets.only(left: 13),
                                    child: Text(
                                      "${sp.name}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 28,
                                        fontFamily: "Gotham",
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),

                                  //for email
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 15, top: 6),
                                    child: Text(
                                      "${sp.email}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: "Gotham",
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ),

                //for Display Donation Amount and Rewards
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Container(
                    // color: Colors.blue,
                    height: height / 13,
                    width: width,
                    child: Row(
                      children: [
                        //for Display Total Donation Amount
                        Padding(
                          padding: const EdgeInsets.only(left: 80),
                          child: Column(
                            children: [
                              Text(
                                '2',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontFamily: "Gotham",
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 5),
                              const Text(
                                "Donated",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: "Gotham",
                                  fontWeight: FontWeight.w200,
                                ),
                              )
                            ],
                          ),
                        ),

                        VerticalDivider(
                          color: Colors.white, //color of divider
                          width: width / 9, //width space of divider
                          thickness: 1, //thickness of divier line
                          indent: 0, //Spacing at the top of divider.
                          endIndent: 0, //Spacing at the bottom of divider.
                        ),

                        //for Display Rewards Numbers
                        Padding(
                          padding: const EdgeInsets.only(left: 7),
                          child: Column(
                            children: [
                              Text(
                                '2',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontFamily: "Gotham",
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 5.6),
                              const Text(
                                "Rewards",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: "Gotham",
                                  fontWeight: FontWeight.w200,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          Container(
            margin: const EdgeInsets.only(top: 13),
            height: 60,
            // alignment: Alignment.center,
            child: ListView.builder(
                // physics: const BouncingScrollPhysics(),
                itemCount: 2,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            current = index;
                            _pageController.jumpToPage(index);
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.all(5),
                          width: width / 2.1,
                          height: 45,
                          decoration: BoxDecoration(
                            color: current == index
                                ? HexColor("#22E183")
                                : HexColor("#D3FADE"),
                            borderRadius: current == index
                                ? BorderRadius.circular(15)
                                : BorderRadius.circular(10),
                            border: current == index
                                ? Border.all(
                                    color: HexColor("#002C00"), width: 2)
                                : null,
                          ),
                          child: Center(
                            child: Text(
                              items[index],
                              style: TextStyle(
                                fontFamily: "Gotham",
                                fontWeight: FontWeight.w500,
                                color: current == index
                                    ? Colors.black
                                    : const Color.fromARGB(255, 99, 93, 93),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
          ),

          //body Part of Tab-1 and Tab-2
          Expanded(
            child: PageView(
              controller: _pageController,
              children: TabPage,
              onPageChanged: (index) {
                setState(() {
                  current = index;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
