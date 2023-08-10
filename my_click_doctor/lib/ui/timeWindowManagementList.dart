import 'dart:convert';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_click_doctor/services/api.dart';
import 'package:my_click_doctor/services/dateFormater.dart';
import 'package:my_click_doctor/services/router.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;
import '../constants/LocalImages.dart';
import '../constants/appConstants.dart';
import 'doctor_profile.dart';

class TimeWindowManagementScreen extends StatefulWidget {
  const TimeWindowManagementScreen({Key key}) : super(key: key);

  @override
  State<TimeWindowManagementScreen> createState() =>
      _TimeWindowManagementScreenPageState();
}

class _TimeWindowManagementScreenPageState
    extends State<TimeWindowManagementScreen> {
  final popUpControler = CustomPopupMenuController();
  //TextEditingController firstname = TextEditingController();

  var client = http.Client();

  var busy = false;
  var listModel = [];
  bool noDataFound = false;
  var profileimage = "";

  void initState() {
    super.initState();
    showList();
  }

  deleteSlot(int id) async {
    busy = true;
    var base = Api.baseUrl;
    final storage = FlutterSecureStorage();

    var token = await storage.read(key: 'token');
    // var id = await storage.read(key: 'id');

    var response = await client.delete(
      Uri.parse('$base/Doctor/DeleteDoctorSlot?Id=$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': '$token',
        'Lang': 'en',
        'Status': '1'
      },
      // body: jsonEncode(<String, dynamic>{
      //   'Id': 1573 //id.toString(),
      // }),
    );
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      var t = body['code'];

      if (t == 200) {
        busy = false;

        Alert(
          closeIcon: InkWell(
            onTap: () {
              Navigator.pop(context);
              showList();
            },
            child: Icon(
              Icons.close_rounded,
            ),
          ),
          //  () {
          // Navigator.pop(context);
          // showList();
          //     },
          style: const AlertStyle(),
          context: context,
          padding: const EdgeInsets.all(20),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Image(
                image: AssetImage(LocalImages.check),
                width: 50,
                height: 50,
              ),
              const SizedBox(height: 20),
              const Text("Successful",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center),
              const SizedBox(height: 5),
              Text(
                body['msg'],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
          buttons: [
            DialogButton(
              margin: const EdgeInsets.only(left: 20),
              color: AppColors.green,
              radius: BorderRadius.circular(20),
              onPressed: () {
                Navigator.pop(context);
                showList();
              },
              child: const Text(
                "Okay",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ).show();
      } else {
        busy = false;
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
                "This Appointment cannot be deleted because its already booked for this time slot",
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
      setState(() {});
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
              await Navigator.pushReplacementNamed(
                  context, RoutePaths.loginscreen);
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

  showList() async {
    busy = true;
    var base = Api.baseUrl;
    final storage = FlutterSecureStorage();

    var token = await storage.read(key: 'token');
    var id = await storage.read(key: 'id');
    var photo = await storage.read(key: 'profilePhoto');

    if (photo == "null") {
      profileimage =
          "https://staging.myclickdoctor.com/assets/img/doctor-user.png";
    } else {
      profileimage = Api.imageBaseUrl2 + photo;
    }

    var response = await client.get(
      Uri.parse('$base/Doctor/GetDoctorNewTimeMangementList?DocId=$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': '$token',
        'Lang': 'en',
        'Status': '1'
      },
    );
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      var t = body['code'];

      if (t == 200) {
        listModel = body['getList'];
        busy = false;

        if (listModel.isEmpty) {
          listModel = null;
          noDataFound = true;
        } else {}
      } else {
        busy = false;
        listModel = null;
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
              const SizedBox(height: 5),
              Text(
                body['msg'],
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
              onPressed: () {
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
      setState(() {});
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
              await Navigator.pushReplacementNamed(
                  context, RoutePaths.loginscreen);
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

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color.fromARGB(239, 239, 247, 248),
      body: (busy != true)
          ? SizedBox(
              height: h,
              width: w,
              child: Stack(
                children: [
                  Container(
                      color: const Color.fromARGB(239, 239, 247, 248),
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  MaterialButton(
                                    elevation: 0,
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, RoutePaths.myTabBar);
                                    },
                                    color: const Color.fromARGB(
                                        255, 204, 204, 204),
                                    textColor: Colors.white,
                                    child: const Icon(
                                      Icons.arrow_back,
                                      size: 20,
                                      color: Colors.black,
                                    ),
                                    padding: const EdgeInsets.all(12),
                                    shape: const CircleBorder(),
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
                                                padding: const EdgeInsets.only(
                                                    left: 15),
                                                child: Row(
                                                  children: [
                                                    ClipOval(
                                                      child: Material(
                                                        color: Colors.white,
                                                        child: InkWell(
                                                          splashColor:
                                                              Colors.black,
                                                          onTap: () {
                                                            Navigator.pushNamed(
                                                                context,
                                                                RoutePaths
                                                                    .supportScreen);
                                                          },
                                                          child: Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                      .all(10),
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
                                                      controller:
                                                          popUpControler,
                                                      child: CircleAvatar(
                                                        radius: h / 40,
                                                        backgroundColor:
                                                            Colors.grey[200],
                                                        child: CircleAvatar(
                                                          radius: h / 22,
                                                          backgroundImage: (profileimage ==
                                                                  null)
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
                                                      arrowColor:
                                                          Colors.blueAccent,
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
                                            image: AssetImage(
                                                'assets/four-dots.png')),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text('Time slot list',
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
                          (listModel != null)
                              ? Padding(
                                  padding: const EdgeInsets.all(20),

                                  //color: AppColors.red,
                                  child: SingleChildScrollView(
                                      child: Container(
                                          // color: Colors.red,
                                          height: h / 1.5 + 20,
                                          child: Column(
                                              children: listModel
                                                  .map(
                                                    (e) => Row(
                                                      children: [
                                                        Expanded(
                                                            child: Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left: 0,
                                                                        right:
                                                                            5,
                                                                        top: 0,
                                                                        bottom:
                                                                            10),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                // height: 100,
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                        padding:
                                                                            EdgeInsets.all(
                                                                                10),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Text(
                                                                              e['type'],
                                                                              style: TextStyle(
                                                                                color: Colors.black,
                                                                                letterSpacing: .5,
                                                                                fontSize: h / 55,
                                                                                fontWeight: FontWeight.w900,
                                                                              ),
                                                                            ),
                                                                            GestureDetector(
                                                                                onTap: () {
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
                                                                                          image: AssetImage(LocalImages.alert),
                                                                                          width: 50,
                                                                                          height: 50,
                                                                                        ),
                                                                                        SizedBox(height: 20),
                                                                                        Text("ALERT",
                                                                                            style: TextStyle(
                                                                                              fontSize: 16,
                                                                                              fontWeight: FontWeight.bold,
                                                                                            ),
                                                                                            textAlign: TextAlign.center),
                                                                                        SizedBox(height: 5),
                                                                                        Text(
                                                                                          "Are you sure you want to delete the slot",
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
                                                                                        onPressed: () {
                                                                                          Navigator.pop(context);
                                                                                          deleteSlot(e['id']);
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
                                                                                },
                                                                                child: const SizedBox(
                                                                                  height: 15,
                                                                                  width: 15,
                                                                                  child: Image(
                                                                                    image: AssetImage(LocalImages.delete),
                                                                                  ),
                                                                                )),
                                                                          ],
                                                                        )),
                                                                    Padding(
                                                                        padding: const EdgeInsets.only(
                                                                            left:
                                                                                10,
                                                                            top:
                                                                                5,
                                                                            right:
                                                                                10),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Text(
                                                                                  "From:",
                                                                                  style: TextStyle(
                                                                                    color: Colors.grey,
                                                                                    letterSpacing: .5,
                                                                                    fontSize: h / 85,
                                                                                    fontWeight: FontWeight.w800,
                                                                                  ),
                                                                                ),
                                                                                Text(
                                                                                  formatDate(DateTime.parse(e["fromTime"].toString()), [
                                                                                    dd,
                                                                                    '/',
                                                                                    mm,
                                                                                    '/',
                                                                                    yyyy,
                                                                                    ' ',
                                                                                    HH,
                                                                                    ':',
                                                                                    nn
                                                                                  ]),
                                                                                  style: TextStyle(
                                                                                    color: Colors.black,
                                                                                    // letterSpacing: .5,
                                                                                    fontSize: h / 90,
                                                                                    fontWeight: FontWeight.w900,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            // SizedBox(
                                                                            //   width: 60,
                                                                            // ),
                                                                            Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Text(
                                                                                  "Count:",
                                                                                  style: TextStyle(
                                                                                    color: Colors.grey,
                                                                                    letterSpacing: .5,
                                                                                    fontSize: h / 85,
                                                                                    fontWeight: FontWeight.w800,
                                                                                  ),
                                                                                ),
                                                                                Text(
                                                                                  e['maxCount'].toString(),
                                                                                  style: TextStyle(
                                                                                    color: Colors.black,
                                                                                    // letterSpacing: .5,
                                                                                    fontSize: h / 90,
                                                                                    fontWeight: FontWeight.w900,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            )
                                                                          ],
                                                                        )),
                                                                    Padding(
                                                                        padding: const EdgeInsets.only(
                                                                            left:
                                                                                10,
                                                                            top:
                                                                                5,
                                                                            right:
                                                                                10),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Text(
                                                                                  "Duration:",
                                                                                  style: TextStyle(
                                                                                    color: Colors.grey,
                                                                                    letterSpacing: .5,
                                                                                    fontSize: h / 85,
                                                                                    fontWeight: FontWeight.w800,
                                                                                  ),
                                                                                ),
                                                                                Text(
                                                                                  e["duration"].toString() + " minutes",
                                                                                  style: TextStyle(
                                                                                    color: Colors.black,
                                                                                    // letterSpacing: .5,
                                                                                    fontSize: h / 90,
                                                                                    fontWeight: FontWeight.w900,
                                                                                  ),
                                                                                ),
                                                                                const SizedBox(
                                                                                  height: 10,
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        )),
                                                                  ],
                                                                ))),
                                                      ],
                                                    ),
                                                  )
                                                  .toList()))),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(50),
                                  child: Container(
                                    color: Colors.transparent,
                                    child: Text("No data found",
                                        style: TextStyle(
                                            color: AppColors.red,
                                            fontSize: h / 68,
                                            fontWeight: FontWeight.w800)),
                                  ))

                          // Center(
                          //     child: Padding(
                          //     padding: const EdgeInsets.all(10),
                          //     child: Text("No data found",
                          //         style: TextStyle(
                          //             color: AppColors.red,
                          //             fontSize: h / 68,
                          //             fontWeight: FontWeight.w800)),
                          //   )),
                        ],
                      )),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: w,
                      //  height: h / 8,
                      // color: Colors.black,
                      //color: const Color.fromARGB(239, 239, 247, 248),
                      child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 20, right: 20, bottom: 40),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Container(
                                // height: h / 30,
                                child: ElevatedButton(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(''),
                                      Text(
                                        "TIME WINDOW MANAGEMENT",
                                        style: TextStyle(
                                          color: Colors.white,
                                          letterSpacing: .5,
                                          fontSize: h / 100,
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                        size: h / 56.0,
                                      ),
                                    ],
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(context,
                                        RoutePaths.bookingAppointmentScreen);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      backgroundColor: AppColors
                                          .darkBlue, //Color.fromARGB(255, 0, 100, 181),
                                      textStyle: TextStyle(
                                          fontSize: 2,
                                          fontWeight: FontWeight.bold)),
                                ),
                              )),
                            ],
                          )),
                    ),
                  )
                ],
              ),
            )
          : Center(
              child: Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                height: 40,
                width: 40,
                child: CircularProgressIndicator(color: AppColors.green),
              ),
            )),
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
                              context,
                              RoutePaths.basicInformationScreen,
                            );
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
                                    ;
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
                      Alert(
                        onWillPopActive: false,
                        closeIcon: null,
                        style: AlertStyle(),
                        context: context,
                        padding: EdgeInsets.all(20),
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
                              final storage = FlutterSecureStorage();
                              storage.deleteAll();
                              Navigator.pushReplacementNamed(
                                  context, RoutePaths.loginscreen);
                            },
                            child: const Text(
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
                            child: const Text(
                              "Cancel",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ],
                      ).show();
                    },
                    child: const Text('Logout',
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
