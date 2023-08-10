import 'dart:math';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_click_doctor/services/router.dart';
import 'package:my_click_doctor/support_screen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'basic_infomation.dart';
import 'chat_live_screen.dart';
import 'doctor_profile.dart';
import 'main.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenPageState();
}

class _ChatScreenPageState extends State<ChatScreen> {
  final popUpControler = CustomPopupMenuController();
  bool widgetSelected = true;
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
      backgroundColor: const Color.fromARGB(239, 239, 247, 248),
      body: SizedBox(
        height: h,
        width: w,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image(
                                height: h / 15,
                                image: const AssetImage('assets/logo.png')),
                            Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  height: h / 14,
                                  width: w / 2.8,
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(216, 2, 7, 29),
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(30.0),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: Row(
                                            children: [
                                              ClipOval(
                                                child: Material(
                                                  color: Colors
                                                      .white, // Button color
                                                  child: InkWell(
                                                    splashColor: Colors
                                                        .black, // Splash color
                                                    onTap: () {
                                                      Navigator.pushNamed(
                                                          context,
                                                          RoutePaths
                                                              .supportScreen);
                                                    },
                                                    child: Container(
                                                        margin:
                                                            EdgeInsets.all(10),
                                                        width: h / 46,
                                                        height: h / 46,
                                                        child: const Image(
                                                            image: AssetImage(
                                                                'assets/question-sign.png'))),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              CustomPopupMenu(
                                                controller: popUpControler,
                                                child: Image(
                                                  height: h / 22,
                                                  width: h / 22,
                                                  fit: BoxFit.fill,
                                                  image: AssetImage(
                                                      'assets/female-user.png'),
                                                ),
                                                menuBuilder: () =>
                                                    GestureDetector(
                                                  child: _buildAvatar(),
                                                ),
                                                barrierColor:
                                                    Colors.transparent,
                                                pressType:
                                                    PressType.singleClick,
                                                arrowColor: Colors.blueAccent,
                                                // position:
                                                //     PreferredPosition.top,
                                              ),
                                            ],
                                          ))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        )),
                    Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Image(
                                      height: h / 56,
                                      image:
                                          AssetImage('assets/four-dots.png')),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text('Chat',
                                      style: TextStyle(
                                        fontSize: w / 26,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.black,
                                      )),
                                ],
                              )
                            ],
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20, left: 20, right: 20, bottom: 10),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0.0,
                            shadowColor: Colors.transparent,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            minimumSize: const Size.fromHeight(60),
                            backgroundColor: Colors.white,
                          ),
                          onPressed: () async {
                            Navigator.pushNamed(
                                context, RoutePaths.chatLiveScreen);
                            // Navigator.
                            // Navigator.pop(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10,
                                        left: 0,
                                        right: 10,
                                        bottom: 10),
                                    child: CircleAvatar(
                                      radius: h / 30,
                                      backgroundColor:
                                          Colors.grey, // Image radius
                                      backgroundImage: const AssetImage(
                                          'assets/doctor-pic.png'),
                                    ),
                                  ),
                                  // Image(
                                  //     height: h / 46,
                                  //     image:
                                  //         const AssetImage('assets/info.png')),
                                  const SizedBox(width: 10),

                                  Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('User guides',
                                            style: TextStyle(
                                              fontSize: w / 30,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            )),
                                        SizedBox(height: 5),
                                        Text('Last seen 2 days agc',
                                            style: TextStyle(
                                              fontSize: w / 40,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            )),
                                      ])
                                ],
                              ),

                              //   ],
                              // )
                            ],
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 10),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0.0,
                            shadowColor: Colors.transparent,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            minimumSize: const Size.fromHeight(60),
                            backgroundColor: Colors.white,
                          ),
                          onPressed: () async {
                            Navigator.pushNamed(
                                context, RoutePaths.chatLiveScreen);
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute<void>(
                            //       builder: (context) => MyTabBar()),
                            // );
                            // Navigator.
                            // Navigator.pop(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10,
                                        left: 0,
                                        right: 10,
                                        bottom: 10),
                                    child: CircleAvatar(
                                      radius: h / 30,
                                      backgroundColor:
                                          Colors.grey, // Image radius
                                      backgroundImage: const AssetImage(
                                          'assets/doctor-pic.png'),
                                    ),
                                  ),
                                  // Image(
                                  //     height: h / 46,
                                  //     image:
                                  //         const AssetImage('assets/info.png')),
                                  const SizedBox(width: 10),

                                  Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('User guides',
                                            style: TextStyle(
                                              fontSize: w / 30,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            )),
                                        SizedBox(height: 5),
                                        Text('Online',
                                            style: TextStyle(
                                              fontSize: w / 40,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            )),
                                      ])
                                ],
                              ),

                              //   ],
                              // )
                            ],
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 10),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0.0,
                            shadowColor: Colors.transparent,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            minimumSize: const Size.fromHeight(60),
                            backgroundColor: Colors.white,
                          ),
                          onPressed: () async {
                            Navigator.pushNamed(
                                context, RoutePaths.chatLiveScreen);
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute<void>(
                            //       builder: (context) => MyTabBar()),
                            // );
                            // Navigator.
                            // Navigator.pop(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10,
                                        left: 0,
                                        right: 10,
                                        bottom: 10),
                                    child: CircleAvatar(
                                      radius: h / 30,
                                      backgroundColor:
                                          Colors.grey, // Image radius
                                      backgroundImage: const AssetImage(
                                          'assets/doctor-pic.png'),
                                    ),
                                  ),
                                  // Image(
                                  //     height: h / 46,
                                  //     image:
                                  //         const AssetImage('assets/info.png')),
                                  const SizedBox(width: 10),

                                  Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('User guides',
                                            style: TextStyle(
                                              fontSize: w / 30,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            )),
                                        SizedBox(height: 5),
                                        Text('Online',
                                            style: TextStyle(
                                              fontSize: w / 40,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            )),
                                      ])
                                ],
                              ),

                              //   ],
                              // )
                            ],
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 10),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0.0,
                            shadowColor: Colors.transparent,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            minimumSize: const Size.fromHeight(60),
                            backgroundColor: Colors.white,
                          ),
                          onPressed: () async {
                            Navigator.pushNamed(
                                context, RoutePaths.chatLiveScreen);
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute<void>(
                            //       builder: (context) => MyTabBar()),
                            // );
                            // Navigator.
                            // Navigator.pop(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10,
                                        left: 0,
                                        right: 10,
                                        bottom: 10),
                                    child: CircleAvatar(
                                      radius: h / 30,
                                      backgroundColor:
                                          Colors.grey, // Image radius
                                      backgroundImage: const AssetImage(
                                          'assets/doctor-pic.png'),
                                    ),
                                  ),
                                  // Image(
                                  //     height: h / 46,
                                  //     image:
                                  //         const AssetImage('assets/info.png')),
                                  const SizedBox(width: 10),

                                  Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('User guides',
                                            style: TextStyle(
                                              fontSize: w / 30,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            )),
                                        SizedBox(height: 5),
                                        Text('Online',
                                            style: TextStyle(
                                              fontSize: w / 40,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            )),
                                      ])
                                ],
                              ),

                              //   ],
                              // )
                            ],
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 10),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0.0,
                            shadowColor: Colors.transparent,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            minimumSize: const Size.fromHeight(60),
                            backgroundColor: Colors.white,
                          ),
                          onPressed: () async {
                            Navigator.pushNamed(
                                context, RoutePaths.chatLiveScreen);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10,
                                        left: 0,
                                        right: 10,
                                        bottom: 10),
                                    child: CircleAvatar(
                                      radius: h / 30,
                                      backgroundColor:
                                          Colors.grey, // Image radius
                                      backgroundImage: const AssetImage(
                                          'assets/doctor-pic.png'),
                                    ),
                                  ),
                                  // Image(
                                  //     height: h / 46,
                                  //     image:
                                  //         const AssetImage('assets/info.png')),
                                  const SizedBox(width: 10),

                                  Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('User guides',
                                            style: TextStyle(
                                              fontSize: w / 30,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            )),
                                      const  SizedBox(height: 5),
                                        Text('Online',
                                            style: TextStyle(
                                              fontSize: w / 40,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            )),
                                      ])
                                ],
                              ),

                              //   ],
                              // )
                            ],
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 10),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0.0,
                            shadowColor: Colors.transparent,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            minimumSize: const Size.fromHeight(60),
                            backgroundColor: Colors.white,
                          ),
                          onPressed: () async {
                            Navigator.pushNamed(
                                context, RoutePaths.chatLiveScreen);
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute<void>(
                            //       builder: (context) => MyTabBar()),
                            // );
                            // Navigator.
                            // Navigator.pop(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10,
                                        left: 0,
                                        right: 10,
                                        bottom: 10),
                                    child: CircleAvatar(
                                      radius: h / 30,
                                      backgroundColor:
                                          Colors.grey, // Image radius
                                      backgroundImage: const AssetImage(
                                          'assets/doctor-pic.png'),
                                    ),
                                  ),
                                  // Image(
                                  //     height: h / 46,
                                  //     image:
                                  //         const AssetImage('assets/info.png')),
                                  const SizedBox(width: 10),

                                  Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('User guides',
                                            style: TextStyle(
                                              fontSize: w / 30,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            )),
                                      const  SizedBox(height: 5),
                                        Text('Online',
                                            style: TextStyle(
                                              fontSize: w / 40,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            )),
                                      ])
                                ],
                              ),

                              //   ],
                              // )
                            ],
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 10),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0.0,
                            shadowColor: Colors.transparent,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            minimumSize: const Size.fromHeight(60),
                            backgroundColor: Colors.white,
                          ),
                          onPressed: () async {
                            Navigator.pushNamed(
                                context, RoutePaths.chatLiveScreen);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10,
                                        left: 0,
                                        right: 10,
                                        bottom: 10),
                                    child: CircleAvatar(
                                      radius: h / 30,
                                      backgroundColor:
                                          Colors.grey, // Image radius
                                      backgroundImage: const AssetImage(
                                          'assets/doctor-pic.png'),
                                    ),
                                  ),
                                  // Image(
                                  //     height: h / 46,
                                  //     image:
                                  //         const AssetImage('assets/info.png')),
                                  const SizedBox(width: 10),

                                  Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('User guides',
                                            style: TextStyle(
                                              fontSize: w / 30,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            )),
                                      const  SizedBox(height: 5),
                                        Text('Online',
                                            style: TextStyle(
                                              fontSize: w / 40,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            )),
                                      ])
                                ],
                              ),

                              //   ],
                              // )
                            ],
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 10),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0.0,
                            shadowColor: Colors.transparent,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            minimumSize: const Size.fromHeight(60),
                            backgroundColor: Colors.white,
                          ),
                          onPressed: () async {
                            Navigator.pushNamed(
                                context, RoutePaths.chatLiveScreen);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10,
                                        left: 0,
                                        right: 10,
                                        bottom: 10),
                                    child: CircleAvatar(
                                      radius: h / 30,
                                      backgroundColor:
                                          Colors.grey, // Image radius
                                      backgroundImage: const AssetImage(
                                          'assets/doctor-pic.png'),
                                    ),
                                  ),
                                  // Image(
                                  //     height: h / 46,
                                  //     image:
                                  //         const AssetImage('assets/info.png')),
                                  const SizedBox(width: 10),

                                  Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('User guides',
                                            style: TextStyle(
                                              fontSize: w / 30,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            )),
                                      const  SizedBox(height: 5),
                                        Text('Online',
                                            style: TextStyle(
                                              fontSize: w / 40,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            )),
                                      ])
                                ],
                              ),

                              //   ],
                              // )
                            ],
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 10),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0.0,
                            shadowColor: Colors.transparent,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            minimumSize: const Size.fromHeight(60),
                            backgroundColor: Colors.white,
                          ),
                          onPressed: () async {
                            Navigator.pushNamed(
                                context, RoutePaths.chatLiveScreen);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10,
                                        left: 0,
                                        right: 10,
                                        bottom: 10),
                                    child: CircleAvatar(
                                      radius: h / 30,
                                      backgroundColor:
                                          Colors.grey, // Image radius
                                      backgroundImage: const AssetImage(
                                          'assets/doctor-pic.png'),
                                    ),
                                  ),
                                  // Image(
                                  //     height: h / 46,
                                  //     image:
                                  //         const AssetImage('assets/info.png')),
                                  const SizedBox(width: 10),

                                  Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('User guides',
                                            style: TextStyle(
                                              fontSize: w / 30,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            )),
                                        SizedBox(height: 5),
                                        Text('Online',
                                            style: TextStyle(
                                              fontSize: w / 40,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            )),
                                      ])
                                ],
                              ),

                              //   ],
                              // )
                            ],
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 10),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0.0,
                            shadowColor: Colors.transparent,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            minimumSize: const Size.fromHeight(60),
                            primary: Colors.white,
                          ),
                          onPressed: () async {
                            Navigator.pushNamed(
                                context, RoutePaths.chatLiveScreen);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10,
                                        left: 0,
                                        right: 10,
                                        bottom: 10),
                                    child: CircleAvatar(
                                      radius: h / 30,
                                      backgroundColor:
                                          Colors.grey, // Image radius
                                      backgroundImage: const AssetImage(
                                          'assets/doctor-pic.png'),
                                    ),
                                  ),
                                  // Image(
                                  //     height: h / 46,
                                  //     image:
                                  //         const AssetImage('assets/info.png')),
                                  const SizedBox(width: 10),

                                  Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('User guides',
                                            style: TextStyle(
                                              fontSize: w / 30,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            )),
                                        SizedBox(height: 5),
                                        Text('Online',
                                            style: TextStyle(
                                              fontSize: w / 40,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            )),
                                      ])
                                ],
                              ),

                              //   ],
                              // )
                            ],
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 10),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0.0,
                            shadowColor: Colors.transparent,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            minimumSize: const Size.fromHeight(60),
                            backgroundColor: Colors.white,
                          ),
                          onPressed: () async {
                            Navigator.pushNamed(
                                context, RoutePaths.chatLiveScreen);
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute<void>(
                            //       builder: (context) => MyTabBar()),
                            // );
                            // Navigator.
                            // Navigator.pop(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10,
                                        left: 0,
                                        right: 10,
                                        bottom: 10),
                                    child: CircleAvatar(
                                      radius: h / 30,
                                      backgroundColor:
                                          Colors.grey, // Image radius
                                      backgroundImage: const AssetImage(
                                          'assets/doctor-pic.png'),
                                    ),
                                  ),
                                  // Image(
                                  //     height: h / 46,
                                  //     image:
                                  //         const AssetImage('assets/info.png')),
                                  const SizedBox(width: 10),

                                  Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('User guides',
                                            style: TextStyle(
                                              fontSize: w / 30,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            )),
                                        SizedBox(height: 5),
                                        Text('Online',
                                            style: TextStyle(
                                              fontSize: w / 40,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            )),
                                      ])
                                ],
                              ),

                              //   ],
                              // )
                            ],
                          )),
                    ),
                   const SizedBox(
                      height: 100,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    )
        // );

        );
  }

  Widget _buildAvatar() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        color: Colors.white,
        width: 150,
        height: 116,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    ClipOval(
                      child: Material(
                        color: Colors.grey, // Button color
                        child: InkWell(
                          splashColor: Colors.black, // Splash color
                          onTap: () {
                            popUpControler.hideMenu();
                            Navigator.pushNamed(
                                context, RoutePaths.doctorProfileScreen);
                          },
                          child: Container(
                              margin: EdgeInsets.all(10),
                              width: 20,
                              height: 20,
                              child: const Image(
                                color: Color.fromARGB(255, 62, 62, 62),
                                image: AssetImage('assets/profile.png'),
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 2),

                TextButton(
                  onPressed: () {
                    popUpControler.hideMenu();
                    Navigator.pushNamed(
                        context, RoutePaths.doctorProfileScreen);
                  },
                  child: Text('Profile',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      )),
                ),

                //   ],
                // )
                // ],
                //  )
                //  ),
                // ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    ClipOval(
                      child: Material(
                        color: Colors.grey,
                        child: InkWell(
                          splashColor: Colors.black, // Splash color
                          onTap: () {
                            popUpControler.hideMenu();
                            Alert(
                              closeIcon: null,
                              style: const AlertStyle(),
                              context: context,
                              padding: const EdgeInsets.all(20),
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image(
                                    image: AssetImage("assets/alert.png"),
                                    width: 50,
                                    height: 50,
                                  ),
                                  SizedBox(height: 20),
                                  Text("LOG OUT",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center),
                                  SizedBox(height: 5),
                                  Text(
                                    "Are you sure you want to log out ?",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              buttons: [
                                DialogButton(
                                  margin: EdgeInsets.only(left: 20),
                                  color: Colors.red[500],
                                  radius: BorderRadius.circular(20),
                                  onPressed: () async {
                                    Navigator.of(context)
                                        .popUntil((route) => route.isFirst);
                                  },
                                  child: const Text(
                                    "Log out",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ),
                                DialogButton(
                                  margin: const EdgeInsets.only(
                                      right: 20, left: 10),
                                  color: Colors.grey[800],
                                  radius: BorderRadius.circular(20),
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text(
                                    "Cancel",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ),
                              ],
                            ).show();

                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute<void>(
                            //       builder: (context) =>
                            //           BookingAppointmentScreen()),
                            // );
                          },
                          child: Container(
                              margin: EdgeInsets.all(10),
                              width: 20,
                              height: 20,
                              child: const Image(
                                color: Color.fromARGB(255, 62, 62, 62),
                                image: AssetImage('assets/logout.png'),
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 2),

                TextButton(
                    onPressed: () {
                      popUpControler.hideMenu();
                      Alert(
                        onWillPopActive: false,
                        closeIcon: null,
                        style: AlertStyle(),
                        context: context,
                        padding: EdgeInsets.all(20),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image(
                              image: AssetImage("assets/alert.png"),
                              width: 50,
                              height: 50,
                            ),
                            SizedBox(height: 20),
                            Text("LOG OUT",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center),
                            SizedBox(height: 5),
                            Text(
                              "Are you sure you want to log out ?",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        buttons: [
                          DialogButton(
                            margin: EdgeInsets.only(left: 20),
                            color: Colors.red[500],
                            radius: BorderRadius.circular(20),
                            onPressed: () async {
                              Navigator.of(context)
                                  .popUntil((route) => route.isFirst);
                            },
                            child: Text(
                              "Log out",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                          DialogButton(
                            margin: EdgeInsets.only(right: 20, left: 10),
                            color: Colors.grey[800],
                            radius: BorderRadius.circular(20),
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              "Cancel",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ],
                      ).show();
                    },
                    child: Text('Logout',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ))),

                //   ],
                // )
                // ],
                //  )
                //  ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  showAlert(context_, title, msg, subMsg, Image icon) {
    AlertDialog alert = AlertDialog(
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black),
      ),
      content: Text(msg),
      actions: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.orange),
                  ),
                  onPressed: () => {
                        // Navigator.pop(context_),
                        Navigator.of(context).pop(),
                      },
                  child: Expanded(
                    child: Text(
                      'Ok',
                      style: TextStyle(color: Colors.black),
                    ),
                  )),
            ),
          ],
        )
      ],
    );

    showDialog(
        context: context,
        // barrierDismissible: false,
        builder: (context) {
          return alert;
        });
  }
}
