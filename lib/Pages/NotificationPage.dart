import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:jmc/Utils/NextScreen.dart';
import 'package:jmc/main.dart';
import 'package:jmc/module/NotificationApi.dart';
import 'package:provider/provider.dart';

import '../Utils/SnackBar.dart';

class NotificationPage extends StatefulWidget {
  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

//this page is for button when user touch bitton then show notification
class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    //for show local notifications
    Provider.of<NotificationService>(context, listen: false).initialize();

    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                color: Color.fromARGB(255, 117, 243, 33),
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body!)],
                  ),
                ),
              );
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Heading Part
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
            'Notification          ',
            style: TextStyle(color: Colors.black, fontFamily: 'Gotham'),
          ),
        ),
        elevation: 0,
      ),

      //this is body part
      body: Container(
        child: Center(
          child: Consumer<NotificationService>(
            builder: (context, model, _) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //instance notification Button
                SizedBox(
                  height: 50,
                  width: 250,
                  child: ElevatedButton(
                    onPressed: () => model.instantNofitication(),
                    child: const Text(
                      'Instant Notification',
                      style: TextStyle(
                          fontFamily: 'Gotham',
                          color: Colors.black,
                          fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: HexColor("#22E183"),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 15),

                //image Notification
                SizedBox(
                  height: 50,
                  width: 250,
                  child: ElevatedButton(
                    onPressed: () => model.imageNotification(),
                    child: const Text(
                      'Image Notification',
                      style: TextStyle(
                          fontFamily: 'Gotham',
                          color: Colors.black,
                          fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: HexColor("#22E183"),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 15),

                //Schedule Notification
                SizedBox(
                  height: 50,
                  width: 250,
                  child: ElevatedButton(
                    onPressed: () {
                      model.sheduledNotification();
                      //show succuful Schdule message
                      openSnackbar(
                          context,
                          "Notification sheduled for 1 mintue ",
                          const Color.fromARGB(255, 70, 213, 92));
                    },
                    child: Text(
                      'Scheduled Notification',
                      style: TextStyle(
                          fontFamily: 'Gotham',
                          color: Colors.black,
                          fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: HexColor("#22E183"),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 15),

                //cancel Notification
                SizedBox(
                  height: 50,
                  width: 250,
                  child: ElevatedButton(
                    onPressed: () {
                      model.cancelNotification();
                      //show succuful Schdule message
                      openSnackbar(
                        context,
                        "Sheduled Notification Canceled",
                        Colors.red,
                      );
                    },
                    child: const Text(
                      'Cancel Notification',
                      style: TextStyle(
                          fontFamily: 'Gotham',
                          color: Colors.black,
                          fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: HexColor("#22E183"),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
