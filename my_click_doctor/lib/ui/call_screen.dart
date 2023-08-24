import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:my_click_doctor/services/router.dart';

import 'package:my_click_doctor/tabbar_view.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'baseUI/baseUI.dart';
import 'basic_infomation.dart';
import 'doctor_profile.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({Key key}) : super(key: key);

  @override
  State<CallScreen> createState() => _CallScreenPageState();
}

class _CallScreenPageState extends State<CallScreen> {
  final popUpControler = CustomPopupMenuController();
  bool isSwitched = true;
  bool isSMSSwitched = true;
  bool isEmailSwitched = true;
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
            Column(
              children: [
                BaseUI(title: "Call", hideLogo: true),
                Flexible(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, left: 20, right: 20, bottom: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: SizedBox(
                                          width: w / 1.6,
                                          height: h / 16,
                                          child: DottedBorder(
                                              borderType: BorderType.RRect,
                                              radius: Radius.circular(10),
                                              dashPattern: [8, 8, 8, 8],
                                              color: Colors.grey,
                                              strokeWidth: 2,
                                              child: Card(
                                                elevation: 0.0,
                                                color: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    elevation: 0.0,
                                                    shadowColor:
                                                        Colors.transparent,
                                                    shape: const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10))),
                                                    minimumSize:
                                                        const Size.fromHeight(
                                                            60),
                                                    primary:
                                                        const Color.fromARGB(
                                                            239, 239, 247, 248),
                                                  ),
                                                  child: Container(
                                                    margin: EdgeInsets.all(10),
                                                    width: w / 2,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.upload_file,
                                                          color: Color.fromARGB(
                                                              216, 2, 7, 29),
                                                        ),
                                                        Text(
                                                            'UPLOAD \nDOCUMENT',
                                                            style: TextStyle(
                                                              fontSize: w / 44,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800,
                                                              color: Color
                                                                  .fromARGB(216,
                                                                      2, 7, 29),
                                                            ))
                                                      ],
                                                    ),
                                                  ),
                                                  onPressed: () async {
                                                    FilePickerResult result =
                                                        await FilePicker
                                                            .platform
                                                            .pickFiles(
                                                      type: FileType.custom,
                                                      allowedExtensions: [
                                                        'jpg',
                                                        'pdf',
                                                        'doc'
                                                      ],
                                                    );
                                                    // Navigator.push(
                                                    //   context,
                                                    //   MaterialPageRoute<void>(
                                                    //       builder: (context) => MyTabBar()),
                                                    // );
                                                    // Navigator.
                                                    // Navigator.pop(context);
                                                  },
                                                ),
                                              )))),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: h / 15,
                                        child: ElevatedButton(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              ImageIcon(AssetImage(
                                                  'assets/file-upload1.png')),
                                              Text("CHECK \nDOCUMENTS",
                                                  style: TextStyle(
                                                    fontSize: w / 44,
                                                    fontWeight: FontWeight.w800,
                                                    color: Colors.white,
                                                  )),
                                            ],
                                          ),
                                          onPressed: () {
                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute<void>(builder: (context) => SignUp()),
                                            // );
                                          },
                                          style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              primary: Color.fromARGB(216, 2, 7,
                                                  29), //Color.fromARGB(255, 0, 100, 181),
                                              textStyle: TextStyle(
                                                  fontSize: 2,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      )),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  top: 20, left: 20, right: 20, bottom: 100),
                              child: Container(
                                height: h / 1.5,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white),
                                child: Center(
                                  child: Text('Video Call Screen'),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
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
                                  child: Text(
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
