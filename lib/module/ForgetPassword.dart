import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ForgetPassword_Page extends StatefulWidget {
  @override
  State<ForgetPassword_Page> createState() => _ForgetPassword_PageState();
}

class _ForgetPassword_PageState extends State<ForgetPassword_Page> {
  final ForgetemailController = TextEditingController();

  //for Loading Indicator
  bool isLodaing = false;

  //for Validation
  final _key = GlobalKey<FormState>();

  @override
  void dispose() {
    ForgetemailController.dispose();

    super.dispose();
  }

  //for Forget Password method
  forgetPassword() async {
    try {
      //call forget password method from Firebase
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: ForgetemailController.text)
          .then((value) => Navigator.of(context).pop());

      //show succuful rest email send
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Color.fromARGB(255, 70, 213, 92),
          content: Text(
            "Reset Password Email Sent Succfully",
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                fontFamily: 'Gotham'),
          ),
        ),
      );
    } on FirebaseAuthException catch (e) {
      //for no user Found
      if (e.code == 'user-not-found') {
        //for stoping the loading indicator when user get this error
        Future.delayed(
          Duration(seconds: 0),
          () {
            setState(() {
              isLodaing = false;
            });
          },
        );

        //show Snack Bar when this error occur
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "No User Found for this e-mail",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Gotham'),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#D3FADE"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                //for Heading and SubHeading
                Column(
                  children: [
                    //for heading
                    Container(
                      margin: const EdgeInsets.only(top: 150, left: 20),
                      height: 70,
                      width: 400,
                      // color: Colors.yellow,
                      alignment: const FractionalOffset(0.1, 0.6),
                      child: const Text(
                        "Don't worry we are here for you",
                        style: TextStyle(
                            fontFamily: 'Gotham',
                            fontWeight: FontWeight.bold,
                            fontSize: 36),
                      ),
                    ),

                    const SizedBox(
                      height: 5,
                    ),

                    //for subHeading
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      // color: Colors.yellow,
                      height: 50,
                      width: 310,
                      child: const Text(
                        "Just enter your email and rest your passwors",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: 'Gotham',
                            // fontWeight: FontWeight.normal,
                            fontSize: 18),
                      ),
                    )
                  ],
                ),

                const SizedBox(
                  height: 50,
                ),

                Form(
                  key: _key,
                  //for E-mail Text Filed
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,

                      //for autofil e-mail
                      autofillHints: [AutofillHints.email],
                      controller: ForgetemailController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(
                          Icons.email,
                          color: HexColor("#002C00"),
                        ),
                        hintText: "e-mail",
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
                      validator: (value) =>
                          value != null && !EmailValidator.validate(value)
                              ? 'Enter valid e-mail'
                              : null,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                //for Reset Button
                SizedBox(
                  height: 50,
                  width: 170,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: HexColor("#22E183"),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),

                    //for loading indicator and Text
                    icon: isLodaing
                        ? const SizedBox()
                        : const Icon(Icons.restore, size: 24),

                    label: isLodaing
                        ? Row(
                            children: [
                              //for circular indicator
                              Container(
                                margin: const EdgeInsets.only(left: 7),
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
                                margin: const EdgeInsets.only(left: 7),
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
                            'Reset',
                            style:
                                TextStyle(fontFamily: 'Gotham', fontSize: 22),
                          ),

                    //here we call method name signup for storing data in firebase
                    onPressed: () async {
                      //for validation
                      if (_key.currentState!.validate()) {
                        isLodaing = true;

                        forgetPassword();

                        //for Showing Loaing Indicator
                        Future.delayed(
                          Duration(seconds: 3),
                          () {
                            setState(() {
                              isLodaing = true;
                            });
                          },
                        );
                      }

                      //after run above line of code this Stop the Loading Indicator
                      Future.delayed(
                        Duration(seconds: 3),
                        () {
                          setState(() {
                            isLodaing = false;
                          });
                        },
                      );
                    },
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
