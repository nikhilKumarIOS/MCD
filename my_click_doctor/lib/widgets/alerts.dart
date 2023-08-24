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

cancelAppointmentAlert(id, context) {
  Alert(
    closeIcon: null,
    style: AlertStyle(),
    context: context,
    padding: EdgeInsets.all(20),
    content: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Image(
          image: AssetImage("assets/cancel.png"),
          width: 50,
          height: 50,
        ),
        SizedBox(height: 20),
        Text("CANCEL APPOINTMENT",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center),
        SizedBox(height: 5),
        Text(
          "Are you sure you want to cancel the appointment",
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
        color: Colors.red[500],
        radius: BorderRadius.circular(20),
        onPressed: () {
          Navigator.pop(context);
          // cancelAppointment(
          //     e["appointmentId"] ?? "");
        },
        child: const Text(
          "Yes",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      DialogButton(
        margin: const EdgeInsets.only(right: 20, left: 10),
        color: Colors.grey[800],
        radius: BorderRadius.circular(20),
        onPressed: () => Navigator.pop(context),
        child: const Text(
          "Cancel",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    ],
  ).show();
}

Future<void> successfullyUploadedNotUploaded(
    bool isuploaded, BuildContext context) {
  return Alert(
    closeIcon: null,
    style: const AlertStyle(),
    context: context,
    padding: const EdgeInsets.all(20),
    content: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image(
          image: AssetImage(LocalImages.check),
          width: 50,
          height: 50,
        ),
        SizedBox(height: 20),
        Text(isuploaded ? "Successful" : "Unsuccessful",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center),
        SizedBox(height: 5),
        Text(
          isuploaded ? "Successfully uploaded" : "file has not been uploaded",
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
