import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'language_controller.dart';
import 'language_widget.dart';


class LanguageScreen2 extends StatelessWidget {
  const LanguageScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
            'Language settings          ',
            style: TextStyle(color: Colors.black, fontFamily: 'Gotham'),
          ),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: GetBuilder<LocalizationController>(builder: (localizationController) {
            return Column(
              children: [
                Expanded(
                    child: Center(
                  child: Scrollbar(
                      child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(5),
                    child: Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                                child: Image.asset(
                              "assets/icons/Logo.png",
                              width: 120,
                            )),
                            const SizedBox(height: 30),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              // child:  Text('select'.tr,),
                            ),
                            Text(
                              'select'.tr,
                            ),
                            const SizedBox(height: 10),
                            GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2, childAspectRatio: 1),
                              itemCount: 2,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) => 
                               LanguageWidget(
                                languageModel: localizationController.languages[index],
                               index: index, localizationController: localizationController, 
                               )
                            ),
                            const SizedBox(height: 10),
                            Text('you_can_change_language'.tr),
                          ],
                        ),
                      ),
                    ),
                  )),
                ))
              ],
            );
          },
        ),
      ),
    );
  }
}

