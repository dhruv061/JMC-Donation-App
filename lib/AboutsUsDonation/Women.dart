import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../Pages/PaymentPage.dart';
import '../Utils/NextScreen.dart';

// ignore: camel_case_types
class WomanAboutUs extends StatefulWidget {
  const WomanAboutUs({Key? key}) : super(key: key);

  @override
  State<WomanAboutUs> createState() => _WomanAboutUsState();
}

// ignore: camel_case_types
class _WomanAboutUsState extends State<WomanAboutUs> {
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
            //for Heading
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: const Text(
                "Skill development for WomanAboutUs",
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
                              AssetImage("assets/AboutUsDonation/woman/1.jpeg"),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                            image: AssetImage(
                                "assets/AboutUsDonation/woman/2.jpeg"),
                            fit: BoxFit.cover)),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                            image: AssetImage(
                                "assets/AboutUsDonation/woman/3.jpeg"),
                            fit: BoxFit.cover)),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                            image: AssetImage(
                                "assets/AboutUsDonation/woman/4.jpeg"),
                            fit: BoxFit.cover)),
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
                    "Women and girls make up 43% of the agricultural workforce in the global south. In Eastern, Central, and Southern Africa, women and girls produce nearly 70% of the region's food crops by volume.\n\nBut women have a 27% higher chance than men of being severely food insecure.\n\nFor every dollar made by a man, a WomanAboutUs earns 77 cents, and 90% of that income is invested on their family, compared to 40% for men.\n\nWomen farmers have significantly less access to, control over, and ownership of land and other productive assets compared to their male counterparts: women account for only 12.8 per cent of agricultural landholders in the world.\n\nEnvironmental degradation and climate change have disproportionate impacts on women and children - Globally, women are 14 times more likely than men to die during a disaster.\n\nWomen are less likely to be entrepreneurs and face more disadvantages starting businesses: In 40% of economies, women's early-stage entrepreneurial activity is half or less than half of that of men's.",
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
