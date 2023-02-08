import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:kommunicate_flutter/kommunicate_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../module/ChatBodService.dart';
import '../provider/InternetProvider.dart';

class Chatbod extends StatefulWidget {
  const Chatbod({Key? key}) : super(key: key);

  @override
  State<Chatbod> createState() => _ChatbodState();
}

class _ChatbodState extends State<Chatbod> {
  late DialogFlowtter dialogFlowtter;
  final TextEditingController _controller = TextEditingController();

  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //for Heading
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Color(0xff22E183),
        title: Column(
          children: [
            Container(
              child: Column(
                children: [
                  // sub container for main heading
                  Container(
                    margin: EdgeInsets.only(top: 23, left: 8),
                    height: 25,
                    width: 361,
                    color: HexColor("#22E183"),
                    child: const Text(
                      "What can we do for you? ",
                      style: TextStyle(
                          fontFamily: "Gotham",
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ),

                  // sub conatiner for both icon and sub heading
                  Container(
                    margin: EdgeInsets.only(left: 4),
                    height: 40,
                    width: 361,
                    decoration: BoxDecoration(
                        color: HexColor("#22E183"),
                        borderRadius: BorderRadius.circular(100)),
                    child: Row(
                      //for adding icon and heading in row
                      children: [
                        Container(
                            //ChatBod Icon
                            margin: EdgeInsets.only(left: 5, bottom: 5),
                            height: 20,
                            width: 30,
                            child: Image.asset("assets/icons/Cb.png")),
                        Container(
                          //sub Heading
                          margin: EdgeInsets.only(bottom: 2),
                          child: const Text(
                            "Talk with your Personal Assistant",
                            style: TextStyle(
                                fontFamily: "Gotham",
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      //body part
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            //chatboat icon
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 230),
                child: Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                      color: HexColor("#D3FADE"),
                      borderRadius: BorderRadius.circular(100)
                      //more than 50% of width makes circle
                      ),
                  child: IconButton(
                    onPressed: () async {
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
                    },
                    icon: Icon(Icons.chat_rounded),
                    color: HexColor("#22E183"),
                    iconSize: 40,
                  ),
                ),
              ),
            ),

            // Expanded(child: ChatBodService(messages: messages)),
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: TextField(
            //           controller: _controller,
            //           decoration: InputDecoration(
            //             filled: true,
            //             fillColor: HexColor('#F5F6EA'),
            //             hintText: "how may I be of service",
            //             border: OutlineInputBorder(
            //                 borderRadius: BorderRadius.circular(33)),
            //             focusedBorder: OutlineInputBorder(
            //               borderSide: BorderSide(color: HexColor("#002C00")),
            //               borderRadius: BorderRadius.circular(25.7),
            //             ),
            //             enabledBorder: UnderlineInputBorder(
            //               borderSide: const BorderSide(color: Colors.white),
            //               borderRadius: BorderRadius.circular(25.7),
            //             ),
            //           ),
            //         ),
            //       ),
            //       SizedBox(width: 5),
            //       IconButton(
            //         onPressed: () {
            //           sendMessage(_controller.text);
            //           _controller.clear();
            //         },
            //         icon: Icon(
            //           Icons.send,
            //           size: 28,
            //           color: HexColor('#002C00'),
            //         ),
            //       )
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  sendMessage(String text) async {
    if (text.isEmpty) {
      print('Message is empty');
    } else {
      setState(() {
        addMessage(Message(text: DialogText(text: [text])), true);
      });

      DetectIntentResponse response = await dialogFlowtter.detectIntent(
          queryInput: QueryInput(text: TextInput(text: text)));
      if (response.message == null) return;
      setState(() {
        addMessage(response.message!);
      });
    }
  }

  addMessage(Message message, [bool isUserMessage = false]) {
    messages.add({'message': message, 'isUserMessage': isUserMessage});
  }
}
