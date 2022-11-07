import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ChatBodService extends StatefulWidget {
  final List messages;
  const ChatBodService({Key? key, required this.messages}) : super(key: key);

  @override
  _ChatBodServiceState createState() => _ChatBodServiceState();
}

class _ChatBodServiceState extends State<ChatBodService> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return ListView.separated(
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: widget.messages[index]['isUserMessage']
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: const Radius.circular(
                          20,
                        ),
                        topRight: const Radius.circular(20),
                        bottomRight: Radius.circular(
                            widget.messages[index]['isUserMessage'] ? 0 : 20),
                        topLeft: Radius.circular(
                            widget.messages[index]['isUserMessage'] ? 20 : 0),
                      ),
                      color: widget.messages[index]['isUserMessage']
                          ? HexColor("#D3FADE")
                          : HexColor("#D3FADE")),
                  constraints: BoxConstraints(maxWidth: w * 2 / 3),
                  child: Text(
                    widget.messages[index]['message'].text.text[0],
                    style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Gotham',
                        fontWeight: FontWeight.w400,
                        fontSize: 15),
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (_, i) =>
            const Padding(padding: const EdgeInsets.only(top: 10)),
        itemCount: widget.messages.length);
  }
}
