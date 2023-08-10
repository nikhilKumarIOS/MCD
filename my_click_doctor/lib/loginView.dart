import 'package:flutter/material.dart';
import 'package:my_click_doctor/constants/LocalImages.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'package:my_click_doctor/services/router.dart';
import 'dart:convert';
//import 'dart:js';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController username_ = TextEditingController();
  TextEditingController password_ = TextEditingController();
  final formKeyLogin = GlobalKey<FormState>();
  var client = http.Client();
  var call = false;

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
            resizeToAvoidBottomInset: false,
            body: Form(
                key: formKeyLogin,
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
                              const Padding(
                                padding: EdgeInsets.only(
                                    top: 20, right: 110, left: 110),
                                child:
                                    Image(image: AssetImage('assets/logo.png')),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    'Doctor Login',
                                    style: TextStyle(
                                        fontSize: h / 48,
                                        fontWeight: FontWeight.w800),
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 30, top: 20, right: 30),
                                child: Container(
                                    height: h / 2.2,
                                    // width: w / 10,
                                    color: Colors.white,
                                    child:

                                        // Expanded(
                                        //     flex: 2,
                                        //     child:
                                        Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: w / 25,
                                              color: Colors.black,
                                              width: 5,
                                            ),
                                            const SizedBox(
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
                                          padding: const EdgeInsets.all(10),
                                          child: TextFormField(
                                            controller: username_,
                                            // obscureText: isMail,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: w / 30,
                                            ),
                                            decoration: InputDecoration(

                                                // hintText: 'Enter Email',

                                                // hintStyle: TextStyle( color: Colors.white),

                                                suffixIcon:
                                                    const Icon(Icons.mail),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  borderSide: BorderSide.none,
                                                ),
                                                fillColor: const Color.fromARGB(
                                                    239, 239, 247, 248),
                                                filled: true),
                                            validator: MultiValidator(
                                              [
                                                RequiredValidator(
                                                    errorText:
                                                        '*Email is required'),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: w / 25,
                                              color: Colors.black,
                                              width: 5,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'Password',
                                              style: TextStyle(
                                                  fontSize: w / 30,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: TextFormField(
                                            controller: password_,
                                            obscureText: true,

                                            // obscureText: isMail,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: w / 30,
                                            ),
                                            decoration: InputDecoration(
                                                // hintText: 'Enter Email',
                                                // hintStyle: TextStyle( color: Colors.white),
                                                suffixIcon:
                                                    const Icon(Icons.key),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  borderSide: BorderSide.none,
                                                ),
                                                fillColor: const Color.fromARGB(
                                                    239, 239, 247, 248),
                                                filled: true),
                                            validator: MultiValidator(
                                              [
                                                RequiredValidator(
                                                    errorText:
                                                        '*Password is required'),
                                                // EmailValidator(
                                                //     errorText:
                                                //         "Please enter valid email")
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, top: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pushNamed(
                                                        context,
                                                        RoutePaths
                                                            .forgotPasswordScreen);
                                                  },
                                                  child: Text(
                                                      'Forgot password ?',
                                                      style: TextStyle(
                                                        fontSize: w / 30,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.grey[500],
                                                      )),
                                                ),
                                                const SizedBox(width: 10),
                                              ],
                                            )),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, right: 20, bottom: 20),
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20))),
                                                minimumSize:
                                                    const Size.fromHeight(50),
                                                backgroundColor:
                                                    const Color.fromARGB(
                                                        159, 114, 190, 21),
                                              ),
                                              onPressed: () {
                                                if (formKeyLogin.currentState
                                                    .validate()) {
                                                  login(username_.text.trim(),
                                                      password_.text.trim());
                                                }
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width: w / 20,
                                                  ),
                                                  Text('LOGIN',
                                                      style: TextStyle(
                                                        fontSize: w / 30,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.black,
                                                      )),
                                                  const Icon(
                                                    Icons.arrow_forward,
                                                    color: Colors.black,
                                                  )
                                                ],
                                              )),
                                        ),
                                        // Row(
                                        //   mainAxisAlignment:
                                        //       MainAxisAlignment.center,
                                        //   children: [
                                        //     Text("Don't have an account? ",
                                        //         style: TextStyle(
                                        //           fontSize: w / 30,
                                        //           fontWeight: FontWeight.w500,
                                        //           color: Colors.grey[500],
                                        //         )),
                                        //     TextButton(
                                        //         onPressed: () {
                                        //           Navigator.pushNamed(
                                        //               context,
                                        //               RoutePaths
                                        //                   .registerScreen);
                                        //         },
                                        //         child: Text("Register",
                                        //             style: TextStyle(
                                        //               fontSize: w / 30,
                                        //               fontWeight:
                                        //                   FontWeight.w600,
                                        //               color: Colors.black,
                                        //             ))),
                                        //   ],
                                        // )
                                      ],
                                    )
                                    //),
                                    ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: h / 2.5,
                                width: w,
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(159, 114, 190, 21),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(140.0),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.all(30),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text('Miért érdemes?',
                                                style: TextStyle(
                                                  fontSize: w / 20,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                ))
                                          ],
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 20,
                                        top: 10,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.adjust_rounded,
                                            color: Colors.grey[800],
                                            size: w / 20,
                                          ),
                                          const SizedBox(width: 5),
                                          const Expanded(
                                              // padding:
                                              // EdgeInsets.only(left: 5, right: 20),
                                              child: Text(
                                            "Orvos-orvos közötti szakmai kommunikáció elósegítése",
                                            maxLines: 2,
                                            // softWrap: !true,
                                          )),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 20,
                                        top: 10,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.adjust_rounded,
                                            color: Colors.grey[800],
                                            size: w / 20,
                                          ),
                                          const SizedBox(width: 5),
                                          const Expanded(
                                              // padding:
                                              // EdgeInsets.only(left: 5, right: 20),
                                              child: Text(
                                            "Orvosok közösségének összekötése",
                                            maxLines: 2,
                                            // softWrap: !true,
                                          )),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 20,
                                        top: 10,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.adjust_rounded,
                                            color: Colors.grey[800],
                                            size: w / 20,
                                          ),
                                          const SizedBox(width: 5),
                                          const Expanded(
                                              // padding:
                                              // EdgeInsets.only(left: 5, right: 20),
                                              child: Text(
                                            "A szakmai tudás rendszeres átadásának biztosí-tása",
                                            maxLines: 2,
                                            // softWrap: !true,
                                          )),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 20,
                                        top: 10,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.adjust_rounded,
                                            color: Colors.grey[800],
                                            size: w / 20,
                                          ),
                                          const SizedBox(width: 5),
                                          const Expanded(
                                              // padding:
                                              // EdgeInsets.only(left: 5, right: 20),
                                              child: Text(
                                            "Folyamatos, adekvát, megbízható szolgáltatásnyújtása, melyre mindig számíthat",
                                            maxLines: 2,
                                            // softWrap: !true,
                                          )),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 20,
                                        top: 10,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.adjust_rounded,
                                            color: Colors.grey[800],
                                            size: w / 20,
                                          ),
                                          const SizedBox(width: 5),
                                          const Expanded(
                                              // padding:
                                              // EdgeInsets.only(left: 5, right: 20),
                                              child: Text(
                                            "Bárhonnan. bármikor elérhetö",
                                            maxLines: 2,
                                            // softWrap: !true,
                                          )),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 20,
                                        top: 10,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.adjust_rounded,
                                            color: Colors.grey[800],
                                            size: w / 20,
                                          ),
                                          const SizedBox(width: 5),
                                          const Expanded(
                                              // padding:
                                              // EdgeInsets.only(left: 5, right: 20),
                                              child: Text(
                                            "DÍJMENTES",
                                            maxLines: 2,
                                            // softWrap: !true,
                                          )),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ))));
  }

  Future<Object> login(String username, String password) async {
    print(username);
    print(password);

    var response = await client.post(
      Uri.parse('https://api.myclickdoctor.com/v3/api/Account/Login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'Email': "fahadarshad0125@gmail.com", // username,
        'Password': password,
        'Usertype': 2.toString()
      }),
    );
    if (response.statusCode == 200) {
      final storage = FlutterSecureStorage(); //token
      var Body = json.decode(response.body);

      if (Body['code'] == 200) {
        //doctortype//KeyOpinionLeader
        var token = Body['token'];
        var id = Body['id'];
        var userId = Body['userId'];
        var photo = Body['profilePhoto'];
        var doctortype = Body['doctortype'];
        var usern = username;
        var pass = password;

        print(token);
        print(id);
        print(userId);

        storage.write(key: 'token', value: token);
        storage.write(key: 'id', value: id.toString());
        storage.write(key: 'userId', value: userId.toString());
        storage.write(key: 'profilePhoto', value: photo.toString());
        storage.write(key: 'username', value: usern.toString());
        storage.write(key: 'password', value: pass.toString());
        storage.write(key: 'dtype', value: doctortype);

        return Navigator.pushNamed(context, RoutePaths.myTabBar);
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
    }
  }
}
