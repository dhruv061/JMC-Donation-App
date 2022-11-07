import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../Pages/PaymentPage.dart';
import '../Utils/NextScreen.dart';

// ignore: camel_case_types
class NightAboutUs extends StatefulWidget {
  const NightAboutUs({Key? key}) : super(key: key);

  @override
  State<NightAboutUs> createState() => _NightAboutUsState();
}

// ignore: camel_case_types
class _NightAboutUsState extends State<NightAboutUs> {
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

        title: const Center(
          child: Text(
            'Info          ',
            style: TextStyle(color: Colors.black, fontFamily: 'Gotham'),
          ),
        ),
        elevation: 0,
      ),

      //body part
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Heading
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: const Text(
                "Help For Night Shelters",
                style: TextStyle(
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
                          image:
                              AssetImage("assets/AboutUsDonation/Night/1.jpeg"),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                            image: AssetImage(
                                "assets/AboutUsDonation/Night/2.jpeg"),
                            fit: BoxFit.cover)),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                            image: AssetImage(
                                "assets/AboutUsDonation/Night/3.jpeg"),
                            fit: BoxFit.cover)),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                          image:
                              AssetImage("assets/AboutUsDonation/Night/4.jpeg"),
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
                count: 4,
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
                  child: const Text(
                    "Homelessness is really hard to overcome without help from someone else. Even with a job, some people struggle to find a shelter to regain their sense of peace. Their are so many causes of homelessness that are common in many people's lives. Being unemployed for an extended period of time is one of the most dominant causes for homelessness. As we all experienced during the covid pandemic three missed paychecks can lead to anyone with good job to be subject to losing their home.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontFamily: "Gotham",
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 0),
                  padding: const EdgeInsets.only(left: 21, right: 21),
                  child: const Text(
                    "We also learned from the recent pandemic that we do not have to be the cause of us losing our jobs. Your job can close down without advanced notice and now you have to find work. Seasoned in your craft you have to start over accepting lower pay or being passed over as being over qualified. With that being said, we must admit that as we age find a job becomes more and more difficult. Anyone who has looked for a job has spent months looking for a job with no success. Throughout this time we are expected to still maintain proper hygiene even if we do not have access to clean water.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
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
                    child: const Text(
                      "Contribute",
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
          ],
        ),
      ),
    );
  }
}
