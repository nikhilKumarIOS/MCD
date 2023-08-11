// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:my_click_doctor/constants/appConstants.dart';
import 'package:my_click_doctor/models/baseModel.dart';
import 'package:my_click_doctor/services/api.dart';
import 'package:my_click_doctor/services/dateFormater.dart';
import 'package:my_click_doctor/services/router.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:file_picker/file_picker.dart';
import 'package:zoom_widget/zoom_widget.dart';

import '../../constants/LocalImages.dart';
import '../../widgets/alerts.dart';
import 'home_bloc/home_bloc.dart';
import 'home_bloc/home_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  bool widgetSelected = true;
  bool joinCallhideShow = false;
  bool userGuidesSelected = false;
  bool medicalSelected = false;
  Timer timer;
  int appntmntId = 0;
  int useridd = 0;
  int iddd = 0;
  var profileimage = "";
  var uploadBusy = false;
  var model1 = [];
  var model2 = [];
  List<Widget> allList = [];
  var twoMinutesMOdel = [];
  var busy = false;
  var noData = false;
  var doctorType = "";

  var client = http.Client();
  final _doctorDashboardBloc = DoctorDashboardBloc();
  final popUpControler = CustomPopupMenuController();
  TextEditingController appointmentPurpose = TextEditingController();
  @override
  void initState() {
    super.initState();

    _doctorDashboardBloc.fetchRecommendedAndBookedAppointments();

    timer = Timer.periodic(
      Duration(seconds: 15),
      (Timer t) => getTodayAppointment(),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    _doctorDashboardBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return SafeArea(
        child: WillPopScope(
      onWillPop: () async {
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
                              Image(
                                  height: h / 15,
                                  image: const AssetImage(LocalImages.logo)),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  (doctorType == "KeyOpinionLeader")
                                      ? ClipOval(
                                          child: Material(
                                            color: AppColors.green,
                                            child: InkWell(
                                              splashColor: Colors.black,
                                              onTap: () {
                                                Navigator.pushNamed(
                                                    context,
                                                    RoutePaths
                                                        .timeWindowManagementSCreen);
                                              },
                                              child: Container(
                                                  margin: EdgeInsets.all(10),
                                                  width: h / 40,
                                                  height: h / 40,
                                                  child: const Image(
                                                      image: AssetImage(
                                                          LocalImages
                                                              .greenjoincall))),
                                            ),
                                          ),
                                        )
                                      : SizedBox(),
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
                                                  child: CircleAvatar(
                                                    radius: h / 40,
                                                    backgroundColor:
                                                        Colors.grey[200],
                                                    child: CircleAvatar(
                                                      radius: h / 22,
                                                      backgroundImage:
                                                          (profileimage == null)
                                                              ? const AssetImage(
                                                                  LocalImages
                                                                      .profile)
                                                              : NetworkImage(
                                                                  profileimage),
                                                    ),
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
                                    Text('Dashboard',
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
                              shape: (userGuidesSelected == true)
                                  ? RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10)),
                                    )
                                  : RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
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
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image(
                                        height: h / 46,
                                        image: AssetImage(LocalImages.info)),
                                    const SizedBox(width: 10),
                                    Text('User guides',
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
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: Container(
                                  height: h / 3,
                                  width: w,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: Colors.white,
                                  ),
                                  child: Zoom(
                                      enableScroll: true,
                                      zoomSensibility: 10.0,
                                      maxZoomWidth: 2100,
                                      maxZoomHeight: 2100,
                                      child: Center(
                                          child: const WebView(
                                        zoomEnabled: true,
                                        initialUrl:
                                            'https://doctortest.medicalscan.hu/mcdreg/doc?tipus=slider',
                                        javascriptMode:
                                            JavascriptMode.unrestricted,
                                      )))))
                          : SizedBox(),
                      (joinCallhideShow == true)
                          ? Padding(
                              padding: const EdgeInsets.all(20),
                              child: Container(
                                width: w,
                                height: h / 8,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    image: DecorationImage(
                                        image: AssetImage('assets/bg.png'),
                                        fit: BoxFit.fill)),
                                child: Column(
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: 60, left: 0, right: 0),
                                        child: InkWell(
                                            onTap: () {
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
                                                          LocalImages
                                                              .greenPhone),
                                                      width: 50,
                                                      height: 50,
                                                    ),
                                                    SizedBox(height: 20),
                                                    Text("JOIN CALL",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center),
                                                    SizedBox(height: 5),
                                                    Text(
                                                      "The call will start in two minutes.",
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
                                                    color: Color.fromARGB(
                                                        159, 114, 190, 21),
                                                    radius:
                                                        BorderRadius.circular(
                                                            20),
                                                    onPressed: () async {
                                                      Navigator.pop(context);
                                                      meetingEndStatus(iddd,
                                                          appntmntId, useridd);
                                                    },
                                                    child: Text(
                                                      "JOIN CALL",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          letterSpacing: 0.5,
                                                          fontSize: 18),
                                                    ),
                                                  ),
                                                ],
                                              ).show();
                                            },
                                            child: Container(
                                              width: 70,
                                              height: h / 28,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Colors.white,
                                              ),
                                              child: Container(
                                                margin: EdgeInsets.all(10),
                                                child: Text('JOIN CALL',
                                                    style: TextStyle(
                                                      fontSize: 8,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color: Colors.black,
                                                    )),
                                              ),
                                            )))
                                  ],
                                ),
                              ))
                          : Padding(
                              padding: EdgeInsets.all(10),
                              child: Container(),
                            ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0.0,
                              shadowColor: Colors.transparent,
                              shape: (widgetSelected == true)
                                  ? RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10)),
                                    )
                                  : RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                              minimumSize: const Size.fromHeight(60),
                              backgroundColor: Colors.white,
                            ),
                            onPressed: () async {
                              setState(() {
                                if (widgetSelected == true) {
                                  widgetSelected = false;
                                } else if (widgetSelected == false) {
                                  widgetSelected = true;
                                }
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image(
                                        height: h / 46,
                                        image: const AssetImage(
                                            LocalImages.calendar)),
                                    const SizedBox(width: 10),
                                    Text('Booked Appointments',
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
                                    (widgetSelected == true)
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
                      (widgetSelected == true)
                          ? Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: BookedAppointment())
                          : Container(),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 20, right: 20),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0.0,
                              shadowColor: Colors.transparent,
                              shape: (medicalSelected == true)
                                  ? RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10)),
                                    )
                                  : RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                              minimumSize: const Size.fromHeight(60),
                              backgroundColor: Colors.white,
                            ),
                            onPressed: () async {
                              setState(() {
                                if (medicalSelected == false) {
                                  medicalSelected = true;
                                } else if (medicalSelected == true) {
                                  medicalSelected = false;
                                }
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image(
                                        height: h / 46,
                                        image: const AssetImage(
                                            'assets/info1.png')),
                                    const SizedBox(width: 10),
                                    Text('Previous MedicalScan Webinar',
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
                                    (medicalSelected == true)
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
                      (medicalSelected == true)
                          ? Padding(
                              padding: EdgeInsets.only(
                                  right: 20, left: 20, bottom: 20),
                              child: Container(
                                  height: h / 3,
                                  width: w,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: Colors.white,
                                  ),
                                  child: Zoom(
                                      enableScroll: true,
                                      zoomSensibility: 10.0,
                                      maxZoomWidth: 2100,
                                      maxZoomHeight: 2100,
                                      child: Center(
                                          child: const WebView(
                                        zoomEnabled: true,
                                        initialUrl:
                                            'https://doctortest.medicalscan.hu/mcdreg/webinarlist',
                                        javascriptMode:
                                            JavascriptMode.unrestricted,
                                      )))))
                          : SizedBox(),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0.0,
                              shadowColor: Colors.transparent,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              minimumSize: const Size.fromHeight(60),
                              backgroundColor:
                                  const Color.fromARGB(159, 114, 190, 21),
                            ),
                            onPressed: () async {
                              Navigator.pop(context);
                              await Navigator.pushNamed(
                                  context, RoutePaths.bookAppointmentScreen);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image(
                                    height: h / 46,
                                    image:
                                        const AssetImage(LocalImages.calendar)),
                                const SizedBox(width: 10),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text('BOOKING APPOINTMENT',
                                        style: TextStyle(
                                          fontSize: w / 30,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        )),
                                    SizedBox(
                                      width: w / 5,
                                    )
                                  ],
                                )

                                //   ],
                                // )
                              ],
                            )),
                      ),
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

  Widget BookedAppointment() {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
      ),
      child: Column(
        children: [
          StreamBuilder<DoctorDashboardState>(
            stream: _doctorDashboardBloc.stateStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final state = snapshot.data;
                print("this state $state");

                if (state is LoadingDoctorDashboardState) {
                  return Padding(
                    padding: EdgeInsets.all(10),
                    child: SizedBox(
                      width: w,
                      child: Center(
                        child: SizedBox(
                          height: 40,
                          width: 40,
                          child:
                              CircularProgressIndicator(color: AppColors.green),
                        ),
                      ),
                    ),
                  );
                } else if (state is BookedAppointmentsLoadedState) {
                  final allList = state.combinedAppointments;

                  if (allList.isEmpty) {
                    return Container(
                      width: w,
                      margin: EdgeInsets.all(10),
                      child: Center(
                        child: Text("No data found",
                            style: TextStyle(
                                color: AppColors.red,
                                fontSize: h / 68,
                                fontWeight: FontWeight.w800)),
                      ),
                    );
                  }

                  return Container(
                    margin: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    controllerC.previousPage();
                                  });
                                },
                                child: Icon(Icons.arrow_back),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    controllerC.nextPage();
                                  });
                                },
                                child: Icon(Icons.arrow_forward),
                              ),
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: _image2Slider(allList))),
                      ],
                    ),
                  );
                } else if (state is ErrorLoadingAppointmentsState) {
                  return Container(
                    width: w,
                    margin: EdgeInsets.all(10),
                    child: Center(
                      child: Text(
                          "An error occurred while loading appointments",
                          style: TextStyle(
                              color: AppColors.red,
                              fontSize: h / 68,
                              fontWeight: FontWeight.w800)),
                    ),
                  );
                }
              }
              return Container(
                width: w,
                margin: EdgeInsets.all(10),
                child: Center(
                  child: Text("Loading...",
                      style: TextStyle(
                          color: AppColors.red,
                          fontSize: h / 68,
                          fontWeight: FontWeight.w800)),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  CarouselController controllerC = CarouselController();

  Widget _imageSlider() {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return CarouselSlider(
      carouselController: controllerC,
      options: CarouselOptions(
        height: h / 2.5,
        viewportFraction: 0.9,
        aspectRatio: 2.0,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 5),
        autoPlayAnimationDuration: const Duration(milliseconds: 3000),
        autoPlayCurve: Curves.linear,
        enlargeCenterPage: false,
        scrollDirection: Axis.horizontal,
      ),
      items: model1?.map((e) {
        return Container(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(239, 239, 247, 248),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  height: h / 2.6,
                  width: w / 2.4,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: CircleAvatar(
                          radius: h / 20,
                          backgroundColor: Colors.white, // Image radius
                          backgroundImage: (e['photoUrl'] == null)
                              ? AssetImage(LocalImages.doctorPic)
                              : NetworkImage(
                                      Api.imageBaseUrl + e['photoUrl'] ?? "")
                                  as ImageProvider,
                        ),
                      ),
                      Text(
                        e['firstName'] ?? "",
                        style: TextStyle(
                            fontSize: h / 68, fontWeight: FontWeight.w800),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          top: 10,
                        ),
                        child: Container(
                          //  color: Colors.amber,
                          width: w / 2.4,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image(
                                  height: h / 56,
                                  image: AssetImage('assets/stethoscope.png')),
                              const SizedBox(width: 5),
                              Text(
                                "specialty - ",
                                style: TextStyle(
                                  fontSize: w / 46,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black,
                                ),
                                maxLines: 4,
                                softWrap: !true,
                              ),
                              Expanded(
                                  child: Text(
                                e["expert"]
                                    .map((e) => e["specialization"])
                                    .toString(),
                                style: TextStyle(
                                  fontSize: w / 46,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black,
                                ),
                              )),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          top: 10,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.calendar_month_outlined,
                              color: Colors.grey,
                              size: h / 56,
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                                child: Text(
                              formatDate(
                                  DateTime.parse(
                                      e["appointmentDate"].toString()),
                                  [dd, '/', mm, '/', yyyy, ' ', HH, ':', nn]),
                              style: TextStyle(
                                fontSize: w / 46,
                                fontWeight: FontWeight.w800,
                                color: Colors.black,
                              ),
                              maxLines: 4,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image(
                                height: h / 56,
                                image: AssetImage('assets/repeat.png')),
                            const SizedBox(width: 5),
                            Text(
                              "Slot- ",
                              style: TextStyle(
                                fontSize: w / 46,
                                fontWeight: FontWeight.w800,
                                color: Colors.black,
                              ),
                              maxLines: 4,
                            ),
                            Text(
                              formatDate(
                                  DateTime.parse(e["fromTime"].toString()),
                                  [HH, ':', nn]),
                              style: TextStyle(
                                fontSize: w / 46,
                                fontWeight: FontWeight.w800,
                                color: Colors.black,
                              ),
                              maxLines: 4,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              formatDate(DateTime.parse(e["toTime"].toString()),
                                  ['-', HH, ':', nn]),
                              style: TextStyle(
                                fontSize: w / 46,
                                fontWeight: FontWeight.w800,
                                color: Colors.black,
                              ),
                              maxLines: 4,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          top: 10,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image(
                                height: h / 56,
                                image: AssetImage('assets/repeat.png')),
                            const SizedBox(width: 5),
                            Expanded(
                                child: Row(
                              children: [
                                Text(
                                  "Duration- ",
                                  style: TextStyle(
                                    fontSize: w / 46,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black,
                                  ),
                                  maxLines: 4,
                                ),
                                Text(
                                  e["duration"].toString() ?? "" ' minutes',
                                  style: TextStyle(
                                    fontSize: w / 46,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black,
                                  ),
                                  maxLines: 4,
                                )
                              ],
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image(
                                height: h / 66,
                                image: AssetImage('assets/category-(2).png')),
                            const SizedBox(width: 5),
                            Expanded(
                                child: Container(
                              width: w / 2.4,
                              child: Row(
                                children: [
                                  Text(
                                    "Type- ",
                                    style: TextStyle(
                                      fontSize: w / 46,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black,
                                    ),
                                    maxLines: 4,
                                  ),
                                  Text(
                                    e["appointmentType"] ?? "",
                                    style: TextStyle(
                                      fontSize: w / 46,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black,
                                    ),
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 4,
                                  )
                                ],
                              ),
                            )),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Expanded(
                                child: Container(
                              height: h / 30,
                              child: ElevatedButton(
                                child: Text(
                                  "MORE INFORMATION",
                                  style: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: .5,
                                    fontSize: h / 180,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context,
                                      RoutePaths.appointmentDetailScreen,
                                      arguments: {
                                        'key1':
                                            e["appointmentId"].toString() ?? "",
                                        'key2': e["id"].toString() ?? "",
                                        'key3':
                                            e["appointmentCode"].toString() ??
                                                "",
                                      });
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    backgroundColor:
                                        Color.fromARGB(216, 2, 7, 29),
                                    textStyle: TextStyle(
                                        fontSize: 2,
                                        fontWeight: FontWeight.bold)),
                              ),
                            )),
                            SizedBox(width: 5),
                            Expanded(
                                child: (uploadBusy == false)
                                    ? Container(
                                        height: h / 30,
                                        child: ElevatedButton(
                                          child: Text(
                                            'UPLOAD DOCUMENT',
                                            style: TextStyle(
                                              color: Colors.black,
                                              letterSpacing: .5,
                                              fontSize: h / 180,
                                            ),
                                          ),
                                          onPressed: () async {
                                            FilePickerResult result =
                                                await FilePicker.platform
                                                    .pickFiles(
                                              type: FileType.custom,
                                              allowMultiple: false,
                                              allowedExtensions: [
                                                'jpg',
                                                'pdf',
                                                'doc',
                                                'ppt',
                                                'JPEG',
                                                'png'
                                              ],
                                            );
                                            if (result != null) {
                                              PlatformFile file =
                                                  result.files.first;
                                              var multipartFile =
                                                  await MultipartFile.fromFile(
                                                file.path,
                                              );
                                              FormData formData =
                                                  FormData.fromMap({
                                                'file': multipartFile,
                                                'MeetingId':
                                                    e["appointmentCode"] ?? "",
                                                'Usertype': '2',
                                                'Id': e["id"] ?? "".toString(),
                                              });

                                              UploadShareDocument(formData);
                                            } else {}
                                          },
                                          style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              backgroundColor:
                                                  Colors.transparent,
                                              textStyle: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      )
                                    : CircularProgressIndicator(
                                        color: AppColors.green,
                                      ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 10, left: 10),
                        child: Row(
                          children: [
                            Expanded(
                                child: Container(
                              height: h / 30,
                              child: ElevatedButton(
                                child: Text(
                                  "CANCEL APPOINTMENT",
                                  style: TextStyle(
                                    color: Colors.white,
                                    // letterSpacing: .4,
                                    fontSize: h / 180,
                                  ),
                                ),
                                onPressed: () {
                                  cancelAppointmentAlert(
                                      e["appointmentId"] ?? "", context);
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    backgroundColor: Colors.red[
                                        600], //Color.fromARGB(255, 0, 100, 181),
                                    textStyle: TextStyle(
                                        fontSize: 2,
                                        fontWeight: FontWeight.bold)),
                              ),
                            )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 1,
                left: 0,
                right: 0,
                child: Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          splashColor: Colors.black, // Splash color
                          onTap: () {},
                          child: Container(
                              margin: EdgeInsets.all(10),
                              width: h / 46,
                              height: h / 46,
                              child: const Image(
                                  image: AssetImage('assets/bookmark.png'))),
                        ),
                        InkWell(
                          splashColor: Colors.black,
                          onTap: () {
                            Navigator.pushNamed(
                                context, RoutePaths.bookAppointmentScreen);
                          },
                          child: Container(
                              color: Colors.white,
                              width: h / 56,
                              height: h / 56,
                              child: const Image(
                                  image: AssetImage(
                                      'assets/green-join-call.png'))),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        );
      })?.toList(),
    );
  }

  Widget _image2Slider(List<dynamic> combinedAppointments) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return CarouselSlider(
        carouselController: controllerC,
        options: CarouselOptions(
          height: h / 2.5,
          viewportFraction: 0.4,
          aspectRatio: 2.0,
          initialPage: 0,
          enableInfiniteScroll: false,
          reverse: false,
          autoPlay: (combinedAppointments.length > 2) ? true : false,
          autoPlayInterval: const Duration(seconds: 5),
          autoPlayAnimationDuration: const Duration(milliseconds: 3000),
          autoPlayCurve: Curves.linear,
          disableCenter: true,
          enlargeCenterPage: false,
          scrollDirection: Axis.horizontal,
        ),
        items: combinedAppointments.map((e) {
          return SizedBox(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(239, 239, 247, 248),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    height: h / 2.6,
                    // width: w / 2.4,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: CircleAvatar(
                            radius: h / 20,
                            backgroundColor: Colors.white,
                            backgroundImage: (e["photoUrl"] == null)
                                ? AssetImage(LocalImages.doctorPic)
                                : NetworkImage(Api.imageBaseUrl + e["photoUrl"])
                                    as ImageProvider,
                          ),
                        ),
                        Text(
                          e["firstName"] ?? "",
                          style: TextStyle(
                              fontSize: h / 68, fontWeight: FontWeight.w800),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            top: 10,
                          ),
                          child: Container(
                            width: w / 2.4,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image(
                                    height: h / 56,
                                    image:
                                        AssetImage('assets/stethoscope.png')),
                                const SizedBox(width: 5),
                                Text(
                                  "specialty - ",
                                  style: TextStyle(
                                    fontSize: w / 46,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black,
                                  ),
                                  maxLines: 4,
                                  softWrap: !true,
                                ),
                                Expanded(
                                    child: Text(
                                  e["expert"]
                                      .map((e) => e["specialization"])
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: w / 46,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black,
                                  ),
                                )),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            top: 10,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.calendar_month_outlined,
                                color: Colors.grey,
                                size: h / 56,
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                  child: Text(
                                formatDate(
                                    DateTime.parse(
                                        e["appointmentDate"].toString()),
                                    [dd, '/', mm, '/', yyyy, ' ', HH, ':', nn]),
                                style: TextStyle(
                                  fontSize: w / 46,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black,
                                ),
                                maxLines: 4,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image(
                                  height: h / 56,
                                  image: AssetImage('assets/repeat.png')),
                              const SizedBox(width: 5),
                              Text(
                                "Slot- ",
                                style: TextStyle(
                                  fontSize: w / 46,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black,
                                ),
                                maxLines: 4,
                              ),
                              Text(
                                formatDate(
                                    DateTime.parse(
                                        e["fromTime"].toString() ?? ""),
                                    [HH, ':', nn]),
                                style: TextStyle(
                                  fontSize: w / 46,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black,
                                ),
                                maxLines: 4,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                formatDate(
                                    DateTime.parse(
                                        e["toTime"].toString() ?? ""),
                                    ['-', HH, ':', nn]),
                                style: TextStyle(
                                  fontSize: w / 46,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black,
                                ),
                                maxLines: 4,
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            top: 10,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image(
                                  height: h / 56,
                                  image: AssetImage('assets/repeat.png')),
                              const SizedBox(width: 5),
                              Expanded(
                                  child: Row(
                                children: [
                                  Text(
                                    "Duration- ",
                                    style: TextStyle(
                                      fontSize: w / 46,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black,
                                    ),
                                    maxLines: 4,
                                  ),
                                  Text(
                                    e["duration"].toString() ?? "" ' minutes',
                                    style: TextStyle(
                                      fontSize: w / 46,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black,
                                    ),
                                    maxLines: 4,
                                  )
                                ],
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image(
                                  height: h / 66,
                                  image: AssetImage('assets/category-(2).png')),
                              const SizedBox(width: 5),
                              Expanded(
                                  child: Container(
                                width: w / 2.4,
                                child: Row(
                                  children: [
                                    Text(
                                      "Type- ",
                                      style: TextStyle(
                                        fontSize: w / 46,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.black,
                                      ),
                                      maxLines: 4,
                                    ),
                                    Text(
                                      e["appointmentType"] ?? "",
                                      style: TextStyle(
                                        fontSize: w / 46,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.black,
                                      ),
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 4,
                                    )
                                  ],
                                ),
                              )),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Container(
                                height: h / 30,
                                child: ElevatedButton(
                                  child: Text(
                                    "BOOK APPOINTMENT",
                                    style: TextStyle(
                                      color: Colors.white,
                                      letterSpacing: .5,
                                      fontSize: h / 180,
                                    ),
                                  ),
                                  onPressed: () {
                                    showAppointmentConfirmation(context, e);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      backgroundColor: AppColors
                                          .green, //Color.fromARGB(255, 0, 100, 181),
                                      textStyle: TextStyle(
                                          fontSize: 2,
                                          fontWeight: FontWeight.bold)),
                                ),
                              )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        })?.toList());
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
                            Navigator.pushNamed(
                                context, RoutePaths.basicInformationScreen);
                          },
                          child: Container(
                              margin: EdgeInsets.all(10),
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
                        context, RoutePaths.basicInformationScreen);
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
                                    final storage = FlutterSecureStorage();
                                    storage.deleteAll();
                                    Navigator.pushReplacementNamed(
                                        context, RoutePaths.loginscreen);
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
                      setState(() {});
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
                              final storage = FlutterSecureStorage();
                              storage.deleteAll();
                              Navigator.pushReplacementNamed(
                                  context, RoutePaths.loginscreen);
                              // Navigator.of(context)
                              //     .popUntil((route) => route.isFirst);
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

  //GetBookedAppointmentModel model1;
  //GetRecommendedAppointmentModel model2;

  // getBookedAppointment() async {
  //   busy = true;
  //   var base = Api.baseUrl;
  //   final storage = FlutterSecureStorage();
  //   var auth = await storage.read(key: 'id');
  //   var token = await storage.read(key: 'token');
  //   var photo = await storage.read(key: 'profilePhoto');
  //   doctorType = await storage.read(key: 'dtype');
  //   if (photo == "null") {
  //     profileimage =
  //         "https://staging.myclickdoctor.com/assets/img/doctor-user.png";
  //   } else {
  //     profileimage = Api.imageBaseUrl2 + photo;
  //   }
  //   print(profileimage);

  //   var response = await client.get(
  //     Uri.parse('$base/Doctor/GetDashBoardBookedAppointment?DocId=$auth'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       'authorization': '$token',
  //       'Lang': 'en',
  //       'Status': '1'
  //     },
  //   );
  //   if (response.statusCode == 200) {
  //     var Body = json.decode(response.body);

  //     if (Body.isEmpty) {
  //       // setState(() {
  //       busy = true;
  //       noData = true;

  //       //   });
  //     } else {
  //       // setState(() {
  //       busy = false;
  //       noData = false;
  //       // });
  //       //  doctorType = doctorT;
  //       model1 = Body['specializationCategory'];
  //     }

  //     setState(() {
  //       profileimage;
  //     });
  //   } else {}
  // }

  // getRecommendAppointment() async {
  //   busy = true;
  //   var base = Api.baseUrl;
  //   final storage = FlutterSecureStorage();
  //   var auth = await storage.read(key: 'id');
  //   var token = await storage.read(key: 'token');
  //   var response = await client.get(
  //     Uri.parse('$base/Doctor/GetDoctorRecomndedTimeslot?DocId=$auth'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       'authorization': '$token',
  //       'Lang': 'en',
  //       'Status': '1'
  //     },
  //   );
  //   if (response.statusCode == 200) {
  //     var Body = json.decode(response.body);

  //     if (Body.isEmpty) {
  //       //  setState(() {
  //       busy = true;
  //       noData = true;
  //       //  });
  //     } else {
  //       model2 = Body['specializationCategory'];
  //       //   setState(() {
  //       noData = false;
  //       busy = false;
  //       //    });
  //     }

  //     setState(() {});
  //   } else {
  //     return somethingWentWrong(false, context);
  //   }
  // }

  cancelAppointment(int idd) async {
    var base = Api.baseUrl;
    final storage = FlutterSecureStorage();

    var token = await storage.read(key: 'token');
    var id = await storage.read(key: 'id');

    var response = await client.post(
      Uri.parse('$base/Doctor/CancelDoctorMeeting'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'Id': idd.toString(),
        'Status': '0',
        'Type': 2.toString()
      }),
    );
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      var t = body['code'];
      if (t == 200) {
        _doctorDashboardBloc.fetchRecommendedAndBookedAppointments();
      } else {
        print('not deleted');
      }
    } else {
      return somethingWentWrong(false, context);
    }
  }

  BookDoctorNewAppointment(multiformData) async {
    busy = true;

    var base = Api.baseUrl;
    final storage = FlutterSecureStorage();
    var token = await storage.read(key: 'token');

    Dio dio = Dio();
    final response = await dio.post(
      '$base/Doctor/BookDoctorNewAppointment',
      data: multiformData,
      options: Options(
          contentType: 'multipart/form-data',
          headers: {'authorization': '$token', 'Lang': 'en', 'Status': '1'},
          followRedirects: false,
          validateStatus: (status) {
            // print(Response(requestOptions: ResponseBody))
            return status <= 501;
          }),
    );
    var Body = response.data;
    print(Body);
    print(Body);

    if (Body['code'] == 200) {
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
              image: AssetImage(LocalImages.check),
              width: 50,
              height: 50,
            ),
            SizedBox(height: 20),
            Text("Successful",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center),
            SizedBox(height: 5),
            Text(
              "Appoinment has been successfully booked",
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
      model1 = [];
      model2 = [];
      allList = [];
      _doctorDashboardBloc.fetchRecommendedAndBookedAppointments();
      appointmentPurpose.text = "";
    } else {
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
              image: AssetImage(LocalImages.check),
              width: 50,
              height: 50,
            ),
            SizedBox(height: 20),
            Text("Unsuccessful",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center),
            SizedBox(height: 5),
            Text(
              "Appointment has not been booked",
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
      model1 = [];
      model2 = [];
      allList = [];
      _doctorDashboardBloc.fetchRecommendedAndBookedAppointments();
      appointmentPurpose.text = "";
    }
  }

  getTodayAppointment() async {
    var base = Api.baseUrl;

    final storage = FlutterSecureStorage();

    var token = await storage.read(key: 'token');
    var id = await storage.read(key: 'id');
    String idd = id.toString();

    var response = await client.get(
      Uri.parse('$base/Admin/GetTodayDoctorList?Id=$idd'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': '$token',
        'Lang': 'en',
        'Status': '1'
      },
    );
    if (response.statusCode == 200) {
      var body = json.decode(response.body);

      twoMinutesMOdel = body['todayAppList'];
      var tt = body['code'];

      if (tt == 200) {
        DateTime dt = DateTime.parse(twoMinutesMOdel.first['startDate']);

        if (twoMinutesMOdel.isNotEmpty || twoMinutesMOdel != null) {
          Duration difference = DateTime.now().difference(dt);
          if (difference.inMinutes < 2) {
            setState(() {
              joinCallhideShow = true;
            });
            print('2 minutes remaining');
            return "Just now";
          }
        } else {}
      }
    } else {
      return print('NO call');
    }
  }

  meetingEndStatus(int idd, int appointmntId, int userId) async {
    var base = Api.baseUrl;
    final storage = FlutterSecureStorage();
    var token = await storage.read(key: 'token');
    var id = await storage.read(key: 'id');
    var response = await client.post(
      Uri.parse('$base/Admin/MeetingEndStatus'),
      headers: <String, String>{
        'authorization': '$token',
        'Lang': 'en',
        'Status': '1'
      },
      body: jsonEncode(<String, String>{
        'MeetingId': appointmntId.toString(),
        'Type': '2',
        'Status': '2',
        'UserId': userId.toString(),
        'Id': idd.toString(),
      }),
    );
    if (response.statusCode == 200) {
      // var body = json.decode(response.body);
      return Navigator.pushNamed(context, RoutePaths.callScreen);
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

  UploadShareDocument(multiformData) async {
    uploadBusy = true;
    var base = Api.baseUrl;
    final storage = FlutterSecureStorage();
    var token = await storage.read(key: 'token');
    Dio dio = Dio();
    final response = await dio.post(
      '$base/Admin/UploadShareDocument',
      data: multiformData,
      options: Options(
          contentType: 'multipart/form-data',
          headers: {'authorization': '$token', 'Lang': 'en', 'Status': '1'},
          followRedirects: false,
          validateStatus: (status) {
            // print(Response(requestOptions: ResponseBody))
            return status <= 501;
          }),
    );
    var Body = response.data;
    print(Body);
    print(Body);

    if (Body['code'] == 200) {
      uploadBusy = false;
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
              image: AssetImage(LocalImages.check),
              width: 50,
              height: 50,
            ),
            SizedBox(height: 20),
            Text("Successful",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center),
            SizedBox(height: 5),
            Text(
              "Successfully uploaded",
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
    } else {
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
              image: AssetImage(LocalImages.check),
              width: 50,
              height: 50,
            ),
            SizedBox(height: 20),
            Text("Unsuccessful",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center),
            SizedBox(height: 5),
            Text(
              "file has not been uploaded",
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
  }

  void showAppointmentConfirmation(BuildContext context, e) {
    final appointmentPurpose = TextEditingController();
    final w = MediaQuery.of(context).size.width;

    Alert(
      closeIcon: null,
      style: AlertStyle(),
      context: context,
      padding: EdgeInsets.all(20),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Image(
            image: AssetImage(LocalImages.cancel),
            width: 50,
            height: 50,
          ),
          SizedBox(height: 20),
          Text(
            "BOOK APPOINTMENT",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 5),
          Text(
            "Are you sure you want to book this appointment",
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
            Navigator.pop(context);

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
                  SizedBox(height: 20),
                  Text(
                    "Enter appointment purpose",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 5),
                  TextFormField(
                    controller: appointmentPurpose,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: w / 30,
                    ),
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: w / 30,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: Color.fromARGB(239, 239, 247, 248),
                      filled: true,
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
                    Navigator.pop(context);
                    final storage = FlutterSecureStorage();
                    var id = await storage.read(key: 'id');
                    FormData formData = FormData.fromMap({
                      'file': "",
                      'AppointmentTitle': appointmentPurpose.text,
                      'DoctorConsultationId': e['doctorId'],
                      'DoctorId': id.toString(),
                      'SlotId': e['slotId'],
                      'Duration': e['duration'],
                      'StartDate': e['toTime'],
                      'Name': "",
                    });

                    BookDoctorNewAppointment(formData);
                  },
                  child: const Text(
                    "Done",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
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
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ).show();
          },
          child: const Text(
            "Yes",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
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
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ],
    ).show();
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
