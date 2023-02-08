// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:jmc/Classes/ImageUploadCheck.dart';
import 'package:jmc/Classes/UserTotalPayment.dart';
import 'package:jmc/Classes/UserTotalRewards.dart';
import 'package:jmc/module/MyRewarda.dart';

import 'package:jmc/module/SetImage.dart';
import 'package:jmc/Classes/UserData.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Pages/FirstPage.dart';
import '../Utils/NextScreen.dart';
import '../Utils/SnackBar.dart';
import '../provider/SignInProvider.dart';
import '../Classes/SessionController.dart';
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

  //for get payment detail from cloud firestore
  List<Payment_Details> _PaymentInfo = [];

  //if JMC is login then store data --> Total Funds and BenefitedLife
  DatabaseReference databaseRef = FirebaseDatabase.instance.ref('users');
  final totalFundController = TextEditingController();
  final benefitedLifeController = TextEditingController();

  //for Validation
  final _key = GlobalKey<FormState>();

  //for Loading Indicator
  bool isLodaing = false;

  @override
  void dispose() {
    totalFundController.dispose();
    benefitedLifeController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    widget.CheckUserLogin;
    super.initState();

    getData();

    //if image uploade then only called
    if (ImageUploadCheck().isImageUploaded == true) {
      getImageUrl();
    }

    //for get payment details
    _getPaymentInfo();
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

  //this method is use for getting user payment data from firebase
  //this same function available also in MyRewardPage
  void _getPaymentInfo() async {
    //for Payment Details --> Data Come From Cloud FireStore
    var paymentRef = FirebaseFirestore.instance
        .collection("users")
        .doc(SessionController().userId.toString())
        .collection("payments");
    var query = paymentRef.orderBy("timestamp", descending: true);
    var querySnapshot1 = await query.get();

    setState(() {
      //for get payment info
      _PaymentInfo = querySnapshot1.docs
          .map((doc) => Payment_Details.fromFirestore(doc.data()))
          .toList();
    });

    //also save total Re-ward in class for that we can access total Reward number in whole projects
    UserTotalRewards().userTotalRewards = _PaymentInfo.length;

    //save total payment in this class for that we can access total paument  in whole projects
    num totalDonation = 0;

    for (int i = 0; i < _PaymentInfo.length; i++) {
      var payment = _PaymentInfo[i];
      totalDonation += payment.amount;
    }

    UserTotalPayment().userTotalPayment = totalDonation;
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

    //if  JMC is login
    if (SessionController().userId.toString() ==
        'EpGw9CWD6aetSfQWQmXqoVG4oJ23') {
      return Scaffold(
          backgroundColor: HexColor("#D3FADE"),
          body: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  //For Image Logo
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Container(
                      // color: Colors.yellow,
                      height: 180,
                      width: 180,
                      child: Image.asset("assets/icons/Logo.png"),
                    ),
                  ),

                  //Upload Data
                  const Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Text(
                      "Upload Data",
                      style: TextStyle(
                          fontFamily: "Gotham",
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                  ),

                  //for TextFileds
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Form(
                      key: _key,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: [
                            //for Total Fund Text Filed
                            TextFormField(
                              keyboardType: TextInputType.number,

                              controller: totalFundController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                prefixIcon: Icon(
                                  Icons.monetization_on_outlined,
                                  color: HexColor("#002C00"),
                                ),
                                hintText: "Total Fund",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(33)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: HexColor("#002C00")),
                                  borderRadius: BorderRadius.circular(25.7),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(25.7),
                                ),
                              ),
                              //for validation
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enterTotal Funds";
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 13),

                            //for Benifited-Life Text Filed
                            TextFormField(
                              keyboardType: TextInputType.number,
                              controller: benefitedLifeController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                prefixIcon: Icon(
                                  Icons.horizontal_split,
                                  color: HexColor("#002C00"),
                                ),
                                hintText: "Benifited Life",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(33)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: HexColor("#002C00")),
                                  borderRadius: BorderRadius.circular(25.7),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(25.7),
                                ),
                              ),

                              //for validation
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter Benifited-Life";
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 16),

                            //for Upload Button
                            SizedBox(
                              height: 50,
                              width: 170,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: HexColor("#22E183"),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),

                                //for loading indicator and Text
                                icon: isLodaing
                                    ? const SizedBox()
                                    : const Icon(Icons.upload, size: 24),

                                label: isLodaing
                                    ? Row(
                                        children: [
                                          //for circular indicator
                                          Container(
                                            margin:
                                                const EdgeInsets.only(left: 7),
                                            height: 25,
                                            width: 25,
                                            child: CircularProgressIndicator(
                                              color: HexColor("#002C00"),
                                              strokeWidth: 3.5,
                                              backgroundColor: Colors.white,
                                            ),
                                          ),

                                          //for text
                                          Container(
                                            margin:
                                                const EdgeInsets.only(left: 7),
                                            child: Text(
                                              "Please Wait..",
                                              style: TextStyle(
                                                  fontFamily: 'Gotham',
                                                  color: HexColor("#002C00")),
                                            ),
                                          ),
                                        ],
                                      )
                                    : const Text(
                                        'Upload',
                                        style: const TextStyle(
                                            fontFamily: 'Gotham', fontSize: 22),
                                      ),

                                onPressed: () async {
                                  //for validation
                                  if (_key.currentState!.validate()) {
                                    //Update Data In firebase real time db only for jmc admin
                                    //jmc admin user id is : EpGw9CWD6aetSfQWQmXqoVG4oJ23
                                    databaseRef
                                        .child('EpGw9CWD6aetSfQWQmXqoVG4oJ23')
                                        .update({
                                      'TotalFunds': totalFundController.text,
                                      'BenefitedLife':
                                          benefitedLifeController.text
                                    });

                                    openSnackbar(context, 'Data Uploaded',
                                        Color.fromARGB(255, 85, 227, 90));

                                    //for Showing Loaing Indicator
                                    Future.delayed(
                                      Duration(seconds: 10),
                                      () {
                                        setState(() {
                                          isLodaing = true;
                                        });
                                      },
                                    );
                                  }
                                  //after run above line of code this Stop the Loading Indicator
                                  Future.delayed(
                                    Duration(seconds: 10),
                                    () {
                                      setState(() {
                                        isLodaing = false;
                                      });
                                    },
                                  );
                                },
                              ),
                            ),

                            const SizedBox(
                              height: 18,
                            ),

                            //for logOut Button
                            SizedBox(
                              height: 50,
                              width: 170,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: HexColor("#22E183"),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),

                                //for loading indicator and Text
                                icon:
                                    const Icon(Icons.logout_outlined, size: 24),

                                label: const Text(
                                  'Logout',
                                  style: const TextStyle(
                                      fontFamily: 'Gotham', fontSize: 22),
                                ),

                                onPressed: () async {
                                  //log out and clear user id from session controller
                                  FirebaseAuth auth = FirebaseAuth.instance;
                                  try {
                                    //for email signout
                                    await auth.signOut().then((value) {
                                      SessionController().userId = '';
                                      nextScreenReplace(
                                          context,
                                          FirstPage(
                                            TempCheckUserLogin: 'false',
                                          ));
                                    });
                                    nextScreenReplace(context,
                                        FirstPage(TempCheckUserLogin: 'false'));
                                  } catch (e) {
                                    openSnackbar(
                                        context, e.toString(), Colors.red);
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ));
    }

    //if user is login
    else {
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
                                    .child(
                                        SessionController().userId.toString())
                                    .onValue,
                                builder: (context, AsyncSnapshot snapshot) {
                                  if (snapshot.hasData) {
                                    //store All data in Userdata class
                                    Map<String, dynamic> jsonData = jsonDecode(
                                        jsonEncode(
                                            snapshot.data.snapshot.value));
                                    UserData.fromJson(jsonData);

                                    //for showing datain this class
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
                                                  padding:
                                                      const EdgeInsets.only(
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

                                            //for name & email
                                            Column(
                                              children: [
                                                //name
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 25),
                                                  child: Text(
                                                    map['Name'],
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 28,
                                                      fontFamily: "Gotham",
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),

                                                //E-mail
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5, left: 18),
                                                  child: Text(
                                                    map['Email'],
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontFamily: "Gotham",
                                                      fontWeight:
                                                          FontWeight.w300,
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
                                      padding: const EdgeInsets.only(
                                          left: 15, top: 6),
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
                                //for total donation amount
                                Text(
                                  UserTotalPayment()
                                              .userTotalPayment
                                              .toString() ==
                                          null
                                      ? "0"
                                      : UserTotalPayment()
                                          .userTotalPayment
                                          .toString(),
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
                                  UserTotalRewards()
                                                  .userTotalRewards
                                                  .toString() ==
                                              null ||
                                          UserTotalRewards().userTotalRewards ==
                                              0
                                      ? "0"
                                      : UserTotalRewards()
                                          .userTotalRewards
                                          .toString(),
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
}
