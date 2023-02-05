import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../Classes/SessionController.dart';
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';

class Tab2_HistoryTab extends StatefulWidget {
  @override
  State<Tab2_HistoryTab> createState() => _Tab2_HistoryTabState();
}

class _Tab2_HistoryTabState extends State<Tab2_HistoryTab> {
  List<Payment> _payments = [];

  @override
  void initState() {
    super.initState();
    _getPayments();
  }

  //for getting payment data from db --> Data comes from Firebase Firestore (cloud firestore)
  void _getPayments() async {
    var paymentRef = FirebaseFirestore.instance
        .collection("users")
        .doc(SessionController().userId.toString())
        .collection("payments");
    var query = paymentRef.orderBy("timestamp", descending: true);
    var querySnapshot = await query.get();

    setState(() {
      _payments = querySnapshot.docs
          .map((doc) => Payment.fromFirestore(doc.data()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: _payments.length != 0
          ? ListView.builder(
              itemCount: _payments.length,
              itemBuilder: ((context, index) {
                var payment = _payments[index];
                return Column(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15),
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
                                offset:
                                    Offset(0, 1), // changes position of shadow
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
                                        offset: Offset(
                                            0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 12),
                                    child: Column(
                                      children: const [
                                        Icon(
                                          Icons.receipt_long,
                                          color: Colors.white,
                                          size: 55,
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          "Success",
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
                                    //for amount
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 14),
                                        child: Text(
                                          '\u{20B9}' + payment.amount,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 28,
                                            fontFamily: "Gotham",
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),

                                    //for payment id
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 10),
                                        child: Text(
                                          'id: ' + payment.paymentId,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontFamily: "Gotham",
                                            fontWeight: FontWeight.w500,
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
                                            fontWeight: FontWeight.w500,
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
                  ],
                );
              }),
            )
          : Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Container(
                height: height / 2,
                width: width / 1.02,
                // color: Colors.yellow,
                child: Column(
                  children: [
                    //image
                    Image.asset("assets/images/nopayments.png"),

                    //text
                    const Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        'No Donation Found',
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
    );
  }
}

//this class use for Store Data in list --> Data comes from Firebase Firestore (cloud firestore)
class Payment {
  final String paymentId;
  final String amount;
  final String status;
  DateTime timeStamp;

  Payment(
      {required this.paymentId,
      required this.amount,
      required this.status,
      required this.timeStamp});

  factory Payment.fromFirestore(Map<String, dynamic> data) {
    return Payment(
      paymentId: data["paymentId"],
      amount: data["amount"],
      status: data["Status"],
      timeStamp: data["timestamp"].toDate(),
    );
  }
}
