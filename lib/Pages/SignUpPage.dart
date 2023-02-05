import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:jmc/BackEnd/Auth.dart';

import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import 'package:firebase_database/firebase_database.dart';

import '../Utils/NextScreen.dart';
import '../Utils/SnackBar.dart';
import '../module/ProfilePage_AfterLogin.dart';
import '../Classes/SessionController.dart';
import '../provider/InternetProvider.dart';
import '../provider/SignInProvider.dart';
import 'FirstPage.dart';

class SignupPage extends StatefulWidget {
  //this for move Sigup page to Signin page
  final Function() onClickedSignIn;

  const SignupPage({
    Key? key,
    required this.onClickedSignIn,
  }) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  //for check validation
  final formKey = GlobalKey<FormState>();
  final formKeyOtp = GlobalKey<FormState>();

  //for store data in real databse
  late DatabaseReference dbRef;

  @override
  void initState() {
    //for store data in real database
    dbRef = FirebaseDatabase.instance.ref().child('Users');
    super.initState();
  }

  //for storing user data  -> when user click signup button that time user data store in variable and after using this variable we can store data in firebase
  var name = "";
  var email = "";
  var phoneno = "";
  var password = "";
  var confirmPassword = "";
  var adhharCard = "";

  //for Loading Indicator
  bool isLodaing = false;

  //user click send otp button then show OTP fillup Boxes
  bool viewVisible = false;

  // //for check user signin with google or facebok
  // bool signinWithGoogleandFb = false;

  //for Contry code
  String countryCode = "+91";
  static String verifiy = " ";
  var userInputOtp = " ";

  //for OTP timer
  int start = 30;
  //for 30 sec disable send Button
  bool wait = false;
  String buttonName = "Send";

  //for save data in fireBase
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneNOController = TextEditingController();
  final nameController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final adhharCardController = TextEditingController();

  //for RoundedLoadingButton Controller
  final RoundedLoadingButtonController googleController =
      RoundedLoadingButtonController();
  final RoundedLoadingButtonController facebookController =
      RoundedLoadingButtonController();

  @override
  void dispose() {
    emailController.dispose();
    adhharCardController.dispose();

    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneNOController.dispose();
    nameController.dispose();

    super.dispose();
  }

  //for OTP Timer
  void startTimer() {
    const onsec = Duration(seconds: 1);
    Timer timer = Timer.periodic(
      onsec,
      (timer) {
        if (start == 0) {
          setState(() {
            timer.cancel();
            wait = false;
          });
        } else {
          setState(() {
            start--;
          });
        }
      },
    );
  }

  //for storing Data in firebase
  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('users');

  //signup method
  Future signUp() async {
    final ip = context.read<InternetProvider>();
    await ip.checkInternetConnection();

    //for checking Internet
    if (ip.hasInternet == false) {
      openSnackbar(context, "Check your internet connection", Colors.red);
    } else {
      //for authenticate User's
      if (password == confirmPassword) {
        try {
          await auth
              .createUserWithEmailAndPassword(email: email, password: password)
              .then((value) {
            //store user id in session controller
            SessionController().userId = value.user!.uid.toString();

            //store data in real time db
            ref
                .child(value.user!.uid.toString())
                .set({
                  'uid': value.user!.uid.toString(),
                  'image_url': '',
                  'Name': nameController.text,
                  'Email': emailController.text,
                  'AdhharCard No': adhharCardController.text,
                  'Phone No ': phoneNOController.text,
                  'Password': passwordController.text,
                })
                .then((value) {})
                .onError((erroe, snapTrace) {
                  openSnackbar(context, erroe.toString(), Colors.red);
                });

            //for storing data all information are true and password and Confirm Password match
            //call function which make below
            addUserDetails(
              value.user!.uid.toString(),
              nameController.text.trim(),
              emailController.text.trim(),
              adhharCardController.text.trim(),
              phoneNOController.text.trim(),
              passwordController.text.trim(),
            );

            //show succuful signup meesage
            openSnackbar(context, "Registered complete Successfull",
                const Color.fromARGB(255, 70, 213, 92));

            //after signup redirct user to signin page
            nextScreen(context, AuthPage());
          }).onError((error, stackTrace) {
            openSnackbar(context, error.toString(), Colors.red);
          });
        } on FirebaseAuthException catch (e) {
          //for weak password
          if (e.code == 'weak-password') {
            //for stoping the loading indicator when user get this error
            Future.delayed(
              Duration(seconds: 0),
              () {
                setState(() {
                  isLodaing = false;
                });
              },
            );

            //for show error to user
            openSnackbar(
                context, "Weak password", Color.fromARGB(255, 232, 238, 69));
          }

          //if account alredy created
          else if (e.code == 'email-already-in-use') {
            //for stoping the loading indicator when user get this error
            Future.delayed(
              Duration(seconds: 0),
              () {
                setState(() {
                  isLodaing = false;
                });
              },
            );

            //for show the error to user
            openSnackbar(context, "Account Already exists", Colors.red);
          }
        }
      }

      //if password not metch
      else {
        //for stoping the loading indicator when user get this error
        Future.delayed(
          Duration(seconds: 0),
          () {
            setState(() {
              isLodaing = false;
            });
          },
        );

        //for show error to user
        openSnackbar(context, "Password does'nt match", Colors.red);
      }
    }
  }

  //for storing user data into cloud Firestore
  Future addUserDetails(String id, String name, var email, var addharCard,
      var phoneNo, var password) async {
    await FirebaseFirestore.instance.collection('users').add({
      'uid': id,
      'name': name,
      'E-mail': email,
      'AdhharCard No': addharCard,
      'Phone Number': phoneNo,
      'Password': password,
      'provider': 'Email',
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: HexColor("#D3FADE"),
      // theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFEFEFEF)),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Column(
              children: [
                //here we wrap eith Form beacuse we use validation of email, password
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    //for heading
                    Container(
                      margin: const EdgeInsets.only(top: 60),
                      height: 40,
                      width: 500,
                      // color: Colors.yellow,
                      alignment: const FractionalOffset(0.0002, 0.6),
                      child: const Text(
                        "Sign-up",
                        style: TextStyle(
                            fontFamily: 'Gotham',
                            fontWeight: FontWeight.bold,
                            fontSize: 36),
                      ),
                    ),

                    const SizedBox(
                      height: 0,
                    ),

                    //for SubHeading
                    Container(
                      margin: const EdgeInsets.only(right: 50),
                      height: 40,
                      width: 800,
                      // color: Colors.yellow,
                      alignment: const FractionalOffset(0.1, 0.6),
                      child: const Text(
                        "Let's Start a new journey",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: 'Gotham',
                          fontSize: 18,
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),

                //for TextFileds
                Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: Column(
                      children: [
                        //for Name Text Filed
                        TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Icon(
                              Icons.person,
                              color: HexColor("#002C00"),
                            ),
                            hintText: "Name",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(33)),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: HexColor("#002C00")),
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
                              return "Please enter name";
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 10),

                        //for E-mail Text Filed
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          //for autofil e-mail
                          autofillHints: [AutofillHints.email],
                          controller: emailController,
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
                              borderSide:
                                  BorderSide(color: HexColor("#002C00")),
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

                        SizedBox(height: 10),

                        //for Aadhaar CardText Filed
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: adhharCardController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Icon(
                              Icons.perm_identity_sharp,
                              color: HexColor("#002C00"),
                            ),
                            hintText: "Aadhaar Card",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(33)),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: HexColor("#002C00")),
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
                              return "Please enter Aadhaar Card number";
                            } else if (value.length != 12) {
                              return "Please enter Aadhaar Card number";
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 10),

                        //this form only for OTP verification of phone and getting Otp
                        Form(
                          key: formKeyOtp,
                          child: Column(
                            children: [
                              //for phone number Text Filed and send -- resend Button
                              TextFormField(
                                keyboardType: TextInputType.number,
                                controller: phoneNOController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  prefixIcon: Icon(
                                    Icons.phone,
                                    color: HexColor("#002C00"),
                                  ),
                                  hintText: "phone number",
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
                                    return "Please enter phone no";
                                  } else if (value.length != 10) {
                                    return "Please enter valid phone number";
                                  }
                                  return null;
                                },
                              ),

                              //for Sending Button
                              Container(
                                margin: EdgeInsets.only(top: 5, left: 190),
                                height: 30,
                                width: 100,
                                // color: Colors.yellow,
                                child: TextButton(
                                    onPressed: wait
                                        ? null
                                        : () async {
                                            //check validity of phone number enterd by user
                                            if (formKeyOtp.currentState!
                                                .validate()) {
                                              //for showing 30 secound
                                              startTimer();
                                              //if phone number is wrote then show Otp Fillup boxes
                                              setState(() {
                                                //for after send option on resend option
                                                start = 30;
                                                wait = true;
                                                buttonName = "Resend";
                                                //for on visibilty
                                                viewVisible = true;
                                                phoneno =
                                                    phoneNOController.text;
                                              });

                                              //for sending OTP
                                              await FirebaseAuth.instance
                                                  .verifyPhoneNumber(
                                                phoneNumber:
                                                    '${countryCode + phoneno}',
                                                verificationCompleted:
                                                    (PhoneAuthCredential
                                                        credential) {},
                                                verificationFailed:
                                                    (FirebaseAuthException
                                                        e) {},
                                                codeSent:
                                                    (String verificationId,
                                                        int? resendToken) {
                                                  verifiy = verificationId;
                                                },
                                                codeAutoRetrievalTimeout:
                                                    (String verificationId) {},
                                              );
                                            }
                                          },
                                    child: Text(
                                      buttonName,
                                      style: TextStyle(
                                          color: wait
                                              ? Colors.grey
                                              : Colors.blueAccent,
                                          fontFamily: 'Gotham',
                                          fontSize: 15),
                                    )),
                              ),

                              const SizedBox(height: 6),

                              //for Otp Boxes
                              Visibility(
                                visible: viewVisible,
                                child: Container(
                                  width: 250,
                                  child: Pinput(
                                    length: 6,
                                    onChanged: (value) {
                                      userInputOtp = value;
                                    },
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    defaultPinTheme: PinTheme(
                                      height: 45,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: HexColor("#002C00")),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 14),

                              //show Otp Timer
                              Visibility(
                                visible: viewVisible,
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                          text: "Resend OTP in ",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Gotham',
                                              color: HexColor("#002C00"))),
                                      TextSpan(
                                        text: "00:$start",
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'Gotham',
                                            color: Colors.red),
                                      ),
                                      TextSpan(
                                        text: " sec",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'Gotham',
                                          color: HexColor("#002C00"),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              const SizedBox(height: 14),

                              //submit Otp
                              Visibility(
                                visible: viewVisible,
                                child: Container(
                                  margin: EdgeInsets.only(top: 0, left: 190),
                                  height: 33,
                                  width: 100,
                                  // color: Colors.yellow,
                                  child: TextButton(
                                      onPressed: () async {
                                        //for verifiy
                                        try {
                                          // Create a PhoneAuthCredential with the code
                                          PhoneAuthCredential credential =
                                              PhoneAuthProvider.credential(
                                                  verificationId: verifiy,
                                                  smsCode: userInputOtp);

                                          // Sign the user in (or link) with the credential
                                          await FirebaseAuth.instance
                                              .signInWithCredential(credential);

                                          //if OTP  verifiy then close otp boxes
                                          setState(() {
                                            viewVisible = false;
                                          });

                                          //show Snack Bar when otp verify
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              backgroundColor: Color.fromARGB(
                                                  255, 70, 213, 92),
                                              content: Text(
                                                "Phone Verfiyed",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: 'Gotham'),
                                              ),
                                            ),
                                          );
                                        } catch (e) {
                                          //show Snack Bar when this error occur
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              backgroundColor: Colors.red,
                                              content: Text(
                                                "Please check your OTP",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: 'Gotham'),
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                      child: const Text(
                                        "verifiy",
                                        style: TextStyle(
                                            fontFamily: 'Gotham', fontSize: 17),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),

                        //for Password Text Filed
                        TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Icon(
                              Icons.password,
                              color: HexColor("#002C00"),
                            ),
                            hintText: "password",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(33)),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: HexColor("#002C00")),
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
                              return "Please enter password";
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 10),

                        //for Confirm Password Text Filed
                        TextFormField(
                          controller: confirmPasswordController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Icon(
                              Icons.check,
                              color: HexColor("#002C00"),
                            ),
                            hintText: "Confirm password",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(33)),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: HexColor("#002C00")),
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
                              return "Please confirm your password";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                //for signup Option
                //sign up butten
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
                        : Icon(Icons.lock_open, size: 22),

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
                            'Sign Up',
                            style:
                                TextStyle(fontFamily: 'Gotham', fontSize: 20),
                          ),

                    //here we call method name signup for storing data in firebase
                    onPressed: () {
                      //for validation
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          isLodaing = true;
                          name = nameController.text;
                          email = emailController.text;
                          adhharCard = adhharCardController.text;
                          phoneno = phoneNOController.text;
                          password = passwordController.text;
                          confirmPassword = confirmPasswordController.text;
                          // print("adhhar card : " + adhharCard);
                        });

                        //for Showing Loaing Indicator
                        Future.delayed(
                          Duration(seconds: 3),
                          () {
                            setState(() {
                              isLodaing = true;
                            });
                          },
                        );

                        signUp();
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

                SizedBox(height: 17),

                //for user have alrady  account then display this
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Gotham',
                        fontWeight: FontWeight.w400,
                        fontSize: 15),
                    text: 'Already have an account?   ',
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = widget.onClickedSignIn,
                        text: 'Log In',
                        style: const TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      )
                    ],
                  ),
                ),

                SizedBox(height: 10),

                //or continue with
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: const [
                      Expanded(
                        child: Divider(
                          color: Colors.black,
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Or Continue With',
                          style: TextStyle(
                            fontFamily: 'Gotham',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.black,
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),

                //Sign up with fb
                RoundedLoadingButton(
                  onPressed: () {
                    handleFacebookAuth();

                    // //set true beacuse we konw user sign in with fb
                    // //using this info we set profil photo on profile page
                    // setState(() {
                    //   signinWithGoogleandFb = true;
                    // });
                  },
                  controller: facebookController,
                  successColor: HexColor("#22E183"),
                  loaderSize: 25,
                  loaderStrokeWidth: 2.5,
                  width: MediaQuery.of(context).size.width * 0.80,
                  elevation: 0,
                  borderRadius: 25,
                  color: Color(0xFF1778F2),
                  valueColor: Colors.white,
                  child: Wrap(
                    children: const [
                      Image(
                        image: AssetImage("assets/icons/Fb.png"),
                        height: 24,
                        width: 30,
                      ),
                      SizedBox(width: 10),
                      Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Text(
                          'Continue with Facebook',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Gotham',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 14,
                ),

                //signup with google
                RoundedLoadingButton(
                  onPressed: () {
                    handleGoogleSignIn();
                    // //set true beacuse we konw user sign in with Google
                    // //using this info we set profil photo on profile page
                    // setState(() {
                    //   signinWithGoogleandFb = true;
                    // });
                  },
                  controller: googleController,
                  successColor: HexColor("#22E183"),
                  loaderSize: 25,
                  loaderStrokeWidth: 2.5,
                  width: MediaQuery.of(context).size.width * 0.80,
                  elevation: 0,
                  borderRadius: 25,
                  color: Colors.white,
                  valueColor: HexColor("#002C00"),
                  child: Wrap(
                    children: const [
                      Image(
                        image: AssetImage("assets/icons/Google.jpeg"),
                        height: 24,
                        width: 35,
                      ),
                      SizedBox(width: 10),
                      Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Text(
                          'Continue with Google',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Gotham',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 40),
                // const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // handling google sigin in
  Future handleGoogleSignIn() async {
    final sp = context.read<SignInProvider>();
    final ip = context.read<InternetProvider>();
    await ip.checkInternetConnection();

    if (ip.hasInternet == false) {
      openSnackbar(context, "Check your Internet connection", Colors.red);
      googleController.reset();
    } else {
      await sp.signInWithGoogle().then((value) {
        if (sp.hasError == true) {
          openSnackbar(context, sp.errorCode.toString(), Colors.red);
          googleController.reset();
        } else {
          // checking whether user exists or not
          sp.checkUserExists().then((value) async {
            if (value == true) {
              // user exists
              await sp.getUserDataFromFirestore(sp.uid).then((value) => sp
                  .saveDataToSharedPreferences()
                  .then((value) => sp.setSignIn().then((value) {
                        googleController.success();
                        handleAfterSignIn();
                      })));
            } else {
              // user does not exist
              sp.saveDataToFirestore().then((value) => sp
                  .saveDataToSharedPreferences()
                  .then((value) => sp.setSignIn().then((value) {
                        googleController.success();
                        handleAfterSignIn();
                      })));
            }
          });
        }
      });
    }
  }

  // handling facebookauth
  // handling google sigin in
  Future handleFacebookAuth() async {
    final sp = context.read<SignInProvider>();
    final ip = context.read<InternetProvider>();
    await ip.checkInternetConnection();

    if (ip.hasInternet == false) {
      openSnackbar(context, "Check your Internet connection", Colors.red);
      facebookController.reset();
    } else {
      await sp.signInWithFacebook().then((value) {
        if (sp.hasError == true) {
          openSnackbar(context, sp.errorCode.toString(), Colors.red);
          facebookController.reset();
        } else {
          // checking whether user exists or not
          sp.checkUserExists().then((value) async {
            if (value == true) {
              // user exists
              await sp.getUserDataFromFirestore(sp.uid).then((value) => sp
                  .saveDataToSharedPreferences()
                  .then((value) => sp.setSignIn().then((value) {
                        facebookController.success();
                        handleAfterSignIn();
                      })));
            } else {
              // user does not exist
              sp.saveDataToFirestore().then((value) => sp
                  .saveDataToSharedPreferences()
                  .then((value) => sp.setSignIn().then((value) {
                        facebookController.success();
                        handleAfterSignIn();
                      })));
            }
          });
        }
      });
    }
  }

  // handle after signin
  handleAfterSignIn() {
    Future.delayed(const Duration(milliseconds: 1000)).then((value) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FirstPage(TempCheckUserLogin: 'true')));
    });
  }
}
