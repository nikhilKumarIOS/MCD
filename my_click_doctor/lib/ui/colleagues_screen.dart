import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:my_click_doctor/services/router.dart';

import 'package:my_click_doctor/tabbar_view.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'baseUI/baseUI.dart';
import 'basic_infomation.dart';
import 'booking_appointment.dart';
import 'doctor_profile.dart';

class ColleaguesScreen extends StatefulWidget {
  const ColleaguesScreen({Key key}) : super(key: key);

  @override
  State<ColleaguesScreen> createState() => _ColleaguesScreenPageState();
}

class _ColleaguesScreenPageState extends State<ColleaguesScreen> {
  final popUpControler = CustomPopupMenuController();
  bool widgetSelected = true;
  var selectedVal = null;
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
                BaseUI(title: "Colleagues", hideLogo: false),
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
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: TextField(
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 10.0,
                                        height: 1.0,
                                      ),

                                      // controller: _filter,
                                      onChanged: (value) {
                                        print(value);
                                        if (value != "") {
                                          setState(() {
                                            // isSearch = true;
                                            // searchString = value.toLowerCase();
                                          });
                                        } else {
                                          setState(() {
                                            // isSearch = false;
                                          });
                                        }
                                      },
                                      decoration: InputDecoration(
                                        hintText: 'Search...',
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: h / 100,
                                          // fontWeight: FontWeight.w500,
                                        ),
                                        ////search design
                                        suffixIcon: const Icon(
                                          Icons.search_rounded,
                                          color: Colors.grey,
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        fillColor: Colors.white,
                                        filled: true,
                                        // border: OutlineInputBorder(
                                        //   borderRadius: BorderRadius.circular(20.0),
                                        //   borderSide: BorderSide.none,
                                        // ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                        height: h / 18,
                                        width: w,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Container(
                                          width: w,
                                          margin:
                                              const EdgeInsets.only(left: 10),
                                          child: DropdownButton<String>(
                                            hint: const Text(
                                              'Select specialization',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 10,
                                                  decoration:
                                                      TextDecoration.none),
                                            ),
                                            isExpanded: true,
                                            value: selectedVal,
                                            underline: const SizedBox(),
                                            items: <String>[
                                              'Cardiologist',
                                              'Dentist',
                                              'Gynaecologist',
                                            ].map((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(
                                                  value,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 10,
                                                      decoration:
                                                          TextDecoration.none),
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (_) {
                                              setState(() {
                                                selectedVal = _;
                                              });
                                            },
                                          ),
                                        )),
                                  )
                                ],
                              )),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 20),
                            child: Row(
                              children: [
                                //  Expanded(
                                //    flex: 1,
                                //child:
                                Container(
                                  width: w / 2.3,
                                  height: h / 3.5,
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: CircleAvatar(
                                          radius: h / 20,
                                          backgroundColor:
                                              Colors.white, // Image radius
                                          backgroundImage: const AssetImage(
                                              'assets/doctor-pic.png'),
                                        ),
                                      ),
                                      Text(
                                        'Dr. William',
                                        style: TextStyle(
                                            fontSize: h / 68,
                                            fontWeight: FontWeight.w800),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Speciality:',
                                        style: TextStyle(
                                          fontSize: h / 88,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Text(
                                        'Cardiologist, Diabetologist',
                                        style: TextStyle(
                                            fontSize: h / 88,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Row(
                                          children: [
                                            // Expanded(

                                            //   child:
                                            Container(
                                              height: h / 30,
                                              child: ElevatedButton(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                        height: h / 40,
                                                        width: w / 20,
                                                        decoration: BoxDecoration(
                                                            color: Colors
                                                                .grey[800],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(2),
                                                          child: ImageIcon(
                                                            AssetImage(
                                                                'assets/profile-2.png'),
                                                            color: Colors.white,
                                                            size: h / 96,
                                                          ),
                                                        )),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      "PROFILE",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        //letterSpacing: 1.5,
                                                        fontSize: h / 150,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                onPressed: () {
                                                  Navigator.pushNamed(
                                                      context,
                                                      RoutePaths
                                                          .doctorProfileScreen);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                    primary: Color.fromARGB(
                                                        216,
                                                        2,
                                                        7,
                                                        29), //Color.fromARGB(255, 0, 100, 181),
                                                    textStyle: TextStyle(
                                                        fontSize: 2,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                            ),

                                            // ),

                                            SizedBox(width: 5),
                                            // Expanded(
                                            //  child:

                                            Container(
                                              height: h / 30,
                                              child: ElevatedButton(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                        height: h / 40,
                                                        width: w / 20,
                                                        decoration: BoxDecoration(
                                                            color: Colors
                                                                .grey[800],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(2),
                                                          child: ImageIcon(
                                                            AssetImage(
                                                                'assets/chat-1.png'),
                                                            color: Colors.white,
                                                            size: h / 96,
                                                          ),
                                                        )),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      "CHAT     ",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        //letterSpacing: 1.5,
                                                        fontSize: h / 150,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                onPressed: () {
                                                  Navigator.pushNamed(
                                                      context,
                                                      RoutePaths
                                                          .chatLiveScreen);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                    primary: Color.fromARGB(
                                                        216,
                                                        2,
                                                        7,
                                                        29), //Color.fromARGB(255, 0, 100, 181),
                                                    textStyle: TextStyle(
                                                        fontSize: 2,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                            ),

                                            // ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: 5, right: 5),
                                        child:

                                            //   Expanded(
                                            //     child:

                                            Container(
                                          height: h / 30,
                                          child: ElevatedButton(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                    height: h / 40,
                                                    width: w / 20,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Colors.green[200],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(2),
                                                      child: ImageIcon(
                                                        AssetImage(
                                                            'assets/calendar-dark-green.png'),
                                                        color:
                                                            Colors.green[800],
                                                        size: h / 86,
                                                      ),
                                                    )),
                                                Text(
                                                  "BOOK APPOINTMENT",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    //letterSpacing: 1.5,
                                                    fontSize: h / 150,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: w / 30,
                                                )
                                              ],
                                            ),
                                            onPressed: () {
                                              Alert(
                                                closeIcon: null,
                                                style: AlertStyle(),
                                                context: context,
                                                padding: EdgeInsets.all(20),
                                                content: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Image(
                                                      image: AssetImage(
                                                          "assets/cancel.png"),
                                                      width: 50,
                                                      height: 50,
                                                    ),
                                                    SizedBox(height: 20),
                                                    Text("BOOK APPOINTMENT",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center),
                                                    SizedBox(height: 5),
                                                    Text(
                                                      "Are you sure you want to book this appointment",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                buttons: [
                                                  DialogButton(
                                                    margin: EdgeInsets.only(
                                                        left: 20),
                                                    color: Colors.red[500],
                                                    radius:
                                                        BorderRadius.circular(
                                                            20),
                                                    onPressed: () async {
                                                      Alert(
                                                        closeIcon: null,
                                                        style: AlertStyle(),
                                                        context: context,
                                                        padding:
                                                            EdgeInsets.all(20),
                                                        content: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Image(
                                                              image: AssetImage(
                                                                  "assets/check.png"),
                                                              width: 50,
                                                              height: 50,
                                                            ),
                                                            SizedBox(
                                                                height: 20),
                                                            Text(
                                                                "SUCCESSFULLY BOOKED",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center),
                                                            SizedBox(height: 5),
                                                            Text(
                                                              "Booked appointment will show in your dashboard",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        buttons: [
                                                          DialogButton(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 20,
                                                                    left: 10),
                                                            color: Colors
                                                                .grey[800],
                                                            radius: BorderRadius
                                                                .circular(20),
                                                            onPressed:
                                                                () async {
                                                              Navigator.pop(
                                                                  context);
                                                              await Navigator
                                                                  .pushReplacementNamed(
                                                                      context,
                                                                      RoutePaths
                                                                          .myTabBar);
                                                            },
                                                            child: const Text(
                                                              "GO BACK DASHBOARD",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 16),
                                                            ),
                                                          ),
                                                        ],
                                                      ).show();
                                                    },
                                                    child: Text(
                                                      "Yes",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16),
                                                    ),
                                                  ),
                                                  DialogButton(
                                                    margin: EdgeInsets.only(
                                                        right: 20, left: 10),
                                                    color: Colors.grey[800],
                                                    radius:
                                                        BorderRadius.circular(
                                                            20),
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                    child: Text(
                                                      "Cancel",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16),
                                                    ),
                                                  ),
                                                ],
                                              ).show();
                                            },
                                            style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                primary: Color.fromARGB(
                                                    159,
                                                    114,
                                                    190,
                                                    21), //Color.fromARGB(255, 0, 100, 181),
                                                textStyle: TextStyle(
                                                    fontSize: 2,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                        ),
                                        //),
                                      )
                                    ],
                                  ),
                                )
                                //)
                                ,
                                const SizedBox(width: 10),
                                //    Expanded(
                                //    flex: 1,
                                // child:
                                Container(
                                  width: w / 2.3,
                                  height: h / 3.5,
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: CircleAvatar(
                                          radius: h / 20,
                                          backgroundColor:
                                              Colors.white, // Image radius
                                          backgroundImage: const AssetImage(
                                              'assets/doctor-pic.png'),
                                        ),
                                      ),
                                      Text(
                                        'Dr. William',
                                        style: TextStyle(
                                            fontSize: h / 68,
                                            fontWeight: FontWeight.w800),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Speciality:',
                                        style: TextStyle(
                                          fontSize: h / 88,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Text(
                                        'Cardiologist, Diabetologist',
                                        style: TextStyle(
                                            fontSize: h / 88,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Row(
                                          children: [
                                            //   Expanded(
                                            //     child:

                                            Container(
                                              height: h / 30,
                                              child: ElevatedButton(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                        height: h / 40,
                                                        width: w / 20,
                                                        decoration: BoxDecoration(
                                                            color: Colors
                                                                .grey[800],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(2),
                                                          child: ImageIcon(
                                                            AssetImage(
                                                                'assets/profile-2.png'),
                                                            color: Colors.white,
                                                            size: h / 96,
                                                          ),
                                                        )),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      "PROFILE",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        //letterSpacing: 1.5,
                                                        fontSize: h / 150,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                onPressed: () {
                                                  Navigator.pushNamed(
                                                      context,
                                                      RoutePaths
                                                          .doctorProfileScreen);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                    primary: Color.fromARGB(
                                                        216,
                                                        2,
                                                        7,
                                                        29), //Color.fromARGB(255, 0, 100, 181),
                                                    textStyle: TextStyle(
                                                        fontSize: 2,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                            ),
                                            //),
                                            SizedBox(width: 5),
                                            //  Expanded(
                                            //    child:

                                            Container(
                                              height: h / 30,
                                              child: ElevatedButton(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                        height: h / 40,
                                                        width: w / 20,
                                                        decoration: BoxDecoration(
                                                            color: Colors
                                                                .grey[800],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(2),
                                                          child: ImageIcon(
                                                            AssetImage(
                                                                'assets/chat-1.png'),
                                                            color: Colors.white,
                                                            size: h / 96,
                                                          ),
                                                        )),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      "CHAT     ",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        //letterSpacing: 1.5,
                                                        fontSize: h / 150,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                onPressed: () {
                                                  Navigator.pushNamed(
                                                      context,
                                                      RoutePaths
                                                          .chatLiveScreen);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                    primary: Color.fromARGB(
                                                        216,
                                                        2,
                                                        7,
                                                        29), //Color.fromARGB(255, 0, 100, 181),
                                                    textStyle: TextStyle(
                                                        fontSize: 2,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                            ),
                                            //),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: 5, right: 5),
                                        child:

                                            //  Expanded(
                                            //    child:
                                            Container(
                                          height: h / 30,
                                          child: ElevatedButton(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                    height: h / 40,
                                                    width: w / 20,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Colors.green[200],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(2),
                                                      child: ImageIcon(
                                                        AssetImage(
                                                            'assets/calendar-dark-green.png'),
                                                        color:
                                                            Colors.green[800],
                                                        size: h / 86,
                                                      ),
                                                    )),
                                                Text(
                                                  "BOOK APPOINTMENT",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    //letterSpacing: 1.5,
                                                    fontSize: h / 150,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: w / 30,
                                                )
                                              ],
                                            ),
                                            onPressed: () {
                                              Alert(
                                                closeIcon: null,
                                                style: AlertStyle(),
                                                context: context,
                                                padding: EdgeInsets.all(20),
                                                content: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Image(
                                                      image: AssetImage(
                                                          "assets/cancel.png"),
                                                      width: 50,
                                                      height: 50,
                                                    ),
                                                    SizedBox(height: 20),
                                                    Text("BOOK APPOINTMENT",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center),
                                                    SizedBox(height: 5),
                                                    Text(
                                                      "Are you sure you want to book this appointment",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                buttons: [
                                                  DialogButton(
                                                    margin: EdgeInsets.only(
                                                        left: 20),
                                                    color: Colors.red[500],
                                                    radius:
                                                        BorderRadius.circular(
                                                            20),
                                                    onPressed: () async {
                                                      Navigator.pop(context);
                                                      Alert(
                                                        closeIcon: null,
                                                        style: AlertStyle(),
                                                        context: context,
                                                        padding:
                                                            EdgeInsets.all(20),
                                                        content: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Image(
                                                              image: AssetImage(
                                                                  "assets/check.png"),
                                                              width: 50,
                                                              height: 50,
                                                            ),
                                                            SizedBox(
                                                                height: 20),
                                                            Text(
                                                                "SUCCESSFULLY BOOKED",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center),
                                                            SizedBox(height: 5),
                                                            Text(
                                                              "Booked appointment will show in your dashboard",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        buttons: [
                                                          DialogButton(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 20,
                                                                    left: 10),
                                                            color: Colors
                                                                .grey[800],
                                                            radius: BorderRadius
                                                                .circular(20),
                                                            onPressed:
                                                                () async {
                                                              Navigator.pop(
                                                                  context);
                                                              await Navigator
                                                                  .pushReplacementNamed(
                                                                      context,
                                                                      RoutePaths
                                                                          .myTabBar);
                                                            },
                                                            child: const Text(
                                                              "GO BACK DASHBOARD",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 16),
                                                            ),
                                                          ),
                                                        ],
                                                      ).show();
                                                    },
                                                    child: Text(
                                                      "Yes",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16),
                                                    ),
                                                  ),
                                                  DialogButton(
                                                    margin: EdgeInsets.only(
                                                        right: 20, left: 10),
                                                    color: Colors.grey[800],
                                                    radius:
                                                        BorderRadius.circular(
                                                            20),
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                    child: Text(
                                                      "Cancel",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16),
                                                    ),
                                                  ),
                                                ],
                                              ).show();
                                            },
                                            style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                primary: Color.fromARGB(
                                                    159,
                                                    114,
                                                    190,
                                                    21), //Color.fromARGB(255, 0, 100, 181),
                                                textStyle: TextStyle(
                                                    fontSize: 2,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                        ),
                                        //),
                                      )
                                    ],
                                  ),
                                )
                                // ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 20),
                            child: Row(
                              children: [
                                //  Expanded(
                                //    flex: 1,
                                //child:
                                Container(
                                  width: w / 2.3,
                                  height: h / 3.5,
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: CircleAvatar(
                                          radius: h / 20,
                                          backgroundColor:
                                              Colors.white, // Image radius
                                          backgroundImage: const AssetImage(
                                              'assets/doctor-pic.png'),
                                        ),
                                      ),
                                      Text(
                                        'Dr. William',
                                        style: TextStyle(
                                            fontSize: h / 68,
                                            fontWeight: FontWeight.w800),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Speciality:',
                                        style: TextStyle(
                                          fontSize: h / 88,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Text(
                                        'Cardiologist, Diabetologist',
                                        style: TextStyle(
                                            fontSize: h / 88,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Row(
                                          children: [
                                            //   Expanded(
                                            //     child:

                                            Container(
                                              height: h / 30,
                                              child: ElevatedButton(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                        height: h / 40,
                                                        width: w / 20,
                                                        decoration: BoxDecoration(
                                                            color: Colors
                                                                .grey[800],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(2),
                                                          child: ImageIcon(
                                                            AssetImage(
                                                                'assets/profile-2.png'),
                                                            color: Colors.white,
                                                            size: h / 96,
                                                          ),
                                                        )),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      "PROFILE",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        //letterSpacing: 1.5,
                                                        fontSize: h / 150,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                onPressed: () {
                                                  Navigator.pushNamed(
                                                      context,
                                                      RoutePaths
                                                          .doctorProfileScreen);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                    primary: Color.fromARGB(
                                                        216,
                                                        2,
                                                        7,
                                                        29), //Color.fromARGB(255, 0, 100, 181),
                                                    textStyle: TextStyle(
                                                        fontSize: 2,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                            ),
                                            //),
                                            SizedBox(width: 5),
                                            //  Expanded(
                                            //    child:

                                            Container(
                                              height: h / 30,
                                              child: ElevatedButton(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                        height: h / 40,
                                                        width: w / 20,
                                                        decoration: BoxDecoration(
                                                            color: Colors
                                                                .grey[800],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(2),
                                                          child: ImageIcon(
                                                            AssetImage(
                                                                'assets/chat-1.png'),
                                                            color: Colors.white,
                                                            size: h / 96,
                                                          ),
                                                        )),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      "CHAT     ",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        //letterSpacing: 1.5,
                                                        fontSize: h / 150,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                onPressed: () {
                                                  Navigator.pushNamed(
                                                      context,
                                                      RoutePaths
                                                          .chatLiveScreen);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                    backgroundColor: const Color
                                                            .fromARGB(216, 2, 7,
                                                        29), //Color.fromARGB(255, 0, 100, 181),
                                                    textStyle: TextStyle(
                                                        fontSize: 2,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                            ),
                                            //),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: 5, right: 5),
                                        child:

                                            //  Expanded(
                                            //    child:
                                            Container(
                                          height: h / 30,
                                          child: ElevatedButton(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                    height: h / 40,
                                                    width: w / 20,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Colors.green[200],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(2),
                                                      child: ImageIcon(
                                                        AssetImage(
                                                            'assets/calendar-dark-green.png'),
                                                        color:
                                                            Colors.green[800],
                                                        size: h / 86,
                                                      ),
                                                    )),
                                                Text(
                                                  "BOOK APPOINTMENT",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    //letterSpacing: 1.5,
                                                    fontSize: h / 150,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: w / 30,
                                                )
                                              ],
                                            ),
                                            onPressed: () {
                                              Alert(
                                                closeIcon: null,
                                                style: AlertStyle(),
                                                context: context,
                                                padding: EdgeInsets.all(20),
                                                content: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Image(
                                                      image: AssetImage(
                                                          "assets/cancel.png"),
                                                      width: 50,
                                                      height: 50,
                                                    ),
                                                    SizedBox(height: 20),
                                                    Text("BOOK APPOINTMENT",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center),
                                                    SizedBox(height: 5),
                                                    Text(
                                                      "Are you sure you want to book this appointment",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                buttons: [
                                                  DialogButton(
                                                    margin: EdgeInsets.only(
                                                        left: 20),
                                                    color: Colors.red[500],
                                                    radius:
                                                        BorderRadius.circular(
                                                            20),
                                                    onPressed: () async {
                                                      Alert(
                                                        closeIcon: null,
                                                        style: AlertStyle(),
                                                        context: context,
                                                        padding:
                                                            EdgeInsets.all(20),
                                                        content: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: const <
                                                              Widget>[
                                                            Image(
                                                              image: AssetImage(
                                                                  "assets/check.png"),
                                                              width: 50,
                                                              height: 50,
                                                            ),
                                                            SizedBox(
                                                                height: 20),
                                                            Text(
                                                                "SUCCESSFULLY BOOKED",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center),
                                                            SizedBox(height: 5),
                                                            Text(
                                                              "Booked appointment will show in your dashboard",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        buttons: [
                                                          DialogButton(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 20,
                                                                    left: 10),
                                                            color: Colors
                                                                .grey[800],
                                                            radius: BorderRadius
                                                                .circular(20),
                                                            onPressed:
                                                                () async {
                                                              Navigator.pop(
                                                                  context);
                                                              await Navigator
                                                                  .pushReplacementNamed(
                                                                      context,
                                                                      RoutePaths
                                                                          .myTabBar);
                                                            },
                                                            child: const Text(
                                                              "GO BACK DASHBOARD",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 16),
                                                            ),
                                                          ),
                                                        ],
                                                      ).show();
                                                    },
                                                    child: Text(
                                                      "Yes",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16),
                                                    ),
                                                  ),
                                                  DialogButton(
                                                    margin: EdgeInsets.only(
                                                        right: 20, left: 10),
                                                    color: Colors.grey[800],
                                                    radius:
                                                        BorderRadius.circular(
                                                            20),
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                    child: Text(
                                                      "Cancel",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16),
                                                    ),
                                                  ),
                                                ],
                                              ).show();
                                            },
                                            style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                primary: Color.fromARGB(
                                                    159,
                                                    114,
                                                    190,
                                                    21), //Color.fromARGB(255, 0, 100, 181),
                                                textStyle: TextStyle(
                                                    fontSize: 2,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                        ),
                                        //),
                                      )
                                    ],
                                  ),
                                )
                                //)
                                ,
                                const SizedBox(width: 10),
                                //    Expanded(
                                //    flex: 1,
                                // child:
                                Container(
                                  width: w / 2.3,
                                  height: h / 3.5,
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: CircleAvatar(
                                          radius: h / 20,
                                          backgroundColor:
                                              Colors.white, // Image radius
                                          backgroundImage: const AssetImage(
                                              'assets/doctor-pic.png'),
                                        ),
                                      ),
                                      Text(
                                        'Dr. William',
                                        style: TextStyle(
                                            fontSize: h / 68,
                                            fontWeight: FontWeight.w800),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Speciality:',
                                        style: TextStyle(
                                          fontSize: h / 88,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Text(
                                        'Cardiologist, Diabetologist',
                                        style: TextStyle(
                                            fontSize: h / 88,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Row(
                                          children: [
                                            //   Expanded(
                                            //     child:

                                            Container(
                                              height: h / 30,
                                              child: ElevatedButton(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                        height: h / 40,
                                                        width: w / 20,
                                                        decoration: BoxDecoration(
                                                            color: Colors
                                                                .grey[800],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(2),
                                                          child: ImageIcon(
                                                            AssetImage(
                                                                'assets/profile-2.png'),
                                                            color: Colors.white,
                                                            size: h / 96,
                                                          ),
                                                        )),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      "PROFILE",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        //letterSpacing: 1.5,
                                                        fontSize: h / 150,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                onPressed: () {
                                                  Navigator.pushNamed(
                                                      context,
                                                      RoutePaths
                                                          .doctorProfileScreen);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                    backgroundColor: const Color
                                                            .fromARGB(216, 2, 7,
                                                        29), //Color.fromARGB(255, 0, 100, 181),
                                                    textStyle: const TextStyle(
                                                        fontSize: 2,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                            ),
                                            //),
                                            SizedBox(width: 5),
                                            //  Expanded(
                                            //    child:

                                            Container(
                                              height: h / 30,
                                              child: ElevatedButton(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                        height: h / 40,
                                                        width: w / 20,
                                                        decoration: BoxDecoration(
                                                            color: Colors
                                                                .grey[800],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(2),
                                                          child: ImageIcon(
                                                            AssetImage(
                                                                'assets/chat-1.png'),
                                                            color: Colors.white,
                                                            size: h / 96,
                                                          ),
                                                        )),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      "CHAT     ",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        //letterSpacing: 1.5,
                                                        fontSize: h / 150,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                onPressed: () {
                                                  Navigator.pushNamed(
                                                      context,
                                                      RoutePaths
                                                          .chatLiveScreen);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                    backgroundColor: const Color
                                                            .fromARGB(216, 2, 7,
                                                        29), //Color.fromARGB(255, 0, 100, 181),
                                                    textStyle: const TextStyle(
                                                        fontSize: 2,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                            ),
                                            //),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: 5, right: 5),
                                        child:

                                            //  Expanded(
                                            //    child:
                                            Container(
                                          height: h / 30,
                                          child: ElevatedButton(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                    height: h / 40,
                                                    width: w / 20,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Colors.green[200],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(2),
                                                      child: ImageIcon(
                                                        AssetImage(
                                                            'assets/calendar-dark-green.png'),
                                                        color:
                                                            Colors.green[800],
                                                        size: h / 86,
                                                      ),
                                                    )),
                                                Text(
                                                  "BOOK APPOINTMENT",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    //letterSpacing: 1.5,
                                                    fontSize: h / 150,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: w / 30,
                                                )
                                              ],
                                            ),
                                            onPressed: () {
                                              Alert(
                                                closeIcon: null,
                                                style: AlertStyle(),
                                                context: context,
                                                padding: EdgeInsets.all(20),
                                                content: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Image(
                                                      image: AssetImage(
                                                          "assets/cancel.png"),
                                                      width: 50,
                                                      height: 50,
                                                    ),
                                                    SizedBox(height: 20),
                                                    Text("BOOK APPOINTMENT",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center),
                                                    SizedBox(height: 5),
                                                    Text(
                                                      "Are you sure you want to book this appointment",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                buttons: [
                                                  DialogButton(
                                                    margin: EdgeInsets.only(
                                                        left: 20),
                                                    color: Colors.red[500],
                                                    radius:
                                                        BorderRadius.circular(
                                                            20),
                                                    onPressed: () async {
                                                      Alert(
                                                        closeIcon: null,
                                                        style: AlertStyle(),
                                                        context: context,
                                                        padding:
                                                            EdgeInsets.all(20),
                                                        content: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: const <
                                                              Widget>[
                                                            Image(
                                                              image: AssetImage(
                                                                  "assets/check.png"),
                                                              width: 50,
                                                              height: 50,
                                                            ),
                                                            SizedBox(
                                                                height: 20),
                                                            Text(
                                                                "SUCCESSFULLY BOOKED",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center),
                                                            SizedBox(height: 5),
                                                            Text(
                                                              "Booked appointment will show in your dashboard",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        buttons: [
                                                          DialogButton(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 20,
                                                                    left: 10),
                                                            color: Colors
                                                                .grey[800],
                                                            radius: BorderRadius
                                                                .circular(20),
                                                            onPressed:
                                                                () async {
                                                              Navigator.pop(
                                                                  context);
                                                              await Navigator
                                                                  .pushReplacementNamed(
                                                                      context,
                                                                      RoutePaths
                                                                          .myTabBar);
                                                            },
                                                            child: const Text(
                                                              "GO BACK DASHBOARD",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 16),
                                                            ),
                                                          ),
                                                        ],
                                                      ).show();
                                                    },
                                                    child: Text(
                                                      "Yes",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16),
                                                    ),
                                                  ),
                                                  DialogButton(
                                                    margin: EdgeInsets.only(
                                                        right: 20, left: 10),
                                                    color: Colors.grey[800],
                                                    radius:
                                                        BorderRadius.circular(
                                                            20),
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                    child: Text(
                                                      "Cancel",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16),
                                                    ),
                                                  ),
                                                ],
                                              ).show();
                                            },
                                            style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                primary: Color.fromARGB(
                                                    159,
                                                    114,
                                                    190,
                                                    21), //Color.fromARGB(255, 0, 100, 181),
                                                textStyle: TextStyle(
                                                    fontSize: 2,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                        ),
                                        //),
                                      )
                                    ],
                                  ),
                                )
                                // ),
                              ],
                            ),
                          ),
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
            const SizedBox(
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
            const SizedBox(
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
                                children: const <Widget>[
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
                                  margin: const EdgeInsets.only(left: 20),
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
                          },
                          child: Container(
                              margin: const EdgeInsets.all(10),
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
