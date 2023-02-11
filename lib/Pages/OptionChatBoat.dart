import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:kommunicate_flutter/kommunicate_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

import '../provider/InternetProvider.dart';

class OptionChatBot extends StatefulWidget {
  const OptionChatBot({super.key});

  @override
  State<OptionChatBot> createState() => _OptionChatBotState();
}

class _OptionChatBotState extends State<OptionChatBot> {
  //for check loading
  bool isFinished = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: HexColor("#22E183"),
      body: Padding(
        padding: const EdgeInsets.only(top: 120),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                //for chatbot image
                Container(
                  // color: Colors.yellow,
                  child: Image.asset("assets/images/chatbot.gif"),
                ),

                //for Text
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Text(
                    "What?".tr,
                    style: TextStyle(
                        color: HexColor("#002C00"),
                        fontFamily: "Gotham",
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        wordSpacing: 2),
                  ),
                ),

                //for button
                Padding(
                  padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
                  child: SwipeableButtonView(
                    buttonText: 'Start_Converstaion'.tr,
                    buttonWidget: Container(
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: HexColor("#002C00"),
                      ),
                    ),
                    activeColor: HexColor("#22E183"),
                    isFinished: isFinished,
                    onWaitingProcess: () {
                      Future.delayed(Duration(seconds: 2), () {
                        setState(() {
                          isFinished = true;
                        });
                      });
                    },
                    onFinish: () async {
                      //check internet is on or not
                      final ip = context.read<InternetProvider>();
                      await ip.checkInternetConnection();

                      //for checking Internet
                      if (ip.hasInternet == false) {
                        //show pop-up box
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.warning,
                          title: "Check connection",
                          text: "Please turn on your internet connection",
                          confirmBtnText: "Thanks!",
                          confirmBtnColor: Color.fromARGB(255, 33, 112, 132),
                          width: 25,
                        );
                      } else {
                        try {
                          dynamic conversationObject = {
                            // The [APP_ID](https://dashboard.kommunicate.io/settings/install) obtained from kommunicate dashboard.
                            'appId': '35cadec8d26f5cd827ba032ba39b23619',
                          };

                          dynamic result =
                              await KommunicateFlutterPlugin.buildConversation(
                                  conversationObject);

                          print("Conversation builder success : " +
                              result.toString());
                        } catch (e) {
                          print(e);
                        }
                      }

                      setState(() {
                        isFinished = false;
                      });
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
