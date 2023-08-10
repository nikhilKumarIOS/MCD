import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../constants/LocalImages.dart';

somethingWentWrong(bool show, context) {
  Alert(
    closeIcon: null,
    style: const AlertStyle(),
    context: context,
    padding: const EdgeInsets.all(20),
    content: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        Image(
          image: AssetImage(LocalImages.alert),
          width: 50,
          height: 50,
        ),
        SizedBox(height: 20),
        Text("Alert",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center),
        SizedBox(height: 5),
        Text(
          "Something went wrong",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
          ),
        ),
      ],
    ),
    buttons: [
      DialogButton(
        margin: const EdgeInsets.only(left: 20),
        color: const Color.fromARGB(159, 114, 190, 21),
        radius: BorderRadius.circular(20),
        onPressed: () async {
          Navigator.pop(context);
        },
        child: const Text(
          "Okay ",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    ],
  ).show();
}

invalidUserNamePasswordAlert(context) {
  Alert(
    closeIcon: null,
    style: const AlertStyle(),
    context: context,
    padding: const EdgeInsets.all(20),
    content: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        Image(
          image: AssetImage(LocalImages.alert),
          width: 50,
          height: 50,
        ),
        SizedBox(height: 20),
        Text("Alert",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center),
        SizedBox(height: 5),
        Text(
          "Invalid user name or password!",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
          ),
        ),
      ],
    ),
    buttons: [
      DialogButton(
        margin: const EdgeInsets.only(left: 20),
        color: const Color.fromARGB(159, 114, 190, 21),
        radius: BorderRadius.circular(20),
        onPressed: () async {
          Navigator.pop(context);

          // await Navigator.pushReplacementNamed(
          //     context, RoutePaths.loginscreen);
        },
        child: const Text(
          "Okay ",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    ],
  ).show();
}
