import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:jmc/Pages/FirstPage.dart';
import 'package:jmc/Utils/NextScreen.dart';

import 'package:jmc/module/SessionController.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;

class PaymentPage extends StatefulWidget {
  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late var _razorpay;
  var amountController = TextEditingController();

  //for Validation
  final _key = GlobalKey<FormState>();

  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  // _genrateCertificate() async {
  //   print("function started");

  //   const String apiKey = 'bb_pr_69b1821f0ed9d09b1212274ef85c4a';

  //   var data = {
  //     "template": "V4WN6JDx0lnvD3Gqjk",
  //     "modifications": [
  //       {
  //         "name": "pretitle",
  //         "text": "This Certificate of",
  //         "color": null,
  //         "background": null
  //       },
  //       {
  //         "name": "title",
  //         "text": "Donation",
  //         "color": null,
  //         "background": null
  //       },
  //       {
  //         "name": "subtitle",
  //         "text": "is proudly presented to",
  //         "color": null,
  //         "background": null
  //       },
  //       {
  //         "name": "awardee_name",
  //         "text": "Dhruv Mavani",
  //         "color": null,
  //         "background": null
  //       },
  //       {
  //         "name": "details",
  //         "text": "We are truly grateful for your support and generosity",
  //         "color": null,
  //         "background": null
  //       },
  //       {
  //         "name": "name_position1",
  //         "text": "Jamnager Munciple Corporation",
  //         "color": null,
  //         "background": null
  //       },
  //       {
  //         "name": "signature_container1",
  //         "image_url":
  //             "https://cdn.bannerbear.com/sample_images/welcome_bear_photo.jpg"
  //       },
  //       {
  //         "name": "name_position2",
  //         "text": "Prsedident",
  //         "color": null,
  //         "background": null
  //       },
  //       {
  //         "name": "signature_container2",
  //         "image_url":
  //             "https://cdn.bannerbear.com/sample_images/welcome_bear_photo.jpg"
  //       }
  //     ],
  //     "webhook_url": null,
  //     "transparent": false,
  //     "metadata": null,
  //     "transparent": true,
  //   };

  //   print('\n');

  //   final response = await http.post(
  //     Uri.parse('https://api.bannerbear.com/v2/images'),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       "Authorization": "Bearer $apiKey"
  //     },
  //     body: json.encode(data),
  //   );
  //   print('\n');
  //   print("Encode data");
  //   print(json.encode(data));

  //   print('\n');
  //   print("Response created");
  //   print("response code is : " + response.statusCode.toString());

  //   if (response.statusCode == 202) {
  //     final jsonResponse = json.decode(response.body);

  //     print('\n');
  //     print("ALL response data is here");
  //     print(jsonResponse);

  //     // final imageUrl = jsonResponse['image_url'];

  //     // print("Image url is : " + imageUrl);
  //   } else {
  //     // Handle the error
  //     // ...
  //   }
  // }

  //payment succeds
  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    //store all payment detail with user detail in new database --> Cloud Firestore Database
    var paymentRef1 = FirebaseFirestore.instance
        .collection("users")
        .doc(SessionController().userId.toString())
        .collection("payments");
    var payment1 = {
      "paymentId": response.paymentId,
      "amount": amountController.text,
      "timestamp": FieldValue.serverTimestamp(),
      "Status": "Success"
    };
    paymentRef1.add(payment1);

    //for real-time Database
    final FirebaseDatabase database = FirebaseDatabase.instance;
    var paymentRef2 = database
        .ref()
        .child("users")
        .child(SessionController().userId.toString())
        .child("payments");

    var payment2 = {
      "paymentId": response.paymentId,
      "amount": amountController.text,
      "timestamp": DateTime.now().toIso8601String(),
      "Status": "Success"
    };
    paymentRef2.push().set(payment2);

    //show pop-up box
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      title: "Payment Success",
      text: "Check History and Rewards to get certificate!",
      confirmBtnText: "Thanks!",
      confirmBtnColor: Color.fromARGB(255, 47, 196, 52),
      width: 25,
    );

    nextScreen(context, FirstPage(TempCheckUserLogin: 'false'));
  }

  //payment Fail
  void _handlePaymentError(PaymentFailureResponse response) {
    print("Payment Fail");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  void lunchRazorPay() {
    int amountToPay = int.parse(amountController.text) * 100;

    ///Make payment
    var options = {
      'key': "rzp_test_qxUSQdChEGjDpj",
      'amount': "$amountToPay",
      'name': 'JMC',
      'description': 'Donate',
      'timeout': 300, // in seconds
      'prefill': {'contact': '7383791771', 'email': 'mavanidhruv32@gmail.com'}
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      //Heading Part
      appBar: AppBar(
        backgroundColor: Color(0xFF22E183),

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

        title: const Center(
          child: Text(
            'Donating           ',
            style: TextStyle(color: Colors.black, fontFamily: 'Gotham'),
          ),
        ),
        elevation: 0,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            //for sub heading
            Container(
              margin: const EdgeInsets.only(top: 50),
              // color: Colors.yellow,
              height: 50,
              width: 310,
              child: const Text(
                "You're just one step away from donation",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontFamily: 'Gotham',
                    // fontWeight: FontWeight.normal,
                    fontSize: 18),
              ),
            ),

            //for image
            Container(
              margin: const EdgeInsets.only(top: 75),
              height: 202,
              width: 303,
              decoration: BoxDecoration(
                  image: const DecorationImage(
                      image: AssetImage("assets/images/payment.jpeg"),
                      fit: BoxFit.fill),
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(20)),
            ),

            //for another title
            Container(
              margin: const EdgeInsets.only(left: 50, top: 20),
              alignment: Alignment.centerLeft,
              child: const Text(
                "How much?",
                style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 0.4,
                    fontFamily: "Gotham",
                    fontSize: 19,
                    fontWeight: FontWeight.bold),
              ),
            ),

            //text Field
            Container(
              margin: const EdgeInsets.only(top: 20, left: 45, right: 45),
              child: Form(
                key: _key,
                child: TextFormField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  //for autofil payment
                  autofillHints: [AutofillHints.email],
                  // controller: Payment box,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(
                      Icons.currency_rupee,
                      color: HexColor("#002C00"),
                    ),
                    hintText: "Amount",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(33)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: HexColor("#002C00")),
                      borderRadius: BorderRadius.circular(25.7),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(25.7),
                    ),
                  ),

                  //for validation
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter amount";
                    }
                    return null;
                  },
                ),
              ),
            ),

            //donate Button
            Container(
              // box 3 button
              margin: const EdgeInsets.only(top: 60, left: 0),
              height: 55,
              width: 300,
              child: TextButton(
                onPressed: () {
                  if (_key.currentState!.validate()) {
                    lunchRazorPay();
                  }
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(HexColor("#22E183")),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)))),

                //for button text
                child: const Text(
                  "Donate",
                  style: TextStyle(
                      color: Colors.black,
                      letterSpacing: 0.4,
                      fontFamily: "Gotham",
                      fontSize: 19,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),

            // TextButton(
            //   onPressed: () {
            //     // _createCertificate();
            //     _genrateCertificate();
            //   },
            //   child: Text('Certificate'),
            // ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }
}
