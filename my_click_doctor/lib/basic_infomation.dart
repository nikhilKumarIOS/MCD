import 'dart:convert';

import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_click_doctor/services/api.dart';
import 'package:my_click_doctor/services/router.dart';
import 'package:my_click_doctor/support_screen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;
import 'constants/LocalImages.dart';
import 'constants/appConstants.dart';
import 'doctor_profile.dart';
import 'main.dart';

// void main() {
//   runApp(const BasicInformationScreen());
// }

// class BasicInformationScreen extends StatelessWidget {
//   const BasicInformationScreen({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
//     return const MaterialApp(
//       home: BasicInformationScreenPage(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

class BasicInformationScreen extends StatefulWidget {
  const BasicInformationScreen({Key key}) : super(key: key);

  @override
  State<BasicInformationScreen> createState() =>
      _BasicInformationScreenPageState();
}

class _BasicInformationScreenPageState extends State<BasicInformationScreen> {
  final popUpControler = CustomPopupMenuController();
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController sealnumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  TextEditingController streetnumber = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController zipcode = TextEditingController();
  TextEditingController shortintro = TextEditingController();
  TextEditingController docconsultlimit = TextEditingController();
  TextEditingController countrycode = TextEditingController();
  TextEditingController enterDocCount = TextEditingController();

  bool isSwitched = false;
  bool isSMSSwitched = false;
  bool isEmailSwitched = false;
  bool widgetSelected = true;
  var client = http.Client();
  var UserId = "";
  var busy = false;
  var doctorProfile;
  void initState() {
    super.initState();
    getDoctorProfile();
    // SystemChrome.setEnabledSystemUIOverlays([]);
  }

  UpdateDoctorProfileRequest() async {
    var base = Api.baseUrl;
    final storage = FlutterSecureStorage();
    var userid = await storage.read(key: 'userId');

    var response = await client.post(
      Uri.parse('$base/Admin/UpdateDoctorProfileRequest'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'FirstName': firstname.text.trim(),
        'SecondName': lastname.text.trim(),
        'PhoneNo': phonenumber.text.trim(),
        'YearsOfExperiecne': doctorProfile['yearsOfExperiecne'],
        'MedicalRegistrationNo': doctorProfile['medicalRegistrationNo'],
        'City': city.text.trim(),
        'StreetNumber': streetnumber.text.trim(),
        'Zipcode': zipcode.text.trim(),
        'ShortIntroduction': shortintro.text.trim(),
        'DOB': doctorProfile['dob'],
        'Gander': 'Male',
        'AboutMe': doctorProfile['aboutMe'],
        'UserId': userid,
        'ProfileUrl': doctorProfile['photoUrl'],
        'Country': country.text.trim(),
        'CountryCode': countrycode.text.trim(),
        'MSHCID': doctorProfile['mshcid'],
      }),
    );
    if (response.statusCode == 200) {
      var Body = json.decode(response.body);

      if (Body['code'] == 200) {
        String msg = Body['msg'];
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
                msg,
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
        getDoctorProfile();
      } else {}
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

  EnableDisableAuthentication(authtype, status) async {
    var base = Api.baseUrl;
    final storage = FlutterSecureStorage();
    var userid = await storage.read(key: 'userId');

    var response = await client.post(
      Uri.parse('$base/Account/EnableDisableAuthentication'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'UserId': userid,
        'AuthType': authtype,
        'Status': status,
      }),
    );
    if (response.statusCode == 200) {
      var Body = json.decode(response.body);

      if (Body['code'] == 200) {
        getDoctorProfile();
      } else {
        // return Alert(
        //   closeIcon: null,
        //   style: const AlertStyle(),
        //   context: context,
        //   padding: const EdgeInsets.all(20),
        //   content: Column(
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: const <Widget>[
        //       Image(
        //         image: AssetImage(LocalImages.alert),
        //         width: 50,
        //         height: 50,
        //       ),
        //       SizedBox(height: 20),
        //       Text("Alert",
        //           style: TextStyle(
        //             fontSize: 16,
        //             fontWeight: FontWeight.bold,
        //           ),
        //           textAlign: TextAlign.center),
        //       SizedBox(height: 5),
        //       Text(
        //         "Invalid user name or password!",
        //         textAlign: TextAlign.center,
        //         style: TextStyle(
        //           fontSize: 12,
        //         ),
        //       ),
        //     ],
        //   ),
        //   buttons: [
        //     DialogButton(
        //       margin: const EdgeInsets.only(left: 20),
        //       color: const Color.fromARGB(159, 114, 190, 21),
        //       radius: BorderRadius.circular(20),
        //       onPressed: () async {
        //         Navigator.pop(context);

        //         // await Navigator.pushReplacementNamed(
        //         //     context, RoutePaths.loginscreen);
        //       },
        //       child: const Text(
        //         "Okay ",
        //         style: TextStyle(color: Colors.white, fontSize: 16),
        //       ),
        //     ),
        //   ],
        // ).show();
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

  UpdateDoctorConsultation(count) async {
    var base = Api.baseUrl;
    final storage = FlutterSecureStorage();
    var userid = await storage.read(key: 'userId');

    var response = await client.post(
      Uri.parse('$base/Doctor/UpdateDoctorConsultation'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'Count': count,
        'UserId': userid,
        'Status': true,
      }),
    );
    if (response.statusCode == 200) {
      final storage = FlutterSecureStorage(); //token
      var Body = json.decode(response.body);

      if (Body['code'] == 200) {
        getDoctorProfile();
      } else {
        // return Alert(
        //   closeIcon: null,
        //   style: const AlertStyle(),
        //   context: context,
        //   padding: const EdgeInsets.all(20),
        //   content: Column(
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: const <Widget>[
        //       Image(
        //         image: AssetImage(LocalImages.alert),
        //         width: 50,
        //         height: 50,
        //       ),
        //       SizedBox(height: 20),
        //       Text("Alert",
        //           style: TextStyle(
        //             fontSize: 16,
        //             fontWeight: FontWeight.bold,
        //           ),
        //           textAlign: TextAlign.center),
        //       SizedBox(height: 5),
        //       Text(
        //         "Invalid user name or password!",
        //         textAlign: TextAlign.center,
        //         style: TextStyle(
        //           fontSize: 12,
        //         ),
        //       ),
        //     ],
        //   ),
        //   buttons: [
        //     DialogButton(
        //       margin: const EdgeInsets.only(left: 20),
        //       color: const Color.fromARGB(159, 114, 190, 21),
        //       radius: BorderRadius.circular(20),
        //       onPressed: () async {
        //         Navigator.pop(context);

        //         // await Navigator.pushReplacementNamed(
        //         //     context, RoutePaths.loginscreen);
        //       },
        //       child: const Text(
        //         "Okay ",
        //         style: TextStyle(color: Colors.white, fontSize: 16),
        //       ),
        //     ),
        //   ],
        // ).show();
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

  UploadProfilePic(multiformData) async {
    print(multiformData);
    var base = Api.baseUrl;
    final storage = FlutterSecureStorage();
    var token = await storage.read(key: 'token');

    Dio dio = Dio();
    final response = await dio.post(
      '$base/Admin/UploadDoctorProfilePic',
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
              "Successfully updated",
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
      getDoctorProfile();
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
              "profile has not been updated",
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

  getDoctorProfile() async {
    busy = true;
    var base = Api.baseUrl;
    final storage = FlutterSecureStorage();
    // var auth = await storage.read(key: 'id');
    var token = await storage.read(key: 'token');
    var userID = await storage.read(key: 'userId');
    UserId = userID;

    var response = await client.get(
      Uri.parse('$base/Pharmacy/GetDoctorProfile?UserId=$UserId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': '$token',
        'Lang': 'en',
        'Status': '1'
      },
    );
    if (response.statusCode == 200) {
      var Body = json.decode(response.body);
      if (Body['code'] == 200) {
        doctorProfile = Body['docProfile'];
        isSwitched = doctorProfile['doctorConsultation'] as bool;
        isSMSSwitched = doctorProfile['smsAuth'] as bool;
        isEmailSwitched = doctorProfile['emailAuth'] as bool;
        firstname.text = doctorProfile['firstName'];
        lastname.text = doctorProfile['secondName'];
        sealnumber.text = doctorProfile['medicalRegistrationNo'];
        email.text = doctorProfile['email'];
        countrycode.text = doctorProfile['countryCode'];
        phonenumber.text = doctorProfile['phoneNo'];
        streetnumber.text = doctorProfile['streetNumber'];
        country.text = doctorProfile['country'];
        city.text = doctorProfile['city'];
        zipcode.text = doctorProfile['zipcode'];
        shortintro.text = doctorProfile['shortIntroduction'];
        busy = false;
        setState(() {});
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
    } else {}
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
                          padding: EdgeInsets.symmetric(horizontal: 0),
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
                                                                        EdgeInsets.all(
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
                                                                backgroundImage: (doctorProfile ==
                                                                            null ||
                                                                        doctorProfile['photoUrl'] ==
                                                                            null)
                                                                    ? const AssetImage(
                                                                        LocalImages
                                                                            .profile2)
                                                                    : NetworkImage(Api
                                                                            .imageBaseUrl2 +
                                                                        doctorProfile[
                                                                            'photoUrl']),
                                                              ),
                                                            ),
                                                            // Image(
                                                            //   height: h / 22,
                                                            //   width: h / 22,
                                                            //   fit: BoxFit.fill,
                                                            //   image: (doctorProfile ==
                                                            //           null)
                                                            //       ? const AssetImage(
                                                            //           LocalImages
                                                            //               .profile2)
                                                            //       : NetworkImage(Api
                                                            //               .imageBaseUrl2 +
                                                            //           doctorProfile[
                                                            //               'photoUrl']),
                                                            // ),
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
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 20),
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
                                              Text('Basic Information',
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
                                    padding: EdgeInsets.all(20),
                                    child: Container(
                                      height: h / 7,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                      ),
                                      child: Column(
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
                                                'Profile Picture',
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
                                                        .spaceBetween,
                                                children: [
                                                  CircleAvatar(
                                                    radius: h / 30,
                                                    backgroundColor: Colors
                                                        .grey, // Image radius
                                                    backgroundImage: (doctorProfile ==
                                                                null ||
                                                            doctorProfile[
                                                                    'photoUrl'] ==
                                                                null)
                                                        ? const AssetImage(
                                                            LocalImages
                                                                .profile2)
                                                        : NetworkImage(Api
                                                                .imageBaseUrl2 +
                                                            doctorProfile[
                                                                'photoUrl']),
                                                  ),
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10,
                                                              right: 10),
                                                      child: Container(
                                                          width: w / 1.6,
                                                          height: h / 12,
                                                          child: DottedBorder(
                                                              borderType:
                                                                  BorderType
                                                                      .RRect,
                                                              radius: const Radius
                                                                  .circular(20),
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
                                                                  style: ElevatedButton
                                                                      .styleFrom(
                                                                    elevation:
                                                                        0.0,
                                                                    shadowColor:
                                                                        Colors
                                                                            .transparent,
                                                                    shape: const RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.all(Radius.circular(10))),
                                                                    minimumSize:
                                                                        const Size.fromHeight(
                                                                            60),
                                                                    backgroundColor:
                                                                        Colors
                                                                            .white,
                                                                  ),
                                                                  child:
                                                                      Container(
                                                                    margin: EdgeInsets
                                                                        .all(
                                                                            10),
                                                                    width:
                                                                        w / 2,
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Icon(
                                                                          Icons
                                                                              .file_upload_outlined,
                                                                          color:
                                                                              Colors.grey,
                                                                        ),
                                                                        Text(
                                                                            'Upload profile picture here...',
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: w / 46,
                                                                              fontWeight: FontWeight.w800,
                                                                              color: Colors.grey,
                                                                            ))
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  onPressed:
                                                                      () async {
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
                                                                        'UserId':
                                                                            UserId.toString()
                                                                      });

                                                                      UploadProfilePic(
                                                                          formData);
                                                                    } else {}
                                                                  },
                                                                ),
                                                              )))),
                                                ],
                                              ))
                                        ],
                                      ),
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 20, right: 20, bottom: 20),
                                    child: Container(
                                      height: h / 7,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
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
                                                'First Name *',
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
                                                controller: firstname,
                                                // obscureText: isMail,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: w / 30,
                                                ),
                                                decoration: InputDecoration(
                                                    hintText:
                                                        (doctorProfile != null)
                                                            ? doctorProfile[
                                                                'firstName']
                                                            : "",
                                                    hintStyle: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: w / 30,
                                                    ),

                                                    //suffixIcon: Icon(Icons.timer),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      borderSide:
                                                          BorderSide.none,
                                                    ),
                                                    fillColor: Color.fromARGB(
                                                        239, 239, 247, 248),
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
                                        borderRadius: BorderRadius.circular(10),
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
                                                'Last Name *',
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
                                                controller: lastname,
                                                // obscureText: isMail,
                                                decoration: InputDecoration(
                                                    hintText:
                                                        (doctorProfile != null)
                                                            ? doctorProfile[
                                                                'secondName']
                                                            : "",
                                                    hintStyle: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: w / 30,
                                                    ),
                                                    // suffixIcon: Icon(
                                                    //   Icons.keyboard_arrow_down_outlined,
                                                    // ),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      borderSide:
                                                          BorderSide.none,
                                                    ),
                                                    fillColor: Color.fromARGB(
                                                        239, 239, 247, 248),
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
                                        borderRadius: BorderRadius.circular(10),
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
                                                'Seal Number *',
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
                                                controller: sealnumber,
                                                // obscureText: isMail,
                                                decoration: InputDecoration(
                                                    hintText: (doctorProfile !=
                                                            null)
                                                        ? doctorProfile[
                                                            'medicalRegistrationNo']
                                                        : "",
                                                    hintStyle: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: w / 30,
                                                    ),

                                                    // hintText: 'Enter Email',

                                                    // hintStyle: TextStyle( color: Colors.white),

                                                    // suffixIcon: Icon(
                                                    //   Icons.group,
                                                    // ),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      borderSide:
                                                          BorderSide.none,
                                                    ),
                                                    fillColor: Color.fromARGB(
                                                        239, 239, 247, 248),
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
                                        borderRadius: BorderRadius.circular(10),
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
                                                'E-Mail Address *',
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
                                                controller: email,
                                                // obscureText: isMail,
                                                decoration: InputDecoration(
                                                    hintText: (doctorProfile !=
                                                            null)
                                                        ? doctorProfile['email']
                                                        : "",
                                                    hintStyle: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: w / 30,
                                                    ),
                                                    // hintText: 'Enter Email',

                                                    // hintStyle: TextStyle( color: Colors.white),

                                                    // suffixIcon: Icon(
                                                    //   Icons.menu_book_outlined,
                                                    // ),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      borderSide:
                                                          BorderSide.none,
                                                    ),
                                                    fillColor: Color.fromARGB(
                                                        239, 239, 247, 248),
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
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                      ),
                                      child: Column(
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
                                                'Phone Number *',
                                                style: TextStyle(
                                                    fontSize: w / 30,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),

                                          // Padding(
                                          //   padding: EdgeInsets.all(10),
                                          //   child: TextFormField(
                                          //       controller: phonenumber,
                                          //       // obscureText: isMail,
                                          //       decoration: InputDecoration(
                                          //           hintText: doctorProfile[
                                          //               'phoneNo'],
                                          //           hintStyle: TextStyle(
                                          //             color: Colors.black,
                                          //             fontSize: w / 30,
                                          //           ),
                                          //           // hintText: 'Enter Email',

                                          //           // hintStyle: TextStyle( color: Colors.white),

                                          //           // suffixIcon: Icon(
                                          //           //   Icons.menu_book_outlined,
                                          //           // ),
                                          //           border: OutlineInputBorder(
                                          //             borderRadius:
                                          //                 BorderRadius.circular(
                                          //                     15),
                                          //             borderSide:
                                          //                 BorderSide.none,
                                          //           ),
                                          //           fillColor: Color.fromARGB(
                                          //               239, 239, 247, 248),
                                          //           filled: true)),
                                          // ),

                                          Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: TextFormField(
                                                        controller: countrycode,
                                                        // obscureText: isMail,
                                                        decoration:
                                                            InputDecoration(
                                                                hintText: (doctorProfile !=
                                                                        null)
                                                                    ? doctorProfile[
                                                                        'countryCode']
                                                                    : "",
                                                                hintStyle:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      w / 30,
                                                                ),

                                                                // hintText: 'Enter Email',

                                                                // hintStyle: TextStyle( color: Colors.white),

                                                                // suffixIcon: Icon(
                                                                //   Icons.menu_book_outlined,
                                                                // ),
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
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    flex: 3,
                                                    child: TextFormField(

                                                        // controller: nameController,
                                                        // obscureText: isMail,
                                                        decoration:
                                                            InputDecoration(
                                                                hintText: (doctorProfile !=
                                                                        null)
                                                                    ? doctorProfile[
                                                                        'phoneNo']
                                                                    : "",
                                                                hintStyle:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      w / 30,
                                                                ),
                                                                // hintText: 'Enter Email',

                                                                // hintStyle: TextStyle( color: Colors.white),

                                                                // suffixIcon: Icon(
                                                                //   Icons.menu_book_outlined,
                                                                // ),
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
                                                  )
                                                ],
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
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                      ),
                                      child: Column(
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
                                                'Gender *',
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
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Color.fromARGB(
                                                    239, 239, 247, 248),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 20),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            'Male',
                                                            style: TextStyle(
                                                                letterSpacing:
                                                                    0.5,
                                                                fontSize:
                                                                    w / 30,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                          Icon(
                                                            Icons
                                                                .keyboard_arrow_down_sharp,
                                                            color: Colors.grey,
                                                          ),
                                                        ],
                                                      )),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 20, right: 20, bottom: 20),
                                    child: Container(
                                      height: h / 2.7,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                      ),
                                      child: Column(
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
                                                'Address *',
                                                style: TextStyle(
                                                    fontSize: w / 30,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'Street Number *',
                                                style: TextStyle(
                                                    fontSize: w / 50,
                                                    color: Colors.grey[500],
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: TextFormField(
                                                        controller:
                                                            streetnumber,
                                                        // obscureText: isMail,
                                                        decoration:
                                                            InputDecoration(
                                                                hintText: (doctorProfile !=
                                                                        null)
                                                                    ? doctorProfile[
                                                                        'streetNumber']
                                                                    : "",
                                                                hintStyle:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      w / 30,
                                                                ),

                                                                // hintText: 'Enter Email',

                                                                // hintStyle: TextStyle( color: Colors.white),

                                                                // suffixIcon: Icon(
                                                                //   Icons.menu_book_outlined,
                                                                // ),
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
                                              )),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  top: 5,
                                                  left: 10,
                                                  right: 10,
                                                  bottom: 5),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        'Country',
                                                        style: TextStyle(
                                                            fontSize: w / 50,
                                                            color: Colors
                                                                .grey[500],
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      )),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        'City',
                                                        style: TextStyle(
                                                            fontSize: w / 50,
                                                            color: Colors
                                                                .grey[500],
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ))
                                                ],
                                              )),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 10,
                                                  right: 10,
                                                  bottom: 10),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: TextFormField(
                                                        controller: country,
                                                        // obscureText: isMail,
                                                        decoration:
                                                            InputDecoration(
                                                                hintText: (doctorProfile !=
                                                                        null)
                                                                    ? doctorProfile[
                                                                        'country']
                                                                    : "",
                                                                hintStyle:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      w / 30,
                                                                ),

                                                                // hintText: 'Enter Email',

                                                                // hintStyle: TextStyle( color: Colors.white),

                                                                // suffixIcon: Icon(
                                                                //   Icons.menu_book_outlined,
                                                                // ),
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
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: TextFormField(
                                                        controller: city,
                                                        // obscureText: isMail,
                                                        decoration:
                                                            InputDecoration(
                                                                hintText: (doctorProfile !=
                                                                        null)
                                                                    ? doctorProfile[
                                                                        'city']
                                                                    : "",
                                                                hintStyle:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      w / 30,
                                                                ),

                                                                // hintText: 'Enter Email',

                                                                // hintStyle: TextStyle( color: Colors.white),

                                                                // suffixIcon: Icon(
                                                                //   Icons.menu_book_outlined,
                                                                // ),
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
                                                  )
                                                ],
                                              )),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5,
                                                  left: 10,
                                                  right: 10,
                                                  bottom: 0),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        'ZIP Code',
                                                        style: TextStyle(
                                                            fontSize: w / 50,
                                                            color: Colors
                                                                .grey[500],
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      )),
                                                ],
                                              )),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5,
                                                  left: 10,
                                                  right: 10,
                                                  bottom: 0),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: TextFormField(
                                                        controller: zipcode,
                                                        // obscureText: isMail,
                                                        decoration:
                                                            InputDecoration(
                                                                hintText: (doctorProfile !=
                                                                        null)
                                                                    ? doctorProfile[
                                                                        'zipcode']
                                                                    : "",
                                                                hintStyle:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      w / 30,
                                                                ),

                                                                // hintText: 'Enter Email',

                                                                // hintStyle: TextStyle( color: Colors.white),

                                                                // suffixIcon: Icon(
                                                                //   Icons.menu_book_outlined,
                                                                // ),
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
                                              )),
                                        ],
                                      ),
                                    )),
                                // Padding(
                                //     padding: EdgeInsets.only(
                                //         left: 20, right: 20, bottom: 20),
                                //     child: Container(
                                //       height: h / 7,
                                //       decoration: BoxDecoration(
                                //         borderRadius: BorderRadius.circular(10),
                                //         color: Colors.white,
                                //       ),
                                //       child: Column(
                                //         children: [
                                //           SizedBox(
                                //             height: 10,
                                //           ),
                                //           Row(
                                //             mainAxisAlignment:
                                //                 MainAxisAlignment.start,
                                //             children: [
                                //               Container(
                                //                 height: w / 25,
                                //                 color: Colors.black,
                                //                 width: 5,
                                //               ),
                                //               SizedBox(
                                //                 width: 10,
                                //               ),
                                //               Text(
                                //                 'Short Biography',
                                //                 style: TextStyle(
                                //                     fontSize: w / 30,
                                //                     color: Colors.black,
                                //                     fontWeight:
                                //                         FontWeight.w500),
                                //               ),
                                //             ],
                                //           ),
                                //           Padding(
                                //             padding: EdgeInsets.all(10),
                                //             child: TextFormField(

                                //                 // controller: nameController,
                                //                 // obscureText: isMail,
                                //                 decoration: InputDecoration(
                                //                     hintText: doctorProfile[
                                //                         'shortIntroduction'],
                                //                     hintStyle: TextStyle(
                                //                       color: Colors.black,
                                //                       fontSize: w / 30,
                                //                     ),

                                //                     // hintText: 'Enter Email',

                                //                     // hintStyle: TextStyle( color: Colors.white),

                                //                     // suffixIcon: Icon(
                                //                     //   Icons.menu_book_outlined,
                                //                     // ),
                                //                     border: OutlineInputBorder(
                                //                       borderRadius:
                                //                           BorderRadius.circular(
                                //                               15),
                                //                       borderSide:
                                //                           BorderSide.none,
                                //                     ),
                                //                     fillColor: Color.fromARGB(
                                //                         239, 239, 247, 248),
                                //                     filled: true)),
                                //           ),
                                //         ],
                                //       ),
                                //     )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 20, right: 20, bottom: 20),
                                    child: Container(
                                      height: h / 7,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
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
                                                'Short Introduction',
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
                                                controller: shortintro,
                                                // obscureText: isMail,
                                                decoration: InputDecoration(
                                                    hintMaxLines: 4,
                                                    hintText: (doctorProfile !=
                                                            null)
                                                        ? doctorProfile[
                                                            'shortIntroduction']
                                                        : "",
                                                    hintStyle: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: w / 30,
                                                    ),

                                                    // hintText: 'Enter Email',

                                                    // hintStyle: TextStyle( color: Colors.white),

                                                    // suffixIcon: Icon(
                                                    //   Icons.menu_book_outlined,
                                                    // ),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      borderSide:
                                                          BorderSide.none,
                                                    ),
                                                    fillColor: Color.fromARGB(
                                                        239, 239, 247, 248),
                                                    filled: true)),
                                          ),
                                        ],
                                      ),
                                    )),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 20, right: 20, bottom: 20),
                                  child: GestureDetector(
                                    onTap: () {
                                      UpdateDoctorProfileRequest();
                                    },
                                    child: Container(
                                      height: h / 14,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color:
                                            Color.fromARGB(159, 114, 190, 21),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(left: 20),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(''),
                                                  Text(''),
                                                  Text(''),
                                                  Text(''),
                                                  Text(''),
                                                  Text(''),
                                                  Text(
                                                    'REQUEST PROFILE CHANGE',
                                                    style: TextStyle(
                                                        letterSpacing: 0.5,
                                                        fontSize: w / 30,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500),
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
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 20, right: 20, bottom: 20),
                                    child: Container(
                                      height: h / 6,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
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
                                                'Doctor Consultation Status',
                                                style: TextStyle(
                                                    fontSize: w / 30,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  top: 10,
                                                  left: 10,
                                                  right: 10,
                                                  bottom: 5),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                      child: Text(
                                                    '',
                                                    style: TextStyle(
                                                        fontSize: w / 50,
                                                        color: Colors.grey[500],
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  )),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                      flex: 4,
                                                      child: Text(
                                                        'Doctor Consultation Limit',
                                                        style: TextStyle(
                                                            fontSize: w / 50,
                                                            color: Colors
                                                                .grey[500],
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ))
                                                ],
                                              )),
                                          Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Switch(
                                                      value: isSwitched,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          isSwitched = (value);
                                                          print(isSwitched);

                                                          if (isSwitched ==
                                                              true) {
                                                            Alert(
                                                              onWillPopActive:
                                                                  false,
                                                              closeIcon: null,
                                                              style:
                                                                  AlertStyle(),
                                                              context: context,
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(20),
                                                              content: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: <
                                                                    Widget>[
                                                                  // Image(
                                                                  //   image: AssetImage(
                                                                  //       LocalImages
                                                                  //           .alert),
                                                                  //   width: 50,
                                                                  //   height: 50,
                                                                  // ),
                                                                  SizedBox(
                                                                      height:
                                                                          20),
                                                                  Text(
                                                                      "Enter doctor consultation limit",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center),
                                                                  SizedBox(
                                                                      height:
                                                                          5),
                                                                  //  Expanded(
                                                                  // flex: 1,
                                                                  //  child:

                                                                  TextFormField(
                                                                      controller:
                                                                          enterDocCount,
                                                                      // obscureText: isMail,
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            w / 30,
                                                                      ),
                                                                      decoration: InputDecoration(
                                                                          // hintText: (doctorProfile != null) ? doctorProfile['doctorConslutationCount'].toString() : 0.toString(),
                                                                          hintStyle: TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize:
                                                                                w / 30,
                                                                          ),
                                                                          border: OutlineInputBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(15),
                                                                            borderSide:
                                                                                BorderSide.none,
                                                                          ),
                                                                          fillColor: Color.fromARGB(239, 239, 247, 248),
                                                                          filled: true)),
                                                                  // ),
                                                                ],
                                                              ),
                                                              buttons: [
                                                                DialogButton(
                                                                  margin: const EdgeInsets
                                                                          .only(
                                                                      left: 20),
                                                                  color: Colors
                                                                      .red[500],
                                                                  radius: BorderRadius
                                                                      .circular(
                                                                          20),
                                                                  onPressed:
                                                                      () async {
                                                                    Navigator.pop(
                                                                        context);
                                                                    UpdateDoctorConsultation(
                                                                        enterDocCount
                                                                            .text
                                                                            .trim());
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                    "Done",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            16),
                                                                  ),
                                                                ),
                                                                DialogButton(
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          right:
                                                                              20,
                                                                          left:
                                                                              10),
                                                                  color: Colors
                                                                          .grey[
                                                                      800],
                                                                  radius: BorderRadius
                                                                      .circular(
                                                                          20),
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          context),
                                                                  child:
                                                                      const Text(
                                                                    "Cancel",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            16),
                                                                  ),
                                                                ),
                                                              ],
                                                            ).show();
                                                          } else {}
                                                        });
                                                      },
                                                      activeTrackColor: Colors
                                                          .lightGreenAccent,
                                                      activeColor: Colors.green,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 4,
                                                    child: TextFormField(
                                                        controller:
                                                            docconsultlimit,
                                                        // obscureText: isMail,
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: w / 30,
                                                        ),
                                                        decoration:
                                                            InputDecoration(
                                                                hintText: (doctorProfile !=
                                                                        null)
                                                                    ? doctorProfile[
                                                                            'doctorConslutationCount']
                                                                        .toString()
                                                                    : 0
                                                                        .toString(),
                                                                hintStyle:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      w / 30,
                                                                ),

                                                                // hintText: 'Enter Email',

                                                                // hintStyle: TextStyle( color: Colors.white),

                                                                // suffixIcon: Icon(
                                                                //   Icons.menu_book_outlined,
                                                                // ),
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
                                              )),
                                        ],
                                      ),
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 20, right: 20, bottom: 20),
                                    child: Container(
                                      height: h / 6,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
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
                                                'Authentication setting',
                                                style: TextStyle(
                                                    fontSize: w / 30,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  top: 10,
                                                  left: 10,
                                                  right: 10,
                                                  bottom: 5),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        'Email Authentication',
                                                        style: TextStyle(
                                                            fontSize: w / 50,
                                                            color: Colors
                                                                .grey[500],
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      )),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        'SMS Authentication',
                                                        style: TextStyle(
                                                            fontSize: w / 50,
                                                            color: Colors
                                                                .grey[500],
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ))
                                                ],
                                              )),
                                          Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Switch(
                                                      value: isEmailSwitched,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          isEmailSwitched =
                                                              (value);
                                                          print(
                                                              isEmailSwitched);
                                                          EnableDisableAuthentication(
                                                              'Email',
                                                              isEmailSwitched);
                                                        });
                                                      },
                                                      activeTrackColor: Colors
                                                          .lightGreenAccent,
                                                      activeColor: Colors.green,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 4,
                                                    child: Switch(
                                                      value: isSMSSwitched,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          isSMSSwitched =
                                                              (value);
                                                          print(isSMSSwitched);
                                                          EnableDisableAuthentication(
                                                              'SMS',
                                                              isSMSSwitched);
                                                        });
                                                      },
                                                      activeTrackColor: Colors
                                                          .lightGreenAccent,
                                                      activeColor: Colors.green,
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ],
                                      ),
                                    )),
                                SizedBox(
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
                  ))
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
