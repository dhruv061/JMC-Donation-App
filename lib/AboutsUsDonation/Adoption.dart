import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../Pages/PaymentPage.dart';
import '../Utils/NextScreen.dart';

// ignore: camel_case_types
class AdoptionAboutUs extends StatefulWidget {
  const AdoptionAboutUs({Key? key}) : super(key: key);

  @override
  State<AdoptionAboutUs> createState() => _AdoptionAboutUsState();
}

// ignore: camel_case_types
class _AdoptionAboutUsState extends State<AdoptionAboutUs> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF22E183),

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

        title: Center(
          child: Text(
            'Adoption_info'.tr,
            style: TextStyle(color: Colors.black, fontFamily: 'Gotham'),
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //heading
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Text(
                "Orphan_Adoption".tr,
                style: const TextStyle(
                    fontFamily: "Gotham",
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),

            Divider(
              height: 32,
              thickness: 1.7,
              color: HexColor("#D3FADE"),
            ),

            //image Sliders
            Container(
              margin: const EdgeInsets.only(top: 0),
              child: CarouselSlider(
                items: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                          image: AssetImage(
                              "assets/AboutUsDonation/Adoption/1.jpeg"),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                          image: AssetImage(
                              "assets/AboutUsDonation/Adoption/2.jpeg"),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                          image: AssetImage(
                              "assets/AboutUsDonation/Adoption/3.jpeg"),
                          fit: BoxFit.cover),
                    ),
                  ),
                ],

                //for slider option
                options: CarouselOptions(
                  height: 180,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  viewportFraction: 0.8,

                  //for page indicator
                  onPageChanged: (index, reason) {
                    setState(
                      () {
                        activeIndex = index;
                      },
                    );
                  },
                ),
              ),
            ),

            //for animated page Indicator
            Container(
              margin: const EdgeInsets.only(top: 13),
              child: AnimatedSmoothIndicator(
                activeIndex: activeIndex,
                count: 3,
                effect: SwapEffect(
                    activeDotColor: HexColor("#22E183"),
                    dotColor: HexColor("#D3FADE"),
                    dotHeight: 14,
                    dotWidth: 14),
              ),
            ),

            //add line
            Divider(
              height: 32,
              thickness: 1.7,
              color: HexColor("#D3FADE"),
            ),

            //containt title
            Column(
              children: [
                // Container(
                //   margin: const EdgeInsets.only(top: 18),
                //   padding: const EdgeInsets.only(right: 280),
                //   child: const Text(
                //     "\t Overview",
                //     style: TextStyle(
                //       fontFamily: "Gotham",
                //       fontSize: 18,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                // ),
                Container(
                  //box 1 information
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.only(left: 21, right: 21),
                  child: Text(
                    "Adoption_info1".tr,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      fontFamily: "Gotham",
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),

                //subHeading
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(top: 10, left: 20),
                  child: const Text(
                    "Some Disturbing Facts :",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontFamily: "Gotham",
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                //Heading
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.only(left: 21, right: 21),
                  child: Text(
                    "Adoption_info2".tr,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      fontFamily: "Gotham",
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 8,
                ),

                Divider(
                  height: 32,
                  thickness: 1.7,
                  color: HexColor("#D3FADE"),
                ),

                Container(
                  //box 1 button
                  margin: const EdgeInsets.only(top: 8, left: 8, bottom: 30),
                  height: 58,
                  width: 330,
                  child: TextButton(
                    onPressed: () {
                      nextScreen(context, PaymentPage());
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(HexColor("#22E183")),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)))),

                    //for button text
                    child: Text(
                      "Contribute".tr,
                      style: const TextStyle(
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
          ],
        ),
      ),
    );
  }
}
