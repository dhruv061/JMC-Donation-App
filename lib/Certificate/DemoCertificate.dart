// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:screenshot/screenshot.dart';

import 'package:jmc/Certificate/PdfPreview.dart';
import 'package:jmc/Classes/UserData.dart';
import 'package:jmc/Utils/NextScreen.dart';
import 'package:share_plus/share_plus.dart';

import 'CertificateField.dart';

class DemoCertificate extends StatefulWidget {
  //for get user data
  final String certificateId;
  final String donerName;
  final String DateTime;
  final num amount;

  const DemoCertificate({
    Key? key,
    required this.certificateId,
    required this.donerName,
    required this.DateTime,
    required this.amount,
  }) : super(key: key);

  @override
  State<DemoCertificate> createState() => _DemoCertificateState();
}

class _DemoCertificateState extends State<DemoCertificate> {
  //to genrate Screenshot Controller
  ScreenshotController screenshotController = ScreenshotController();

  //fore share screenshot image
  Future saveAndShare(Uint8List bytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final image = File('${directory.path}/certificate.png');
    image.writeAsBytes(bytes);

    await Share.shareFiles([image.path]);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Screenshot(
      controller: screenshotController,
      child: Scaffold(
        body: Container(
          height: height,
          width: width,
          // color: Colors.green,

          //for Certificate
          child: Column(
            children: [
              //For Image

              Container(
                // color: Colors.yellow,
                height: 120,
                width: width,
                child: Image.asset("assets/icons/Logo.png"),
              ),

              SizedBox(height: 10),

              //for Certificate Id
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text(
                    "Certificate id: " + widget.certificateId,
                    style: TextStyle(
                        fontFamily: "Aclonica",
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              SizedBox(height: 35),

              //for Heading
              Center(
                child: Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text(
                    "Certificate of Donation ",
                    style: TextStyle(
                        fontFamily: "GreatVibes",
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              SizedBox(height: 25),

              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    "This certificate is hereby awarded to: ",
                    style: TextStyle(
                        fontFamily: "Aclonica",
                        fontSize: 13.5,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),

              SizedBox(height: 25),

              //Doner Name
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    widget.donerName,
                    style: TextStyle(
                        fontFamily: "Aclonica",
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: HexColor("#22E183")),
                  ),
                ),
              ),
              Divider(
                color: Colors.black,
                thickness: 0.7,
                indent: 17,
                endIndent: 17,
              ),

              //for Summery
              Padding(
                padding: EdgeInsets.only(left: 15, top: 15),
                child: Text(
                  "For their generous donation of ${widget.amount} to Jamnagar JMC at ${widget.DateTime}.\n \nThis donation will support our mission to provide food for the needy, help for night shelters, feed for cows, skill development for women, orphan adoptions, and support for cancer patients. We are deeply grateful for your support and the positive impact it will have on our community.",
                  style: TextStyle(
                      fontFamily: "Aclonica",
                      fontSize: 13.5,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.3),
                ),
              ),

              //last part --> sign and seal
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 15, top: 25),
                    child: Text("Sincerely,\n[Authority name]\n[Jamnagar JMC]"),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: width / 2.9, top: 15),
                    child: Text("Official Seal or \nSignature:"),
                  )
                ],
              ),

              //for back and back screen option
              Row(
                children: [
                  //for back button
                  Padding(
                    padding: EdgeInsets.only(left: 15, top: 30),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back),
                      iconSize: 30,
                    ),
                  ),

                  //for share button
                  Padding(
                    padding: EdgeInsets.only(left: 210, top: 30),
                    child: IconButton(
                      onPressed: () async {
                        //capture screen shot
                        final image = await screenshotController.capture();

                        //share screnshot
                        saveAndShare(image!);
                      },
                      icon: Icon(Icons.share),
                      iconSize: 30,
                    ),
                  ),

                  //for back Screen Button
                ],
              ),

              // TextButton(
              //     onPressed: () async {
              //       //capture screen shot
              //       final image = await screenshotController.capture();

              //       //share screnshot
              //       saveAndShare(image!);

              //       //  nextScreen(context, PdfPreviewPage(screenshot: image));
              //     },
              //     child: Text("SS"))
            ],
          ),
        ),
      ),
    );
  }
}
