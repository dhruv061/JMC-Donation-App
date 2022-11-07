import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:jmc/Pages/FirstPage.dart';
import 'package:jmc/Utils/NextScreen.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

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

  //payment succeds
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    //show pop-Up Message
    showPopUp(context) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Payment Successfully Completed '),
          content: const Text('Thank you for Donating'),
          actions: [
            TextButton(
              onPressed: () =>
                  nextScreen(context, FirstPage(TempCheckUserLogin: 'false')),
              child: const Text('Home'),
            ),
          ],
        ),
      );
    }
  }

  //payment Fail
  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
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
                onPressed: lunchRazorPay,
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
