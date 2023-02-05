import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jmc/Classes/ImageUploadCheck.dart';
import 'package:jmc/module/ProfilePage_AfterLogin.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../Utils/SnackBar.dart';
import '../Classes/SessionController.dart';

class SetImage extends StatefulWidget {
  const SetImage({super.key});

  @override
  State<SetImage> createState() => _SetImageState();
}

class _SetImageState extends State<SetImage> {
  //create firebase_storage instance for storing image
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  DatabaseReference databaseRef = FirebaseDatabase.instance.ref('users');

  //for Storing Image
  File? _image;
  final picker = ImagePicker();

  //get user name that store with userimage in firebase storage
  final ref = FirebaseDatabase.instance.ref('users');

  //Image From Cemera
  Future ImageFromCemera() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);

        //for convert imagecropeed file to file
        CropImage();
      } else {
        openSnackbar(context, 'Image not Picked', Colors.red);
      }
    });
  }

  //Image From Gallery
  Future ImageFromGallery() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        CropImage();
      } else {
        openSnackbar(context, 'Image not Picked', Colors.red);
      }
    });
  }

  //choose option from Open Gallery or Camera
  void ShowPicker(context) {
    showModalBottomSheet(
      backgroundColor: HexColor("#D3FADE"),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 20,
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: [
              //for choosing Image From Gallery
              ListTile(
                leading: Icon(
                  Icons.photo_library,
                  color: HexColor("#002C00"),
                  size: 25,
                ),
                title: const Text(
                  'Photo Library',
                  style: TextStyle(
                      fontFamily: 'Gotham',
                      fontWeight: FontWeight.w400,
                      fontSize: 18),
                ),
                onTap: () {
                  try {
                    ImageFromGallery();
                    Navigator.of(context).pop();
                  } catch (e) {
                    openSnackbar(context, e.toString(), Colors.red);
                  }
                },
              ),

              //for choosing Image From Camera
              ListTile(
                leading: Icon(
                  Icons.photo_camera,
                  color: HexColor("#002C00"),
                  size: 25,
                ),
                title: const Text(
                  'Camera',
                  style: TextStyle(
                      fontFamily: 'Gotham',
                      fontWeight: FontWeight.w400,
                      fontSize: 18),
                ),
                onTap: () async {
                  try {
                    ImageFromCemera();

                    Navigator.of(context).pop();
                  } catch (e) {
                    openSnackbar(context, e.toString(), Colors.red);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  //for croping Image
  Future<void> CropImage() async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: _image!.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        maxWidth: 512,
        maxHeight: 512,
        cropStyle: CropStyle.circle);

    //for convert imagecropeed file to file
    try {
      var file = File(croppedFile!.path);
      setState(() {
        _image = file;
      });
    } catch (e) {
      Navigator.of(context).pop();
      openSnackbar(context, 'Image not Picked', Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    //for RoundedLoadingButton Controller
    final RoundedLoadingButtonController UploadImageController =
        RoundedLoadingButtonController();

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
            'Set Image       ',
            style: TextStyle(color: Colors.black, fontFamily: 'Gotham'),
          ),
        ),
        elevation: 0,
      ),

      body: Column(
        children: [
          //for User Image if user login with E-mail address
          Padding(
            padding: const EdgeInsets.only(top: 140),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  ShowPicker(context);
                },
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: HexColor("#22E183"),
                  child: _image != null
                      ? ClipOval(
                          child: Image.file(
                            _image!.absolute,
                            height: 160,
                            width: 160,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Container(
                          // margin: const EdgeInsets.only(top: 30),
                          height: 160,
                          width: 160,
                          decoration: BoxDecoration(
                              color: Colors.lightBlueAccent,
                              borderRadius: BorderRadius.circular(100)),

                          //show user profile Pictue if he was sign in with hlep og Google
                          child: CircleAvatar(
                            radius: 55,
                            child: ClipRRect(
                              child: Image.asset(
                                  'assets/icons/DefaultAccountPhoto.png'),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                        ),
                ),
              ),
            ),
          ),

          SizedBox(height: 20),

          StreamBuilder(
            //this data comes from Real time database
            stream: ref.child(SessionController().userId.toString()).onValue,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                Map<dynamic, dynamic> map = snapshot.data.snapshot.value;

                //Upload Image Button
                return RoundedLoadingButton(
                  onPressed: () async {
                    if (_image != null) {
                      try {
                        //for storing image in firebase_storage
                        firebase_storage.Reference ref = firebase_storage
                            .FirebaseStorage.instance
                            .ref(map['Name'] +
                                ' + ' +
                                SessionController().userId.toString());

                        firebase_storage.UploadTask uploadTask =
                            ref.putFile(_image!.absolute);

                        await Future.value(uploadTask);
                        var newImageUrl = await ref.getDownloadURL();

                        //Update image_url value in real time database
                        databaseRef
                            .child(SessionController().userId.toString())
                            .update({
                          'image_url': newImageUrl.toString(),
                        });

                        //set true for imageUploaded
                        ImageUploadCheck().isImageUploaded = true;

                        Navigator.of(context).pop();

                        openSnackbar(context, 'Image Uploaded',
                            Color.fromARGB(255, 133, 230, 101));
                        UploadImageController.stop();
                      } catch (e) {
                        UploadImageController.stop();
                        openSnackbar(context, e.toString(), Colors.red);
                      }
                    } else {
                      UploadImageController.stop();
                      openSnackbar(context, 'Please Select Image', Colors.red);
                    }
                  },
                  controller: UploadImageController,
                  successColor: HexColor("#22E183"),
                  loaderSize: 25,
                  loaderStrokeWidth: 2.5,
                  width: MediaQuery.of(context).size.width * 0.80,
                  elevation: 0,
                  borderRadius: 25,
                  color: HexColor("#22E183"),
                  valueColor: HexColor("#002C00"),
                  child: Wrap(
                    children: const [
                      Icon(
                        Icons.upload,
                        color: Colors.black,
                      ),
                      SizedBox(width: 10),
                      Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Text(
                          'Upload Image ',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Gotham',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }

              return Container();
            },
          ),
        ],
      ),
    );
  }
}
