import 'package:flutter/material.dart';

//this is for Snack Bar
void openSnackbar(context, snackMessage, color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      action: SnackBarAction(
        label: "OK",
        textColor: Colors.white,
        onPressed: () {},
      ),
      content: Text(
        snackMessage,
        style: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.w400, fontFamily: 'Gotham'),
      ),
    ),
  );
}
