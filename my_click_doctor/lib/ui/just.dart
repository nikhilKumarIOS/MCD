import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:my_click_doctor/services/router.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../constants/LocalImages.dart';

class BookingAppointmentScreen extends StatefulWidget {
  const BookingAppointmentScreen({Key key}) : super(key: key);

  @override
  State<BookingAppointmentScreen> createState() =>
      _BookingAppointmentScreenPageState();
}

class _BookingAppointmentScreenPageState
    extends State<BookingAppointmentScreen> {
  final popUpControler = CustomPopupMenuController();
  bool isSwitched = true;
  bool widgetSelected = true;
  var selectedVal = null;
  var selectedValMin = null;
  var profileImage = "";
  String _date = "";
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
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                  padding: EdgeInsets.only(left: 00),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Ink(
                              decoration: const ShapeDecoration(
                                  shape: CircleBorder(),
                                  color: Color.fromARGB(255, 204, 204, 204)),
                              child: IconButton(
                                icon: const Icon(Icons.arrow_back),
                                iconSize: h / 40,
                                color: Colors.black,
                                onPressed: () async {
                                  Navigator.pop(context);
                                  await Navigator.pushNamed(
                                      context, RoutePaths.myTabBar);
                                },
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              const SizedBox(
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
                                                          const EdgeInsets.all(
                                                              10),
                                                      width: h / 46,
                                                      height: h / 46,
                                                      child: const Image(
                                                          image: AssetImage(
                                                              LocalImages
                                                                  .questionSign))),
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
                                                image: const AssetImage(
                                                    LocalImages.femaleUser),
                                              ),
                                              menuBuilder: () =>
                                                  GestureDetector(
                                                child: _buildAvatar(),
                                              ),
                                              barrierColor: Colors.transparent,
                                              pressType: PressType.singleClick,
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
                      ),
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
                                    Text('Book Appointment',
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
                          padding: EdgeInsets.all(10),
                          child: SingleChildScrollView(
                              child: Container(
                                  height: h / 1.4,
                                  // color: Colors.red,
                                  child: Column(
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.all(20),
                                          child: Container(
                                            height: h / 7,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.white,
                                            ),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 10,
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
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      'From *',
                                                      style: TextStyle(
                                                          fontSize: w / 30,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        DatePicker
                                                            .showDateTimePicker(
                                                                context,
                                                                theme:
                                                                    DatePickerTheme(
                                                                  containerHeight:
                                                                      210.0,
                                                                ),
                                                                showTitleActions:
                                                                    true,
                                                                minTime:
                                                                    DateTime(
                                                                        1900,
                                                                        1,
                                                                        1),
                                                                maxTime:
                                                                    DateTime
                                                                        .now(),
                                                                onConfirm:
                                                                    (date) {
                                                          print(
                                                              'confirm $date');
                                                          _date =
                                                              "${date.day}/${date.month}/${date.year}"
                                                              " ${date.hour} : ${date.minute}";
                                                          setState(() {});
                                                        },
                                                                currentTime:
                                                                    DateTime
                                                                        .now(),
                                                                locale:
                                                                    LocaleType
                                                                        .en);
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        shape: const RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10))),
                                                        minimumSize: const Size
                                                            .fromHeight(55),
                                                        elevation: 0.0,
                                                        backgroundColor:
                                                            const Color
                                                                    .fromARGB(
                                                                239,
                                                                239,
                                                                247,
                                                                248),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            _date,
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14,
                                                                decoration:
                                                                    TextDecoration
                                                                        .none),
                                                          ),
                                                          const Icon(
                                                            Icons
                                                                .watch_later_outlined,
                                                            color: Colors.grey,
                                                          )
                                                        ],
                                                      ),
                                                    )),
                                              ],
                                            ),
                                          )),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: 20, right: 20, bottom: 20),
                                          child: Container(
                                            height: h / 7,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.white,
                                            ),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 10,
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
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      'Select Type *',
                                                      style: TextStyle(
                                                          fontSize: w / 30,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(10),
                                                  child: Container(
                                                      height: h / 14,
                                                      width: w,
                                                      decoration: BoxDecoration(
                                                        color: Color.fromARGB(
                                                            239, 239, 247, 248),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                      ),
                                                      child: Container(
                                                        width: w,
                                                        margin: EdgeInsets.only(
                                                            left: 10),
                                                        child: DropdownButton<
                                                            String>(
                                                          hint: const Text(
                                                            'Select specialization',
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 10,
                                                                decoration:
                                                                    TextDecoration
                                                                        .none),
                                                          ),
                                                          isExpanded: true,
                                                          value: selectedVal,
                                                          underline: SizedBox(),
                                                          items: <String>[
                                                            'Cardiologist',
                                                            'Dentist',
                                                            'Gynaecologist',
                                                          ].map((String value) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: value,
                                                              child: Text(
                                                                value,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        14,
                                                                    decoration:
                                                                        TextDecoration
                                                                            .none),
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
                                                ),
                                              ],
                                            ),
                                          )),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: 20, right: 20, bottom: 20),
                                          child: Container(
                                            height: h / 7,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.white,
                                            ),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 10,
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
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      'Max No. of Attendees *',
                                                      style: TextStyle(
                                                          fontSize: w / 30,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(10),
                                                  child: TextFormField(

                                                      // controller: nameController,
                                                      // obscureText: isMail,
                                                      style: TextStyle(
                                                          color: Colors.grey),
                                                      decoration:
                                                          InputDecoration(

                                                              // hintText: 'Enter Email',

                                                              // hintStyle: TextStyle( color: Colors.white),

                                                              suffixIcon: Icon(
                                                                Icons.group,
                                                              ),
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15),
                                                                borderSide:
                                                                    BorderSide
                                                                        .none,
                                                              ),
                                                              fillColor: Color
                                                                  .fromARGB(
                                                                      239,
                                                                      239,
                                                                      247,
                                                                      248),
                                                              filled: true)),
                                                ),
                                              ],
                                            ),
                                          )),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: 20, right: 20, bottom: 20),
                                          child: Container(
                                            height: h / 7,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.white,
                                            ),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 10,
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
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      'Subject *',
                                                      style: TextStyle(
                                                          fontSize: w / 30,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(10),
                                                  child: TextFormField(

                                                      // controller: nameController,
                                                      // obscureText: isMail,
                                                      style: TextStyle(
                                                          color: Colors.grey),
                                                      decoration:
                                                          InputDecoration(

                                                              // hintText: 'Enter Email',

                                                              // hintStyle: TextStyle( color: Colors.white),

                                                              suffixIcon: Icon(
                                                                Icons
                                                                    .menu_book_outlined,
                                                              ),
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15),
                                                                borderSide:
                                                                    BorderSide
                                                                        .none,
                                                              ),
                                                              fillColor: Color
                                                                  .fromARGB(
                                                                      239,
                                                                      239,
                                                                      247,
                                                                      248),
                                                              filled: true)),
                                                ),
                                              ],
                                            ),
                                          )),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: 20, right: 20, bottom: 20),
                                          child: Container(
                                            height: h / 7,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.white,
                                            ),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 10,
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
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      'Doctor',
                                                      style: TextStyle(
                                                          fontSize: w / 30,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.all(10),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Switch(
                                                          value: isSwitched,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              isSwitched =
                                                                  value;
                                                              print(isSwitched);
                                                            });
                                                          },
                                                          activeTrackColor: Colors
                                                              .lightGreenAccent,
                                                          activeColor:
                                                              Colors.green,
                                                        ),
                                                      ],
                                                    )),
                                              ],
                                            ),
                                          )),
                                    ],
                                  )))),
                    ],
                  )),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: InkWell(
                    onTap: () {
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
                              image: AssetImage("assets/check.png"),
                              width: 50,
                              height: 50,
                            ),
                            SizedBox(height: 20),
                            Text("SUCCESSFULLY BOOKED",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center),
                            SizedBox(height: 5),
                            Text(
                              "Booked appointment will show in your dashboard",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        buttons: [
                          DialogButton(
                            margin: const EdgeInsets.only(right: 20, left: 10),
                            color: Colors.grey[800],
                            radius: BorderRadius.circular(20),
                            onPressed: () async {
                              Navigator.pop(context);
                              await Navigator.pushReplacementNamed(
                                  context, RoutePaths.myTabBar);
                            },
                            child: const Text(
                              "GO BACK DASHBOARD",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ],
                      ).show();
                    },
                    child: Container(
                      height: h / 14,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromARGB(159, 114, 190, 21),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(''),
                                  Text(''),
                                  Text(''),
                                  Text(''),
                                  Text(''),
                                  Text(''),
                                  Text(
                                    'SUBMIT',
                                    style: TextStyle(
                                        letterSpacing: 0.5,
                                        fontSize: w / 30,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(''),
                                  Text(''),
                                  Text(''),
                                  Text(''),
                                  Text(''),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.black,
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                  )),
            )
          ],
        ),
      ),
    ));
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
                              margin: const EdgeInsets.all(10),
                              width: 20,
                              height: 20,
                              child: const Image(
                                color: Color.fromARGB(255, 62, 62, 62),
                                image: AssetImage(LocalImages.profile),
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
                              style: AlertStyle(),
                              context: context,
                              padding: EdgeInsets.all(20),
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image(
                                    image: AssetImage(LocalImages.alert),
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
                          },
                          child: Container(
                              margin: const EdgeInsets.all(10),
                              width: 20,
                              height: 20,
                              child: const Image(
                                color: Color.fromARGB(255, 62, 62, 62),
                                image: AssetImage(LocalImages.logout),
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
                              image: AssetImage(LocalImages.alert),
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
