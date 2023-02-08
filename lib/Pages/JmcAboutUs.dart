// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

// ignore: camel_case_types
class JmcAboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#FFFFFF"),

      //this is appbar
      appBar: AppBar(
        backgroundColor: HexColor('#22E183'),

        //for back arrow option
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),

        title: Container(
          margin: EdgeInsets.only(left: 70, top: 5),
          child: Text(
            'About'.tr,
            style: TextStyle(
                color: Colors.black, fontFamily: 'Gotham', fontSize: 26),
          ),
        ),
        elevation: 0,
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 10),

            //about us heading
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 10),
                color: Colors.white,
                child: Text(
                  "ABOUT_US".tr,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Gotham',
                      fontSize: 20),
                ),
              ),
            ),

            SizedBox(height: 10),

            //aboust us desc
            Container(
              margin: EdgeInsets.all(5),
              color: Colors.white,
              child: Text(
                "JMC_about_us".tr,
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontFamily: 'Gotham',
                    fontWeight: FontWeight.w400,
                    fontSize: 16),
              ),
            ),

            //add line
            Divider(
              height: 30,
              thickness: 1.7,
              color: HexColor("#D3FADE"),
            ),

            //Heading
            Center(
              child: Container(
                margin: EdgeInsets.all(5),
                color: Colors.white,
                child: Text(
                  "History_of_JMC".tr,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Gotham',
                      fontSize: 20),
                ),
              ),
            ),

            SizedBox(height: 10),

            //desc
            Container(
              margin: EdgeInsets.all(5),
              color: Colors.white,
              child: Text(
                "History_of_JMC_detail".tr,
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontFamily: 'Gotham',
                    fontWeight: FontWeight.w400,
                    fontSize: 16),
              ),
            ),

            //add line
            Divider(
              height: 30,
              thickness: 1.7,
              color: HexColor("#D3FADE"),
            ),

            //heading
            Center(
              child: Container(
                margin: EdgeInsets.all(5),
                color: Colors.white,
                child: Text(
                  "Mayor".tr,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Gotham',
                      fontSize: 20),
                ),
              ),
            ),

            //mayor photo
            Container(
              margin: const EdgeInsets.only(top: 10),
              height: 120,
              width: 120,

              //show user profile Pictue if he was sign in with hlep og Google
              child: ClipRRect(
                child: Image.asset('assets/images/JMCMayor.png'),
                borderRadius: BorderRadius.circular(50.0),
              ),
            ),

            //desc
            Container(
              margin: EdgeInsets.only(top: 12),
              color: Colors.white,
              child: Text(
                "Mayor_detail".tr,
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontFamily: 'Gotham',
                    fontWeight: FontWeight.w400,
                    fontSize: 16),
              ),
            ),

            //add line
            Divider(
              height: 30,
              thickness: 1.7,
              color: HexColor("#D3FADE"),
            ),

            //heading
            Center(
              child: Container(
                margin: EdgeInsets.all(5),
                color: Colors.white,
                child: Text(
                  "Municipal_Commissioner".tr,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Gotham',
                      fontSize: 20),
                ),
              ),
            ),

            //Munciple Comminissioner photo
            Container(
              margin: const EdgeInsets.only(top: 10),
              height: 120,
              width: 120,

              //show user profile Pictue if he was sign in with hlep og Google
              child: CircleAvatar(
                radius: 30,
                child: ClipRRect(
                  child: Image.asset('assets/images/JMCCommisioner.png'),
                  borderRadius: BorderRadius.circular(50.0),
                ),
              ),
            ),

            //desc
            Container(
              margin: EdgeInsets.only(top: 12),
              color: Colors.white,
              child: Text(
                "Municipal_Commissioner_detail".tr,
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontFamily: 'Gotham',
                    fontWeight: FontWeight.w400,
                    fontSize: 16),
              ),
            ),

            //add line
            Divider(
              height: 30,
              thickness: 1.7,
              color: HexColor("#D3FADE"),
            ),

            //heading
            Center(
              child: Container(
                margin: EdgeInsets.all(5),
                color: Colors.white,
                child: Text(
                  "Contact_us".tr,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Gotham',
                      fontSize: 20),
                ),
              ),
            ),

            //desc
            Container(
              margin: EdgeInsets.all(5),
              color: Colors.white,
              child: Text(
                "Contact_us_detail".tr,
                style: TextStyle(
                    color: HexColor("#345EA8"),
                    fontFamily: 'Gotham',
                    fontWeight: FontWeight.w400,
                    fontSize: 16),
              ),
            ),

            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
