// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
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
            'About',
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
                  "ABOUT US",
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
                "           Jamnagar is a coastal town of Gujarat in India.Jamnagar is having the only Ayurvedic University in India.Jamnagar is the hometown of world famous cricketers His Royal Highness Jam Ranjitsinhji, Duleepsinhji and Ajay Jadeja. The \"Bala Hanuman Temple\" is listed in the Guinness Book of World Records for the continuous chanting of \"Ram Dhun\" since 1st August 1964.Jamnagar is also home to all the three defense forces of India.The town is also famous for its 'Brass Products', 'Bandhani' and handicrafts.",
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
                  "History of JMC",
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
                "           Jamnagar Municipal Corporation was established on 6th of October 1981.Jamnagar Municipal Corporation has an area of around 26.40 square Kms. and a population of 4,45,397 as per Census-2001.All the administrative activities of the J.M.C. is conducted as per Bombay Provincial Municipal Corporation Act 1949.",
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
                  "Mayor",
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
                "           Smt. Binaben Ashokbhai Kothari Has been appointed as Mayor in Jamnagar Municipal Corporation since 12-03-2021. She has done BA in political science. She Served as the Vice President and General Secretary of Mahila Morcha in Bharatiya Janata Party. She Elected as corporator from Bharatiya Janata Party in ward no.5 in 2015.",
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
                  "Municipal Commissioner",
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
                "           Shri. Vijaykumar Kharadi IAS is a municipal commissioner of JMC. He has done BE In computer.Previously, appointed collector in dahod and his services were placed at the disposal of urban development & urban housing department for appointment as municipal commissioner.",
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
                  "Contact us",
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
                " Address: Jamnagar Municipal  Corporation,Jubilee Garden, Jamnagar \n Phone: (0288) - 2550231 - 235 \n Toll Free: 1800 233 0131 \n Email : mcjamnagar@gmail.com",
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
