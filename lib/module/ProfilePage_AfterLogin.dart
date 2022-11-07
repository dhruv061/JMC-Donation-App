import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:jmc/Pages/FirstPage.dart';

import '../BackEnd/Auth.dart';
import '../Utils/NextScreen.dart';
import '../provider/SignInProvider.dart';

class ProfilePage_Login extends StatefulWidget {
  //for konw user login with google or facebook or not
  final String CheckUserLogin;

  ProfilePage_Login({
    Key? key,
    required this.CheckUserLogin,
  }) : super(key: key);

  @override
  State<ProfilePage_Login> createState() => _ProfilePage_LoginState();
}

class _ProfilePage_LoginState extends State<ProfilePage_Login> {
  //for WebView
  bool isLoading = true;
  final _key = UniqueKey();

  @override
  //for getting data from firebase
  Future getData() async {
    final sp = context.read<SignInProvider>();
    sp.getDataFromSharedPreferences();
  }

  //this foe konw if user sign in with (google , facebook) or gmail
  String? LoginType;

  @override
  void initState() {
    LoginType = widget.CheckUserLogin;

    super.initState();
    getData();
    // FetchUderDetail();
  }

  void CheckUserLoginMethod() {
    setState(() {
      //this is check if user login with google or facebook or not
      LoginType = widget.CheckUserLogin;
    });
  }

  //for Storing Image
  File? Images;

  //Image From Cemera
  ImageFromCemera() async {
    XFile? pickedImage = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      //convert XFile into File
      Images = File(pickedImage!.path);
    });
  }

  //Image From Gallery
  ImageFromGallery() async {
    XFile? pickedImage = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      //convert XFile into File
      Images = File(pickedImage!.path);
    });
  }

  //choose option from Open Gallery or Camera
  void ShowPicker(context) {
    showModalBottomSheet(
      backgroundColor: HexColor("#D3FADE"),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 20,
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: [
              //for choosing Image From Gallery
              ListTile(
                leading: Icon(
                  Icons.photo_library,
                  color: HexColor("#002C00"),
                  size: 25,
                ),
                title: const Text(
                  'Photo Library',
                  style: TextStyle(
                      fontFamily: 'Gotham',
                      fontWeight: FontWeight.w400,
                      fontSize: 18),
                ),
                onTap: () {
                  ImageFromGallery();
                  Navigator.of(context).pop();
                },
              ),

              //for choosing Image From Camera
              ListTile(
                leading: Icon(
                  Icons.photo_camera,
                  color: HexColor("#002C00"),
                  size: 25,
                ),
                title: const Text(
                  'Camera',
                  style: TextStyle(
                      fontFamily: 'Gotham',
                      fontWeight: FontWeight.w400,
                      fontSize: 18),
                ),
                onTap: () {
                  ImageFromCemera();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // for show data on screen
    final sp = context.watch<SignInProvider>();

    //for check if user signin with google or facbook or not
    final spc = context.read<SignInProvider>();

    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor("#D3FADE"),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 60),

              // // // //just check for value pass from constructor is working or not
              // TextButton(
              //   onPressed: () {
              //     // print("Check User Login : ${widget.CheckUserLogin}");
              //     // print("Login Type google: $LoginType");

              //   },
              //   child: Text("Check Login Type"),
              // ),

              //display user Profile Picture
              if (LoginType == 'true') ...[
                //if user login with google or facebook
                Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage("${sp.imageUrl}"),
                    radius: 50,
                  ),
                ),
              ] else ...[
                //for User Image if user login with E-mail address
                Center(
                  child: GestureDetector(
                    onTap: () {
                      ShowPicker(context);
                    },
                    child: CircleAvatar(
                      radius: 70,
                      backgroundColor: HexColor("#22E183"),
                      child: Images != null
                          ? ClipOval(
                              child: Image.file(
                                Images!,
                                height: 160,
                                width: 160,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Container(
                              // margin: const EdgeInsets.only(top: 30),
                              height: 160,
                              width: 160,
                              decoration: BoxDecoration(
                                  color: Colors.lightBlueAccent,
                                  borderRadius: BorderRadius.circular(100)),

                              //show user profile Pictue if he was sign in with hlep og Google
                              child: CircleAvatar(
                                radius: 55,
                                child: ClipRRect(
                                  child: Image.asset(
                                      'assets/icons/DefaultAccountPhoto.png'),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                              ),
                            ),
                    ),
                  ),
                ),
              ],

              const SizedBox(height: 10),

              //show Username
              if (LoginType == 'true') ...[
                //when user login with facebook or google
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "${sp.name}",
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Gotham',
                    ),
                  ),
                ),
              ] else
                ...[],

              const SizedBox(height: 10),

              //for log out box
              SizedBox(
                height: 50,
                width: 150,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: HexColor("#48EDC5"),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ),

                  child: Row(
                    children: [
                      //for text
                      Container(
                        margin: const EdgeInsets.only(left: 13),
                        child: Text(
                          "log Out",
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
                    sp.userSignOut();
                    nextScreenReplace(
                        context, FirstPage(TempCheckUserLogin: 'false'));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
