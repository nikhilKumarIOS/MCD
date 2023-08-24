import 'package:flutter/material.dart';
import 'package:my_click_doctor/constants/LocalImages.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:my_click_doctor/constants/appConstants.dart';

import 'package:my_click_doctor/services/router.dart';
import 'dart:convert';
//import 'dart:js';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:my_click_doctor/ui/login/login_bloc/login_events.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../widgets/alerts.dart';
import 'login_bloc/login_bloc.dart';
import 'login_bloc/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKeyLogin = GlobalKey<FormState>();
  var client = http.Client();
  var call = false;
  final _loginBloc = LoginBloc();

  void initState() {
    super.initState();
  
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
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
                                          child: StreamBuilder<String>(
                                            stream: _loginBloc.usernameStream,
                                            builder: (context, snapshot) {
                                              return TextFormField(
                                                onChanged: (username) {
                                                  _loginBloc.handleEvent(
                                                      UsernameChangedEvent(
                                                          username));
                                                },
                                                validator: (value) {
                                                  if (snapshot.hasError) {
                                                    return snapshot.error;
                                                  }
                                                  return null;
                                                },
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: w / 30,
                                                ),
                                                decoration: InputDecoration(
                                                    suffixIcon:
                                                        const Icon(Icons.mail),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      borderSide:
                                                          BorderSide.none,
                                                    ),
                                                    fillColor:
                                                        const Color.fromARGB(
                                                            239, 239, 247, 248),
                                                    filled: true),
                                              );
                                            },
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
                                          child: StreamBuilder<String>(
                                            stream: _loginBloc.passwordStream,
                                            builder: (context, snapshot) {
                                              return TextFormField(
                                                onChanged: (password) {
                                                  _loginBloc.handleEvent(
                                                      PasswordChangedEvent(
                                                          password));
                                                },
                                                validator: (value) {
                                                  if (snapshot.hasError) {
                                                    return snapshot.error;
                                                  }
                                                  return null;
                                                },
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: w / 30,
                                                ),
                                                decoration: InputDecoration(
                                                    suffixIcon:
                                                        const Icon(Icons.mail),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      borderSide:
                                                          BorderSide.none,
                                                    ),
                                                    fillColor:
                                                        const Color.fromARGB(
                                                            239, 239, 247, 248),
                                                    filled: true),
                                              );
                                            },
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
                                          child: StreamBuilder<LoginState>(
                                            stream: _loginBloc.stateStream,
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                final state = snapshot.data;
                                                if (state
                                                    is LoadingLoginState) {
                                                  return SizedBox(
                                                      height: 30,
                                                      width: 30,
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: AppColors.green,
                                                      ));
                                                } else if (state
                                                    is ErrorLoginState) {
                                                  return invalidUserNamePasswordAlert(
                                                      context);
                                                } else if (state
                                                    is SuccessLoginState) {
                                                  _handleNavigation(context);
                                                }
                                              }
                                              return ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          20))),
                                                  minimumSize:
                                                      const Size.fromHeight(50),
                                                  backgroundColor:
                                                      const Color.fromARGB(
                                                          159, 114, 190, 21),
                                                ),
                                                onPressed: snapshot.data
                                                        is SuccessLoginState
                                                    ? null
                                                    : () =>
                                                        _loginBloc.handleEvent(
                                                            SubmitLoginEvent()),
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
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                    
                                    
                                    
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

  Future<void> _handleNavigation(BuildContext context) async {
    await Future.delayed(Duration.zero);
    Navigator.pushNamed(context, RoutePaths.myTabBar);
  }
}
