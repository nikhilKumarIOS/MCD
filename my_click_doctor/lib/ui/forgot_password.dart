import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:my_click_doctor/main.dart';
import 'package:my_click_doctor/services/router.dart';
import 'package:my_click_doctor/tabbar_view.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;

import '../constants/LocalImages.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController username_ = TextEditingController();
  TextEditingController password_ = TextEditingController();
  final formKeyForgot = GlobalKey<FormState>();
  var client = http.Client();
  void initState() {
    super.initState();
    // SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Form(
          key: formKeyForgot,
          child: Container(
            height: h,
            width: w,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/login-bg.png'),
                    fit: BoxFit.fill)),
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            width: w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Ink(
                                  decoration: const ShapeDecoration(
                                      shape: CircleBorder(),
                                      color: Colors.grey),
                                  child: IconButton(
                                    icon: const Icon(Icons.arrow_back),
                                    iconSize: h / 40,
                                    color: Colors.black,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              ],
                            )),
                        const Padding(
                          padding:
                              EdgeInsets.only(top: 20, right: 110, left: 110),
                          child: Image(image: AssetImage('assets/logo.png')),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 0, right: 60, left: 60),
                          child: Image(
                              image: AssetImage('assets/forget-password.png')),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 30, top: 0, right: 30),
                          child: Container(
                              height: h / 2.3,
                              // width: w / 10,
                              color: Colors.white,
                              child:

                                  // Expanded(
                                  //     flex: 2,
                                  //     child:
                                  Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Forgot Password',
                                    style: TextStyle(
                                        fontSize: w / 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    child: Text(
                                      'Please enter your email address. We will send you a link, with which you can reset your password',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: w / 30,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: w / 25,
                                        color: Colors.black,
                                        width: 5,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'E-mail address',
                                        style: TextStyle(
                                            fontSize: w / 30,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: TextFormField(
                                        validator: MultiValidator(
                                          [
                                            RequiredValidator(
                                                errorText:
                                                    '*Email is required'),
                                          ],
                                        ),
                                        controller: username_,

                                        // controller: nameController,
                                        // obscureText: isMail,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: w / 30,
                                        ),
                                        decoration: InputDecoration(
                                            // hintText: 'Enter Email',

                                            // hintStyle: TextStyle( color: Colors.white),

                                            suffixIcon: Icon(Icons.mail),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              borderSide: BorderSide.none,
                                            ),
                                            fillColor: Color.fromARGB(
                                                239, 239, 247, 248),
                                            filled: true)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          minimumSize: Size.fromHeight(50),
                                          backgroundColor:
                                              Color.fromARGB(159, 114, 190, 21),
                                        ),
                                        onPressed: () {
                                          if (formKeyForgot.currentState
                                              .validate()) {
                                            forgotPassword(
                                                username_.text.trim());
                                          }
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: w / 20,
                                            ),
                                            Text('SEND',
                                                style: TextStyle(
                                                  fontSize: w / 30,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black,
                                                )),
                                            const Icon(
                                              Icons.arrow_forward,
                                              color: Colors.black,
                                            )
                                          ],
                                        )),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, RoutePaths.loginscreen);
                                        },
                                        child: Text("Remember your password ? ",
                                            style: TextStyle(
                                              fontSize: w / 30,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey[500],
                                            )),
                                      ),
                                    ],
                                  )
                                ],
                              )
                              //),
                              ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),

      //),
    ));
  }

  Future<Object> forgotPassword(String username) async {
    print(username);

    var response = await client.post(
      Uri.parse(
          'https://api.myclickdoctor.com/v3/api/Account/GetForgetPaassword'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'Email': username,
      }),
    );
    if (response.statusCode == 200) {
      final storage = FlutterSecureStorage(); //token
      var Body = json.decode(response.body);

      if (Body['code'] == 200) {
        return Alert(
          closeIcon: null,
          style: const AlertStyle(),
          context: context,
          padding: const EdgeInsets.all(20),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Image(
                image: AssetImage("assets/check.png"),
                width: 50,
                height: 50,
              ),
              SizedBox(height: 20),
              Text("SUCCESS",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center),
              SizedBox(height: 5),
              Text(
                "A link has been sent to your provided email address.",
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
                Navigator.pushNamed(context, RoutePaths.loginscreen);
              },
              child: const Text(
                "Okay ",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ).show();
      } else if (Body['code'] == 501) {
        return Alert(
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
                "The e-mail entered is invalid. Please check!",
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
    } else {
      return Alert(
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
      ;
    }
  }
}
