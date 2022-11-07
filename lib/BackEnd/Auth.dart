import 'package:flutter/material.dart';
import 'package:jmc/Pages/SignInPage.dart';
import 'package:jmc/Pages/SignUpPage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

//this page hellp when user click sign up then goto signup & when user click signin then goto sign in

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) => isLogin
      ? SignInPage(onClickedSignUp: toggle)
      : SignupPage(onClickedSignIn: toggle);

  void toggle() => setState(() {
        isLogin = !isLogin;
      });
}
