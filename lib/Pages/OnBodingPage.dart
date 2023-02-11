import 'package:flutter/material.dart';
import 'package:jmc/Language/language_screen.dart';
import 'package:jmc/module/ScrollingPage1.dart';
import 'package:jmc/module/ScrollingPage2.dart';
import 'package:jmc/module/ScrollingPage3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // ignore: non_constant_identifier_names, unused_element
  //const _OnboardingScreenState({Key? key}) : super(key: key);
  PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            children: [
              LanguageScreen(),
              Scrolling_Page_1(),
              Scrolling_Page_2(),
              Scrolling_Page_3(),
            ],
          ),
          //dot indicator
          Container(
            alignment: Alignment(0, -0.80),
            child: SmoothPageIndicator(
              controller: _controller,
              count: 4,
              axisDirection: Axis.horizontal,
              effect: const SlideEffect(
                  spacing: 4.0,
                  radius: 8.0,
                  dotWidth: 20.0,
                  dotHeight: 8.0,
                  paintStyle: PaintingStyle.stroke,
                  strokeWidth: 1.5,
                  dotColor: Colors.grey,
                  activeDotColor: Color.fromARGB(255, 63, 235, 115)),
            ),
          ),
        ],
      ),
    );
  }
}
