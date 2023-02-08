import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:jmc/Pages/FirstPage.dart';
import 'package:jmc/module/ForgetPassword.dart';
import 'package:provider/provider.dart';

import '../Utils/SnackBar.dart';
import '../Classes/SessionController.dart';
import '../provider/InternetProvider.dart';

class SignInPage extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  const SignInPage({
    Key? key,
    required this.onClickedSignUp,
  }) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //for Validation
  final _key = GlobalKey<FormState>();

  //for geeting input and store email & password
  var email;
  var password;

  //for Loading Indicator
  bool isLodaing = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  FirebaseAuth auth = FirebaseAuth.instance;

  //for login
  Future userLogin() async {
    //check internet is on or not
    final ip = context.read<InternetProvider>();
    await ip.checkInternetConnection();

    //for checking Internet
    if (ip.hasInternet == false) {
      openSnackbar(context, "Check your internet connection", Colors.red);
    } else {
      try {
        await auth
            .signInWithEmailAndPassword(
          email: email,
          password: password,
        )
            .then((value) {
          SessionController().userId = value.user!.uid.toString();

          print("User id assigned to session controller : " +
              SessionController().userId.toString());

          //show succuful log-in meesage
          openSnackbar(
              context, "Log-in Successfull", Color.fromARGB(255, 70, 213, 92));

          //after login go to profile Page
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      FirstPage(TempCheckUserLogin: 'false')));
        });
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
          openSnackbar(context, "No User Found for this e-mail", Colors.red);
        }

        //for Wrong Password
        else if (e.code == 'wrong-password') {
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
          openSnackbar(context, "Wrong Password", Colors.red);
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#D3FADE"),
      // theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFEFEFEF)),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            // width: double.infinity,
            // height: MediaQuery.of(context).size.height,
            // padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Column(
              children: [
                Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //for heading
                    Container(
                      margin: const EdgeInsets.only(top: 150),
                      height: 43,
                      width: 400,
                      // color: Colors.yellow,
                      alignment: const FractionalOffset(0.1, 0.6),
                      child: const Text(
                        "Sign-in",
                        style: TextStyle(
                            fontFamily: 'Gotham',
                            fontWeight: FontWeight.bold,
                            fontSize: 36),
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    //for subHeading
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      // color: Colors.yellow,
                      height: 50,
                      width: 310,
                      child: const Text(
                        "Enter Your Email and Password and Start Donating",
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

                //for TextFileds
                Form(
                  key: _key,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
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

                        const SizedBox(height: 10),

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

                        //for forget Password
                        Container(
                          margin: const EdgeInsets.only(top: 4),
                          // color: Colors.yellow,
                          height: 35,
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            onPressed: () {
                              //goto Forget Password Screen

                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ForgetPassword_Page()));
                            },
                            child: const Text(
                              "Forgot Password",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontFamily: 'Gotham',
                                  color: Color(0xff1778F2),
                                  fontSize: 14.5),
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        //for sign-in Button
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
                                : const Icon(Icons.arrow_forward, size: 24),

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
                                    'Sign-in',
                                    style: const TextStyle(
                                        fontFamily: 'Gotham', fontSize: 22),
                                  ),

                            //here we call method name signup for storing data in firebase
                            onPressed: () async {
                              //for validation
                              if (_key.currentState!.validate()) {
                                isLodaing = true;
                                setState(() {
                                  //when user enter email & password then store those email and passwors in variable which intialize in top
                                  email = emailController.text;
                                  password = passwordController.text;
                                });

                                //for Showing Loaing Indicator
                                Future.delayed(
                                  Duration(seconds: 10),
                                  () {
                                    setState(() {
                                      isLodaing = true;
                                    });
                                  },
                                );

                                //for user login
                                userLogin();
                              }

                              //after run above line of code this Stop the Loading Indicator
                              Future.delayed(
                                Duration(seconds: 10),
                                () {
                                  setState(() {
                                    isLodaing = false;
                                  });
                                },
                              );
                            },
                          ),
                        ),

                        const SizedBox(
                          height: 18,
                        ),

                        //for user have no account then display this
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'Gotham',
                                fontWeight: FontWeight.w400,
                                fontSize: 15),
                            text: 'No Account?   ',
                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = widget.onClickedSignUp,
                                text: 'Sign Up',
                                style: const TextStyle(
                                  color: Color(0xff1778F2),
                                  decoration: TextDecoration.underline,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
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
