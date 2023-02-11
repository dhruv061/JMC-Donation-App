import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class sendEmail extends StatefulWidget {
  const sendEmail({super.key});

  @override
  State<sendEmail> createState() => _sendEmailState();
}

class _sendEmailState extends State<sendEmail> {
  //for send e-mail
  final reciverController = TextEditingController();
  final bodyController = TextEditingController();
  final subjectController = TextEditingController();

  var reciver;
  var subject;
  var body;

  //for Validation
  final _key = GlobalKey<FormState>();

  @override
  void dispose() {
    reciverController.dispose();
    bodyController.dispose();
    subjectController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF22E183),

        //for back arrow option
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),

        title: const Center(
          child: Text(
            'Send E-mail         ',
            style: TextStyle(color: Colors.black, fontFamily: 'Gotham'),
          ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 130),
        child: Column(
          children: [
            //for TextFileds
            Form(
              key: _key,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    //for Reciver Text Filed
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,

                      //for autofil e-mail
                      autofillHints: [AutofillHints.email],
                      controller: reciverController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(
                          Icons.email,
                          color: HexColor("#002C00"),
                        ),
                        hintText: "Reciver e-mail",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(33)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: HexColor("#002C00")),
                          borderRadius: BorderRadius.circular(25.7),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(25.7),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    //for subject Text Filed
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: subjectController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(
                          Icons.subject,
                          color: HexColor("#002C00"),
                        ),
                        hintText: "subject",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(33)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: HexColor("#002C00")),
                          borderRadius: BorderRadius.circular(25.7),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(25.7),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    //for body Text Filed
                    TextFormField(
                      controller: bodyController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(
                          Icons.data_array,
                          color: HexColor("#002C00"),
                        ),
                        hintText: "body part",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(33)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: HexColor("#002C00")),
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

                    const SizedBox(height: 12),

                    const SizedBox(
                      height: 18,
                    ),

                    //send email button
                    SizedBox(
                      height: 50,
                      width: 190,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: HexColor("#22E183"),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),

                        //for loading indicator and Text
                        icon: const Icon(Icons.email, size: 24),

                        label: const Text(
                          'SendEmail',
                          style: const TextStyle(
                              fontFamily: 'Gotham', fontSize: 22),
                        ),

                        onPressed: () async {
                          setState(() {
                            reciver = reciverController.text;
                            subject = subjectController.text;
                            body = bodyController.text;
                          });

                          final Email send_email = Email(
                            body: body,
                            subject: subject,
                            recipients: [reciver],
                            // cc: ['example_cc@ex.com'],
                            // bcc: ['example_bcc@ex.com'],
                            // attachmentPaths: ['/path/to/email_attachment.zip'],
                            isHTML: false,
                          );

                          await FlutterEmailSender.send(send_email);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
