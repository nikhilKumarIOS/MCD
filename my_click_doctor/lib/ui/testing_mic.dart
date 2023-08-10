import 'dart:async';
import 'package:camera/camera.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_click_doctor/services/router.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

List<CameraDescription> _cameras;

class TestingMicScreen extends StatefulWidget {
  const TestingMicScreen(
    this.first, {
    Key key,
  }) : super(key: key);
  final first;

  @override
  State<TestingMicScreen> createState() => _TestingMicScreenPageState();
}

class _TestingMicScreenPageState extends State<TestingMicScreen> {
  final popUpControler = CustomPopupMenuController();
  bool widgetSelected = true;
  bool joinCallhideShow = false;
  bool userGuidesSelected = true;
  bool medicalSelected = false;
  String Ddata = "0";
  String Hdata = "0";
  String Mdata = "0";
  String Sdata = "0";

  CameraController controller;
  Future<void> _initializeControllerFuture;

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   final CameraController cameraController = controller;
  //   // App state changed before we got the chance to initialize.
  //   if (cameraController == null || !cameraController.value.isInitialized) {
  //     return;
  //   }
  //   if (state == AppLifecycleState.inactive) {
  //     // cameraController.dispose();
  //   } else if (state == AppLifecycleState.resumed) {
  //     // onNewCameraSelected(cameraController.description);
  //   }
  // }

  initCamera() async {
    controller.initialize().then((_) {
      print("ok");
    }).catchError((Object e) {
      print('User denied camera access.');
    });

    // controller = CameraController(firstCamera, ResolutionPreset.medium);
    // _initializeControllerFuture = controller.initialize();

    // print("ok");
  }

  @override
  void initState() {
    // initCamera();
    super.initState();

    controller = CameraController(widget.first, ResolutionPreset.medium);

    controller.initialize().then((_) {
      print("ok");
    }).catchError((Object e) {
      print('User denied camera access.');
    });

    Timer.periodic(
        Duration(seconds: 1),
        (v) => {
              setState(() {
                Hdata = DateFormat("HH").format(DateTime.now());
                Mdata = DateFormat("mm").format(DateTime.now());
                Sdata = DateFormat("ss").format(DateTime.now());
              })
            });
    // SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return SafeArea(
        child: WillPopScope(
      onWillPop: () async {
        // showAlert(
        //     context,
        //     '',
        //     'msg',
        //     'subMsg',
        //     Image(
        //         height: h / 56,
        //         width: w / 56,
        //         image: AssetImage('assets/cancel.png')));

        return false;
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(239, 239, 247, 248),
        body: SizedBox(
          height: h,
          width: w,
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 0),
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
                              Ink(
                                decoration: const ShapeDecoration(
                                    shape: CircleBorder(),
                                    color: Color.fromARGB(255, 204, 204, 204)),
                                child: IconButton(
                                  icon: const Icon(Icons.arrow_back),
                                  iconSize: h / 40,
                                  color: Colors.black,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
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
                                                              EdgeInsets.all(
                                                                  10),
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
                          padding: EdgeInsets.only(top: 20),
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
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('Countdown',
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
                            top: 20, left: 20, right: 20, bottom: 0),
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
                              setState(() {
                                if (userGuidesSelected == false) {
                                  userGuidesSelected = true;
                                } else if (userGuidesSelected == true) {
                                  userGuidesSelected = false;
                                }
                              });

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
                                    Image(
                                        height: h / 26,
                                        image: const AssetImage(
                                            'assets/m_icon_color.png')),
                                    const SizedBox(width: 10),
                                    Text('MedicalScan Kft.',
                                        style: TextStyle(
                                          fontSize: w / 30,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        )),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    (userGuidesSelected == true)
                                        ? Icon(
                                            Icons.keyboard_arrow_down,
                                            color: Colors.grey,
                                            size: h / 56.0,
                                          )
                                        : Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            color: Colors.grey,
                                            size: h / 56.0,
                                          )
                                  ],
                                )

                                //   ],
                                // )
                              ],
                            )),
                      ),
                      (userGuidesSelected == true)
                          ? Padding(
                              padding: EdgeInsets.all(20),
                              child: Container(
                                  height: h / 1.8,
                                  width: w,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: Colors.white,
                                  ),
                                  child: Container(
                                      margin: EdgeInsets.all(20),
                                      child: Column(
                                        children: [
                                          Text(
                                            'This session has not started yet. You will be redirected to the room once the session begins.',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w400,
                                              fontSize: h / 66,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Column(
                                                  children: [
                                                    Text(
                                                      '0',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: h / 16,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Days',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: h / 66,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      Hdata,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: h / 16,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Hours',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: h / 66,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      Mdata,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: h / 16,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Minutes',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: h / 66,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      Sdata,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: h / 16,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Seconds',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: h / 66,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ]),
                                          SizedBox(height: 20),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10,
                                                            left: 0,
                                                            right: 10,
                                                            bottom: 10),
                                                    child: CircleAvatar(
                                                      radius: h / 45,
                                                      backgroundColor: Colors
                                                          .grey, // Image radius
                                                      backgroundImage:
                                                          const AssetImage(
                                                              'assets/m_icon.png'),
                                                    ),
                                                  ),
                                                  // Image(
                                                  //     height: h / 46,
                                                  //     image:
                                                  //         const AssetImage('assets/info.png')),
                                                  const SizedBox(width: 5),

                                                  Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text('MedicalScan',
                                                            style: TextStyle(
                                                              fontSize: w / 30,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  Colors.black,
                                                            )),
                                                        SizedBox(height: 1),
                                                        Text(
                                                            'helpdesk@myclickdoctor.hu',
                                                            style: TextStyle(
                                                              fontSize: w / 30,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  Colors.grey,
                                                            )),
                                                      ]),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Container(
                                            width: w,
                                            height: h / 4.1,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.grey[200]),
                                            margin: EdgeInsets.all(2),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  '   Alex Albon - My Subject',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: h / 56,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Container(
                                                    margin: EdgeInsets.all(10),
                                                    child: Text(
                                                      'Do you have an issue? Ask Myclickdoctor Helpdesk between 08:00 am and 18:00 pm at helpdesk@myclickdoctor.hu or at phone No. +36 1 336 21 04',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: h / 66,
                                                      ),
                                                    )),
                                                Container(
                                                    margin: EdgeInsets.all(10),
                                                    child: Text(
                                                      'Tue Sep 13 2022 17:45:24 GMT+0530 (India Standard Time)',
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: h / 66,
                                                      ),
                                                    ))
                                              ],
                                            ),
                                          ),
                                        ],
                                      ))))
                          : SizedBox(),
                      (userGuidesSelected == true)
                          ? Padding(
                              padding: EdgeInsets.only(
                                  top: 20, left: 20, right: 20, bottom: 10),
                              child: Container(
                                  // height: h / 3,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white),
                                  child: Center(
                                    child: !controller.value.isInitialized
                                        ? Container(
                                            child: Text(
                                                "Camera is not initilized"))
                                        : CameraPreview(controller),
                                  )))
                          : SizedBox(),
                      SizedBox(
                        height: 100,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  showAlert(context_, title, msg, subMsg, Image icon) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    AlertDialog alert = AlertDialog(
      title: Center(
        child: Image(
          image: AssetImage('assets/cancel.png'),
          height: 40,
          width: 40,
        ),
      ),
      content: Container(
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                  color: Colors.black,
                  letterSpacing: 0.5,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      actions: [
        Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                  height: 20,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Color.fromARGB(255, 237, 43, 29),
                  ),
                  child: Center(
                    child: Text('yes',
                        style: TextStyle(
                          fontSize: w / 46,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        )),
                  )),
            ),
            SizedBox(
              width: 5,
            ),
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                    height: 20,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Color.fromARGB(216, 2, 7, 29),
                    ),
                    child: Center(
                      child: Text('Cancel',
                          style: TextStyle(
                            fontSize: w / 46,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          )),
                    )))
          ],
        ))
      ],
    );

    showDialog(
        context: context,
        // barrierDismissible: false,
        builder: (context) {
          return alert;
        });
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
                // Expanded(
                //   flex: 1,
                //   child:

                // ElevatedButton(
                //     style: ElevatedButton.styleFrom(
                //       elevation: 0.0,
                //       shadowColor: Colors.transparent,
                //       shape: const RoundedRectangleBorder(
                //           borderRadius: BorderRadius.all(Radius.circular(50))),
                //       minimumSize: const Size.fromHeight(60),
                //       primary: const Color.fromARGB(216, 2, 7, 29),
                //     ),
                //     onPressed: () async {
                //       // Navigator.push(
                //       //   context,
                //       //   MaterialPageRoute<void>(
                //       //       builder: (context) =>
                //       //           BookingAppointmentScreen()),
                //       // );

                //       // Navigator.
                //       // Navigator.pop(context);
                //     },
                //     child:

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                Row(
                  children: [
                    const SizedBox(
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
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute<void>(
                            //       builder: (context) =>
                            //           BookingAppointmentScreen()),
                            // );
                          },
                          child: Container(
                              margin: const EdgeInsets.all(10),
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
                  child: const Text('Profile',
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
                // Expanded(
                //   flex: 1,
                //   child:

                // ElevatedButton(
                //     style: ElevatedButton.styleFrom(
                //       elevation: 0.0,
                //       shadowColor: Colors.transparent,
                //       shape: const RoundedRectangleBorder(
                //           borderRadius: BorderRadius.all(Radius.circular(50))),
                //       minimumSize: const Size.fromHeight(60),
                //       primary: const Color.fromARGB(216, 2, 7, 29),
                //     ),
                //     onPressed: () async {
                //       // Navigator.push(
                //       //   context,
                //       //   MaterialPageRoute<void>(
                //       //       builder: (context) =>
                //       //           BookingAppointmentScreen()),
                //       // );

                //       // Navigator.
                //       // Navigator.pop(context);
                //     },
                //     child:

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                Row(
                  children: [
                    SizedBox(
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
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ),
                                DialogButton(
                                  margin: EdgeInsets.only(right: 20, left: 10),
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
}

class PopUpItemBody extends StatelessWidget {
  const PopUpItemBody({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const TextField(
            decoration: InputDecoration(
              hintText: 'New todo',
              border: InputBorder.none,
            ),
            cursorColor: Colors.white,
          ),
          const Divider(
            color: Colors.white,
            thickness: 0.2,
          ),
          const TextField(
            decoration: InputDecoration(
              hintText: 'Write a note',
              border: InputBorder.none,
            ),
            cursorColor: Colors.white,
            maxLines: 6,
          ),
          const Divider(
            color: Colors.white,
            thickness: 0.2,
          ),
          TextButton(
            onPressed: () {},
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
