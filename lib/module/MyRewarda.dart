import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:jmc/Classes/UserData.dart';
import 'package:jmc/Classes/UserTotalPayment.dart';
import 'package:jmc/Classes/UserTotalRewards.dart';
import 'package:jmc/Certificate/DemoCertificate.dart';
import '../Certificate/CertificateField.dart';
import '../Certificate/PdfPreview.dart';
import '../Utils/NextScreen.dart';
import '../Classes/SessionController.dart';

class MyRewards extends StatefulWidget {
  const MyRewards({super.key});

  @override
  State<MyRewards> createState() => _MyRewardsState();
}

class _MyRewardsState extends State<MyRewards> {
  //for get payment detail from cloud firestore
  List<Payment_Details> _PaymentInfo = [];

  @override
  void initState() {
    super.initState();
    _getPaymentInfo();
  }

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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF22E183),

        //for back arrow option
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),

        title: const Center(
          child: Text(
            'My Rewards         ',
            style: TextStyle(color: Colors.black, fontFamily: 'Gotham'),
          ),
        ),
        elevation: 0,
      ),
      body: _PaymentInfo.length != 0
          ? ListView.builder(
              itemCount: _PaymentInfo.length,
              itemBuilder: ((context, index) {
                var payment = _PaymentInfo[index];

                return Column(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: InkWell(
                          onTap: () {
                            nextScreen(
                                context,
                                DemoCertificate(
                                  certificateId: payment.certificateId,
                                  donerName: UserData.instance.name,
                                  DateTime: payment.timeStamp.toString(),
                                  amount: payment.amount,
                                ));
                          },
                          child: Container(
                            height: height / 7,
                            width: width / 1.09,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1.2,
                                  blurRadius: 5.5,
                                  offset: Offset(
                                      0, 1), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                //for recipt image and success title
                                Center(
                                  child: Container(
                                    height: height / 7,
                                    width: width / 3.5,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          bottomLeft: Radius.circular(15)),
                                      color: Colors.green,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 1.2,
                                          blurRadius: 5.5,
                                          offset: Offset(0,
                                              1), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 12),
                                      child: Column(
                                        children: [
                                          Image.asset(
                                              'assets/icons/Certificate.png'),
                                          const SizedBox(height: 8),
                                          const Text(
                                            "Award",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontFamily: "Gotham",
                                              fontWeight: FontWeight.w600,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                //for payment Details
                                Container(
                                  // color: Colors.yellow,
                                  width: width / 1.6,
                                  child: Column(
                                    children: [
                                      //for Certificate Id
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, top: 14),
                                          child: Text(
                                            "id: " + payment.certificateId,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontFamily: "Gotham",
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),

                                      //for Donation Amount
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, top: 6),
                                          child: Text(
                                            'Donated Amount: \u{20B9}' +
                                                payment.amount.toString(),
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontFamily: "Gotham",
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ),

                                      //timeStemp
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, top: 10),
                                          child: Text(
                                            payment.timeStamp.toString(),
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontFamily: "Gotham",
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            )
          : Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Container(
                  height: height / 2,
                  width: width / 1.02,
                  // color: Colors.yellow,
                  child: Column(
                    children: [
                      //image
                      Image.asset("assets/images/Norewards.png"),

                      //text
                      const Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text(
                          'you have no reward ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: "Gotham",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

//this class use for Store Data in list --> Data comes from Firebase Firestore (cloud firestore)
class Payment_Details {
  //for payment Details
  final String paymentId;
  final num amount;
  final String status;
  final String certificateId;
  DateTime timeStamp;

  Payment_Details(
      {required this.paymentId,
      required this.amount,
      required this.status,
      required this.timeStamp,
      required this.certificateId});

  factory Payment_Details.fromFirestore(Map<String, dynamic> data) {
    return Payment_Details(
        paymentId: data["paymentId"],
        amount: num.parse(data["amount"]),
        status: data["Status"],
        timeStamp: data["timestamp"].toDate(),
        certificateId: data["CertificateId"]);
  }
}
