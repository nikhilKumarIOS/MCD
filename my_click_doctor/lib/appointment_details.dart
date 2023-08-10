import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:camera/camera.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:gallery_saver/gallery_saver.dart';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_click_doctor/constants/LocalImages.dart';
import 'package:my_click_doctor/constants/appConstants.dart';
import 'package:my_click_doctor/models/downloadFileModel.dart';
import 'package:my_click_doctor/services/api.dart';
import 'package:my_click_doctor/services/dateFormater.dart';
import 'package:my_click_doctor/services/router.dart';
import 'package:my_click_doctor/support_screen.dart';
import 'package:my_click_doctor/testing_mic.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:intl/intl.dart';
//import 'package:ext_storage/ext_storage.dart';

import 'doctor_profile.dart';
import 'download_action.dart';
import 'main.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

import 'models/getAppointmentDetailsModel.dart';

class AppointmentDetailScreen extends StatefulWidget {
  const AppointmentDetailScreen(this.AppointmentID, {Key key})
      : super(key: key);
  final Map<String, dynamic> AppointmentID;

  @override
  State<AppointmentDetailScreen> createState() =>
      _AppointmentDetailScreenPageState();
}

var dio = Dio();

class _AppointmentDetailScreenPageState extends State<AppointmentDetailScreen> {
  // Future<String> path = ExtStorage.getExternalStoragePublicDirectory(
  //     ExtStorage.DIRECTORY_DOWNLOADS);

  final pdfUrl =
      "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf";

  bool downloading = false;
  var progress = "";

  var platformVersion = "Unknown";
  var _onPressed;
  Directory externalDir;

  bool isSwitched = true;
  bool isSMSSwitched = true;
  bool isEmailSwitched = true;
  bool widgetSelected = true;
  final popUpControler = CustomPopupMenuController();
  var client = http.Client();
  var profileimage = "";
  DownloadFileModel sharedFile;
  var apntmntModel;

  void initState() {
    super.initState();

    getAppointmentDetail();
    getSharedDocuments();
  }

  void showDownloadProgress(received, total) {
    if (total != -1) {
      print((received / total * 100).toStringAsFixed(0) + "%");
    }
  }

  Future download2(Dio dio, String url, String savePath) async {
    try {
      Response response = await dio.get(
        url,
        onReceiveProgress: showDownloadProgress,
        //Received data with List<int>
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            }),
      );
      print(response.headers);
      File file = File(savePath);
      var raf = file.openSync(mode: FileMode.write);
      // response.data is List<int> type
      raf.writeFromSync(response.data);
      await raf.close();
    } catch (e) {
      print(e);
    }
  }

  getAppointmentDetail() async {
    var base = Api.baseUrl;
    final storage = FlutterSecureStorage();
    var token = await storage.read(key: 'token');
    var id = await storage.read(key: 'id');
    String appId = widget.AppointmentID['key1'].toString();
    var response = await client.get(
      Uri.parse('$base/Admin/GetAppointmentDetail?Id=$appId'),
      headers: <String, String>{
        'authorization': '$token',
        'Lang': 'en',
        'Status': '1'
      },
    );
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      apntmntModel = body['data'];
      print(apntmntModel);
      print(apntmntModel['appointmentTitle']);
      setState(() {
        apntmntModel;
      });
      return apntmntModel;
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

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
            backgroundColor: const Color.fromARGB(239, 239, 247, 248),
            body: (apntmntModel != null)
                ? SizedBox(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Ink(
                                          decoration: const ShapeDecoration(
                                              shape: CircleBorder(),
                                              color: Color.fromARGB(
                                                  255, 204, 204, 204)),
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
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              height: h / 14,
                                              width: w / 2.8,
                                              decoration: const BoxDecoration(
                                                color: Color.fromARGB(
                                                    216, 2, 7, 29),
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(30.0),
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 15),
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
                                                                    width:
                                                                        h / 46,
                                                                    height:
                                                                        h / 46,
                                                                    child: const Image(
                                                                        image: AssetImage(
                                                                            LocalImages.questionSign))),
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
                                                                  Colors.grey[
                                                                      200],
                                                              child:
                                                                  CircleAvatar(
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
                                                              child:
                                                                  _buildAvatar(),
                                                            ),
                                                            barrierColor: Colors
                                                                .transparent,
                                                            pressType: PressType
                                                                .singleClick,
                                                            arrowColor: Colors
                                                                .blueAccent,
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
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Image(
                                                  height: h / 56,
                                                  image: const AssetImage(
                                                      LocalImages.fourDots)),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text('Appointment Details',
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
                                  padding: EdgeInsets.only(
                                      left: 30, top: 20, right: 30),
                                  child: Container(
                                      // height: h / 6.5,
                                      // width: w / 10,

                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child:

                                          // Expanded(
                                          //     flex: 2,
                                          //     child:
                                          Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                                "Appointment's purpose",
                                                style: TextStyle(
                                                    fontSize: w / 30,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                          Container(
                                              margin: const EdgeInsets.all(10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    apntmntModel[
                                                            "appointmentTitle"]
                                                        .toString(),
                                                    style: const TextStyle(
                                                        color: Colors.grey),
                                                  )
                                                ],
                                              )),
                                        ],
                                      )
                                      //),
                                      ),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 30, top: 20, right: 30),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                              height: h / 10,
                                              // width: w / 10,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
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
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        "Booking Date",
                                                        style: TextStyle(
                                                            fontSize: w / 30,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                      margin:
                                                          EdgeInsets.all(10),
                                                      child: Text(
                                                        formatDate(
                                                            DateTime.parse(
                                                                apntmntModel[
                                                                        'bookingDate']
                                                                    .toString()),
                                                            [
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
                                                        style: const TextStyle(
                                                            color: Colors.grey),
                                                      )),
                                                ],
                                              )
                                              //),
                                              ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                              height: h / 10,
                                              // width: w / 10,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
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
                                                        "Start Meeting",
                                                        style: TextStyle(
                                                            fontSize: w / 30,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                      margin:
                                                          const EdgeInsets.all(
                                                              10),
                                                      child: Text(
                                                        formatDate(
                                                            DateTime.parse(
                                                                apntmntModel[
                                                                        'startDate']
                                                                    .toString()),
                                                            [
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
                                                            color: Colors.grey),
                                                      ))
                                                ],
                                              )
                                              //),
                                              ),
                                        )
                                      ],
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 30, top: 20, right: 30),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                              height: h / 10,
                                              // width: w / 10,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
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
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        "End Meeting",
                                                        style: TextStyle(
                                                            fontSize: w / 30,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                      margin:
                                                          EdgeInsets.all(10),
                                                      child: Text(
                                                        formatDate(
                                                            DateTime.parse(
                                                                apntmntModel[
                                                                        'endDate']
                                                                    .toString()),
                                                            [
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
                                                            color: Colors.grey),
                                                      )),
                                                ],
                                              )
                                              //),
                                              ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                              height: h / 10,
                                              // width: w / 10,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
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
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        "Doctor's Name",
                                                        style: TextStyle(
                                                            fontSize: w / 30,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                      margin:
                                                          const EdgeInsets.all(
                                                              10),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                              child: Text(
                                                            apntmntModel[
                                                                    'appointmentUserName'] ??
                                                                "",
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .grey),
                                                          ))
                                                        ],
                                                      ))
                                                ],
                                              )
                                              //),
                                              ),
                                        )
                                      ],
                                    )),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        left: 30, top: 20, right: 30),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                              height: h / 10,
                                              // width: w / 10,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
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
                                                        "Appointment With",
                                                        style: TextStyle(
                                                            fontSize: w / 30,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                      margin:
                                                          EdgeInsets.all(10),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                              child: Text(
                                                            apntmntModel[
                                                                    'appointmentSUserName'] ??
                                                                "",
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .grey),
                                                          ))
                                                        ],
                                                      )),
                                                ],
                                              )
                                              //),
                                              ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                              height: h / 10,
                                              // width: w / 10,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
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
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        "Duration",
                                                        style: TextStyle(
                                                            fontSize: w / 30,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                      margin:
                                                          EdgeInsets.all(10),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            apntmntModel[
                                                                        'duration']
                                                                    .toString() +
                                                                " minutes",
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .grey),
                                                          )
                                                        ],
                                                      ))
                                                ],
                                              )
                                              //),
                                              ),
                                        )
                                      ],
                                    )),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        left: 30, top: 20, right: 30),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                              height: h / 9,
                                              // width: w / 10,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child:

                                                  // Expanded(
                                                  //     flex: 2,
                                                  //     child:
                                                  Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const SizedBox(
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
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        "Share Document",
                                                        style: TextStyle(
                                                            fontSize: w / 30,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ],
                                                  ),
                                                  Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                          padding:
                                                           const   EdgeInsets.all(
                                                                  10),
                                                          width: w / 1.2,
                                                          height: h / 40,
                                                          child: DottedBorder(
                                                              borderType:
                                                                  BorderType
                                                                      .RRect,
                                                              radius: Radius
                                                                  .circular(10),
                                                              dashPattern: [
                                                                8,
                                                                8,
                                                                8,
                                                                8
                                                              ],
                                                              color:
                                                                  Colors.grey,
                                                              strokeWidth: 2,
                                                              child: Card(
                                                                elevation: 0.0,
                                                                color: Colors
                                                                    .white,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                                child:
                                                                    ElevatedButton(
                                                                  style: ElevatedButton.styleFrom(
                                                                      elevation:
                                                                          0.0,
                                                                      shadowColor:
                                                                          Colors
                                                                              .transparent,
                                                                      shape: const RoundedRectangleBorder(
                                                                          borderRadius: BorderRadius.all(Radius.circular(
                                                                              10))),
                                                                      minimumSize:
                                                                          const Size.fromHeight(
                                                                              60),
                                                                      backgroundColor:
                                                                          Colors
                                                                              .white),
                                                                  child:
                                                                      Container(
                                                                    margin: const EdgeInsets
                                                                        .all(5),
                                                                    width:
                                                                        w / 2,
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        const Icon(
                                                                          Icons
                                                                              .upload_file,
                                                                          color: Color.fromARGB(
                                                                              216,
                                                                              2,
                                                                              7,
                                                                              29),
                                                                        ),
                                                                        const SizedBox(
                                                                          width:
                                                                              5,
                                                                        ),
                                                                        Text(
                                                                            'UPLOAD FILE',
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: w / 26,
                                                                              fontWeight: FontWeight.w800,
                                                                              color: const Color.fromARGB(216, 2, 7, 29),
                                                                            ))
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  onPressed:
                                                                      () async {
                                                                    print(
                                                                      widget.AppointmentID[
                                                                          'key1'],
                                                                    );
                                                                    print(
                                                                      widget.AppointmentID[
                                                                          'key2'],
                                                                    );

                                                                    FilePickerResult
                                                                        result =
                                                                        await FilePicker
                                                                            .platform
                                                                            .pickFiles(
                                                                      type: FileType
                                                                          .custom,
                                                                      allowMultiple:
                                                                          false,
                                                                      allowedExtensions: [
                                                                        'jpg',
                                                                        'pdf',
                                                                        'doc',
                                                                        'ppt',
                                                                        'JPEG',
                                                                        'png'
                                                                      ],
                                                                    );
                                                                    if (result !=
                                                                        null) {
                                                                      PlatformFile
                                                                          file =
                                                                          result
                                                                              .files
                                                                              .first;
                                                                      var multipartFile =
                                                                          await MultipartFile
                                                                              .fromFile(
                                                                        file.path,
                                                                      );
                                                                      FormData
                                                                          formData =
                                                                          FormData
                                                                              .fromMap({
                                                                        'file':
                                                                            multipartFile,
                                                                        'MeetingId':
                                                                            widget.AppointmentID['key3'],
                                                                        'Usertype':
                                                                            '2',
                                                                        'Id': widget
                                                                            .AppointmentID['key2'],
                                                                      });

                                                                      UploadShareDocument(
                                                                          formData);
                                                                    } else {}
                                                                  },
                                                                ),
                                                              )))),
                                                ],
                                              )
                                              //),
                                              ),
                                        ),
                                      ],
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 30, top: 20, right: 30),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(

                                              // height: h / 4.2,
                                              // width: w / 10,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child:

                                                  // Expanded(
                                                  //     flex: 2,
                                                  //     child:
                                                  Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
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
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        "Shared Document",
                                                        style: TextStyle(
                                                            fontSize: w / 30,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ],
                                                  ),

                                                  Container(
                                                      width: w,

                                                      // margin: EdgeInsets.only(
                                                      //     left: 5, bottom: 10),
                                                      child: _imageSlider()

                                                      // SingleChildScrollView(
                                                      //     scrollDirection: Axis.horizontal,
                                                      //     child:

                                                      // // : Container(
                                                      // //   padding:
                                                      // //       EdgeInsets.all(
                                                      // //           10),
                                                      // //   child:
                                                      // //       Text(
                                                      // //     'No files uploaded yet',
                                                      // //     style: TextStyle(
                                                      // //         fontSize:
                                                      // //             15,
                                                      // //         color:
                                                      // //             AppColors.red),
                                                      // //   ))

                                                      //     // }

                                                      //     //  ],
                                                      //     )

                                                      )

                                                  // children: [
                                                  // sharedfile['path']

                                                  // Container(
                                                  //   margin: EdgeInsets.all(0),
                                                  //   height: h / 24,
                                                  //   width: w / 4,
                                                  //   decoration: BoxDecoration(
                                                  //       color:
                                                  //           Color.fromARGB(216, 2, 7, 29),
                                                  //       borderRadius:
                                                  //           BorderRadius.circular(10)),
                                                  // ),
                                                ],
                                              )
                                              //),
                                              ),
                                        ),
                                      ],
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, left: 30, right: 30),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0.0,
                                        shadowColor: Colors.transparent,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        minimumSize: const Size.fromHeight(60),
                                        backgroundColor: const Color.fromARGB(
                                            159, 114, 190, 21),
                                      ),
                                      onPressed: () async {
                                        final cameras =
                                            await availableCameras();
                                        Navigator.pushNamed(context,
                                            RoutePaths.testingMicScreen);
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const SizedBox(width: 10),

                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text('              TESTING-MIC',
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
                                const SizedBox(
                                  height: 100,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Center(
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator(color: AppColors.green),
                    ),
                  )));
  }

  Widget _imageSlider() {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return CarouselSlider(
      //carouselController: controllerC,
      options: CarouselOptions(
        // height: h / 8,
        viewportFraction: 0.3,
        aspectRatio: 2.0,
        // aspectRatio: 16 / 9,
        // viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: false,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 5),
        autoPlayAnimationDuration: const Duration(milliseconds: 3000),
        autoPlayCurve: Curves.linear,
        enlargeCenterPage: false,
        scrollDirection: Axis.horizontal,
        //height: 300,
        // onPageChanged: (val, _) {
        //   setState(() {
        //     controllerC.jumpToPage(val);
        //   });
        // }
      ),
      // ignore: can_be_null_after_null_aware
      items: (sharedFile == null)
          ? []
          : sharedFile?.list.map((e) {
              return Container(
                  // alignment: Alignment.center,
                  // width: MediaQuery.of(context).size.width,
                  child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.all(10),
                      height: h / 12,
                      width: h / 12,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(239, 239, 247, 248),
                          borderRadius: BorderRadius.circular(10)),
                      child: Container(
                          //height: h / 40,
                          // width: w / 20,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(239, 239, 247, 248),
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                              padding: const EdgeInsets.all(0),
                              child: Image(
                                image: NetworkImage(
                                  (Api.imageBaseUrl2 + e.path),
                                ),
                                fit: BoxFit.cover,

                                //color: const Color.fromARGB(216, 2, 7, 29),
                                //  size: h / 66,
                              )))),
                  //),
                  InkWell(
                    onTap: () async {
                      var url = Api.imageBaseUrl2 + e.path;
                      // GallerySaver.saveImage(url, albumName: '')
                      //     .then((bool success) {
                      //   setState(() {
                      //     print('Image is saved');
                      //   });
                      // });

                      // GallerySaver.saveImage(
                      //   url,
                      // );
                      showDialog(
                        context: context,
                        builder: (context) => DownloadingDialog(url),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(0),
                      height: h / 26,
                      width: w / 5,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(216, 2, 7, 29),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'DOWNLOAD',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: h / 86,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ));
            }).toList(),
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
                              context,
                              RoutePaths.basicInformationScreen,
                            );
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
                      context,
                      RoutePaths.basicInformationScreen,
                    );
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
                                    // Navigator.of(context).popUntil((route) => route.isFirst);
                                    final storage = FlutterSecureStorage();
                                    storage.deleteAll();
                                    Navigator.pushReplacementNamed(
                                        context, RoutePaths.loginscreen);
                                    // Navigator.of(context)
                                    //     .popUntil((route) => route.isFirst);
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
                      popUpControler.hideMenu();
                      Alert(
                        onWillPopActive: false,
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

  UploadShareDocument(multiformData) async {
    var base = Api.baseUrl;
    final storage = FlutterSecureStorage();
    var token = await storage.read(key: 'token');
    Dio dio = Dio();
    Response response = await dio.post(
      '$base/Admin/UploadShareDocument',
      data: multiformData,
      options: Options(
          contentType: 'multipart/form-data',
          headers: {'authorization': '$token', 'Lang': 'en', 'Status': '1'},
          followRedirects: false,
          validateStatus: (status) {
            return status <= 401;
          }),
    );
    print(response.data);
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
      getSharedDocuments();
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

  getSharedDocuments() async {
    var base = Api.baseUrl;
    final storage = FlutterSecureStorage();
    //var auth = await storage.read(key: 'id');
    var token = await storage.read(key: 'token');
    var photo = await storage.read(key: 'profilePhoto');
    if (photo == "null") {
      profileimage =
          "https://staging.myclickdoctor.com/assets/img/doctor-user.png";
    } else {
      profileimage = Api.imageBaseUrl2 + photo;
    }
    print(profileimage);

    var appntmntId = widget.AppointmentID['key3'];

    var response = await client.get(
      Uri.parse('$base/Admin/GetAppointmentDocumentforMultiple?Id=$appntmntId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': '$token',
        'Lang': 'en',
        'Status': '1'
      },
    );
    if (response.statusCode == 200) {
      var Body = json.decode(response.body);

      sharedFile = DownloadFileModel.fromJson(Body);
      print(sharedFile.list.map((e) => e.path));

      setState(() {
        sharedFile;
        profileimage;
      });

      // sharedfile = Body['list'];

      return sharedFile;
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

//   Get Shared DocumentDetails[httpget]
// https://api.myclickdoctor.com/v3/api/Admin/GetAppointmentDocumentforMultiple
// {
//       Id:  AppointmentCode,
// }
}
