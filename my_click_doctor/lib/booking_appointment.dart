import 'dart:convert';

import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';
import 'package:my_click_doctor/services/api.dart';
import 'package:my_click_doctor/services/router.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'constants/LocalImages.dart';
import 'constants/appConstants.dart';
import 'package:http/http.dart' as http;

class BookingAppointmentScreen extends StatefulWidget {
  const BookingAppointmentScreen({Key key}) : super(key: key);

  @override
  State<BookingAppointmentScreen> createState() =>
      _BookingAppointmentScreenPageState();
}

class _BookingAppointmentScreenPageState
    extends State<BookingAppointmentScreen> {
  final popUpControler = CustomPopupMenuController();
  TextEditingController subjectC = TextEditingController();
  TextEditingController nmbrOfAttendC = TextEditingController();
  bool isSwitched = true;
  bool widgetSelected = true;
  var selectedVal = null;
  var selectedValMin = null;
  var selectedValType = null;
  var checkEmptyDate = false;
  var checkEmptyDuration = false;
  var checkEmptyType = false;

  var profileImage = "";
  String _date = "";
  String _datee = "";
  DateTime dateNew;
  var max = 0;
  var busy = false;
  var client = http.Client();
  final formKey = GlobalKey<FormState>();
  var profileimage = "";

  void initState() {
    super.initState();
    showList();
    // SystemChrome.setEnabledSystemUIOverlays([]);
  }

  SubmitForm() async {
    busy = true;
    var t = selectedValMin.split('');
    var y = t[0] + t[1] + t[2].trim();

    var base = Api.baseUrl;
    final storage = FlutterSecureStorage();

    var token = await storage.read(key: 'token');
    var id = await storage.read(key: 'id');

    var response = await client.post(
      Uri.parse('$base/Doctor/PostDoctorNewFreeSlot'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': '$token',
        'Lang': 'en',
        'Status': '1'
      },
      body: jsonEncode(<String, dynamic>{
        'ToTime': dateNew.toString(),
        'Duration': int.parse(y.trim()),
        'Type': selectedValType,
        'MaxCount': nmbrOfAttendC.text,
        'Subject': subjectC.text,
        'DocId': id.toString(),
        'SlotType': 'other'
      }),
    );
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      var t = body['code'];
      busy = false;

      if (t == 200) {
        Alert(
          closeIcon: InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(
                    context, RoutePaths.timeWindowManagementSCreen);
              },
              child: Icon(Icons.close_rounded)),
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
              color: const Color.fromARGB(159, 114, 190, 21),
              radius: BorderRadius.circular(20),
              onPressed: () async {
                Navigator.pop(context);

                Navigator.pushReplacementNamed(
                    context, RoutePaths.timeWindowManagementSCreen);
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
              SizedBox(height: 5),
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
      busy = false;
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
      busy = false;
      max = body['doctorCallCount'];

      setState(() {});
    } else {
      busy = false;
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
          ? Form(
              key: formKey,
              child: SizedBox(
                height: h,
                width: w,
                child: Stack(
                  children: [
                    //  Align(
                    //  alignment: Alignment.topCenter,
                    //   child:
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                          height: h / 1.2,
                          child: SingleChildScrollView(

                              // color: Colors.red,
                              child: Column(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Container(
                                    // height: h / 7,
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
                                              'From *',
                                              style: TextStyle(
                                                  fontSize: w / 30,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                DatePicker.showDateTimePicker(
                                                    context,
                                                    theme:
                                                        const DatePickerTheme(
                                                      containerHeight: 210.0,
                                                    ),
                                                    showTitleActions: true,
                                                    minTime:
                                                        DateTime(1900, 1, 1),
                                                    maxTime: DateTime.now(),
                                                    onConfirm: (date) {
                                                  dateNew = date;
                                                  print('confirm $date');
                                                  _date =
                                                      "${date.day}/${date.month}/${date.year}"
                                                      " ${date.hour}:${date.minute}";
                                                  _datee =
                                                      "${date.year}-${date.month}-${date.day}"
                                                      " ${date.hour}:${date.minute}:${date.second}";

                                                  setState(() {});
                                                },
                                                    currentTime: DateTime.now(),
                                                    locale: LocaleType.en);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10))),
                                                minimumSize:
                                                    const Size.fromHeight(55),
                                                elevation: 0.0,
                                                backgroundColor:
                                                    const Color.fromARGB(
                                                        239, 239, 247, 248),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    _date,
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12,
                                                        decoration:
                                                            TextDecoration
                                                                .none),
                                                  ),
                                                  const Icon(
                                                    Icons.watch_later_outlined,
                                                    color: Colors.grey,
                                                  )
                                                ],
                                              ),
                                            )),
                                        (checkEmptyDate != true)
                                            ? const SizedBox()
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Text(
                                                  '*Date is required',
                                                  style: TextStyle(
                                                    fontSize: w / 30,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              )
                                      ],
                                    ),
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 20, right: 20, bottom: 20),
                                  child: Container(
                                    //height: h / 7,
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
                                              'Duration *',
                                              style: TextStyle(
                                                  fontSize: w / 30,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Container(
                                              height: h / 14,
                                              width: w,
                                              decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    239, 239, 247, 248),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Container(
                                                width: w,
                                                margin:
                                                    EdgeInsets.only(left: 10),
                                                child: DropdownButton<String>(
                                                  hint: const Text(
                                                    '',
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 10,
                                                        decoration:
                                                            TextDecoration
                                                                .none),
                                                  ),
                                                  isExpanded: true,
                                                  value: selectedValMin,
                                                  underline: SizedBox(),
                                                  items: <String>[
                                                    '30 minutes',
                                                    '60 minutes',
                                                    '120 minutes',
                                                  ].map((String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Text(
                                                        value,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            decoration:
                                                                TextDecoration
                                                                    .none),
                                                      ),
                                                    );
                                                  }).toList(),
                                                  onChanged: (_) {
                                                    setState(() {
                                                      selectedValMin = _;
                                                    });
                                                  },
                                                ),
                                              )),
                                        ),
                                        (checkEmptyDuration != true)
                                            ? const SizedBox()
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Text(
                                                  '*Duration is required',
                                                  style: TextStyle(
                                                    fontSize: w / 30,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              )
                                      ],
                                    ),
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 20, right: 20, bottom: 20),
                                  child: Container(
                                    // height: h / 7,
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
                                              'Select Type *',
                                              style: TextStyle(
                                                  fontSize: w / 30,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500),
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
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Container(
                                                width: w,
                                                margin:
                                                    EdgeInsets.only(left: 10),
                                                child: DropdownButton<String>(
                                                  hint: const Text(
                                                    '',
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 10,
                                                        decoration:
                                                            TextDecoration
                                                                .none),
                                                  ),
                                                  isExpanded: true,
                                                  value: selectedValType,
                                                  underline: SizedBox(),
                                                  items: <String>[
                                                    'Lecture',
                                                    'Q&A',
                                                  ].map((String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Text(
                                                        value,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            decoration:
                                                                TextDecoration
                                                                    .none),
                                                      ),
                                                    );
                                                  }).toList(),
                                                  onChanged: (_) {
                                                    setState(() {
                                                      selectedValType = _;
                                                    });
                                                  },
                                                ),
                                              )),
                                        ),
                                        (checkEmptyType != true)
                                            ? const SizedBox()
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Text(
                                                  '*Type is required',
                                                  style: TextStyle(
                                                    fontSize: w / 30,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              )
                                      ],
                                    ),
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 20, right: 20, bottom: 20),
                                  child: Container(
                                    //   height: h / 7,
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
                                              'Max No. of Attendees *',
                                              style: TextStyle(
                                                  fontSize: w / 30,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: TextFormField(
                                              controller: nmbrOfAttendC,
                                              // onChanged: (value) => {
                                              //       print(value),
                                              //     },
                                              validator: MultiValidator(
                                                [
                                                  // RequiredValidator(
                                                  //     errorText:
                                                  //         '*Attendees is required'),
                                                  RangeValidator(
                                                      min: 0,
                                                      max: max,
                                                      errorText:
                                                          "Attendees cannot be greater than $max")
                                                ],
                                              ),
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              // obscureText: isMail,

                                              keyboardType:
                                                  TextInputType.number,
                                              style: const TextStyle(
                                                  color: Colors.black),
                                              decoration: InputDecoration(
                                                  suffixIcon: const Icon(
                                                    Icons.group,
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    borderSide: BorderSide.none,
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
                                    //    height: h / 7,
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
                                              'Subject *',
                                              style: TextStyle(
                                                  fontSize: w / 30,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(10),
                                          child: TextFormField(
                                              // validator: MultiValidator(
                                              //   [
                                              //     RequiredValidator(
                                              //         errorText:
                                              //             '*Subject is required'),
                                              //   ],
                                              // ),
                                              controller: subjectC,
                                              // obscureText: isMail,
                                              style: TextStyle(
                                                  color: Colors.black),
                                              decoration: InputDecoration(

                                                  // hintText: 'Enter Email',

                                                  // hintStyle: TextStyle( color: Colors.white),

                                                  suffixIcon: const Icon(
                                                    Icons.menu_book_outlined,
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    borderSide: BorderSide.none,
                                                  ),
                                                  fillColor:
                                                      const Color.fromARGB(
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
                                    //   height: h / 7,
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
                                              'Doctor',
                                              style: TextStyle(
                                                  fontSize: w / 30,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                            padding: EdgeInsets.all(10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Switch(
                                                  value: true, //isSwitched,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      // isSwitched = value;
                                                      print(isSwitched);
                                                    });
                                                  },
                                                  activeTrackColor:
                                                      Colors.lightGreenAccent,
                                                  activeColor: Colors.green,
                                                ),
                                              ],
                                            )),
                                      ],
                                    ),
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, bottom: 20),
                                  child: Container(
                                      child: InkWell(
                                    onTap: (_date == "") ||
                                            (selectedValMin == null) ||
                                            (selectedValType == null) ||
                                            (nmbrOfAttendC.text == "") ||
                                            (subjectC.text == "")
                                        ? null
                                        : () {
                                            if (formKey.currentState
                                                .validate()) {
                                              if (_date == "") {
                                                checkEmptyDate = true;
                                              } else if (selectedValMin ==
                                                  null) {
                                                checkEmptyDuration = true;
                                              } else if (selectedValType ==
                                                  null) {
                                                checkEmptyType = true;
                                              } else {
                                                SubmitForm();
                                              }
                                            }
                                          },
                                    child: Container(
                                      height: h / 14,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: (_date == "") ||
                                                (selectedValMin == null) ||
                                                (selectedValType == null) ||
                                                (nmbrOfAttendC.text == "") ||
                                                (subjectC.text == "")
                                            ? const Color.fromARGB(
                                                132, 158, 158, 158)
                                            : const Color.fromARGB(
                                                159, 114, 190, 21),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20),
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
                                                    'SUBMIT',
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
                                  ))),
                              const SizedBox(
                                height: 50,
                              )
                            ],
                          )
                              // )
                              )),
                    ),

                    Container(
                        color: AppColors.backgroundColor2,
                        height: 105,
                        width: w,
                        padding: const EdgeInsets.only(left: 00),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Ink(
                                    decoration: const ShapeDecoration(
                                        shape: CircleBorder(),
                                        color:
                                            Color.fromARGB(255, 204, 204, 204)),
                                    child: IconButton(
                                      icon: const Icon(Icons.arrow_back),
                                      iconSize: h / 40,
                                      color: Colors.black,
                                      onPressed: () async {
                                        Navigator.pop(context);
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
                                              padding: const EdgeInsets.only(
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
                                                    controller: popUpControler,
                                                    child: CircleAvatar(
                                                      radius: h / 40,
                                                      backgroundColor:
                                                          Colors.grey[200],
                                                      child: CircleAvatar(
                                                        radius: h / 22,
                                                        backgroundImage:
                                                            (profileimage ==
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
                            ),
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
                                                  'assets/four-dots.png')),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text('Time window management',
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
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        )),
                  ],
                ),
              ))
          : Center(
              child: Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                height: 40,
                width: 40,
                child: CircularProgressIndicator(color: AppColors.green),
              ),
            )),
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
                                    final storage = FlutterSecureStorage();
                                    storage.deleteAll();
                                    Navigator.pushReplacementNamed(
                                        context, RoutePaths.loginscreen);
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
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
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
                              final storage = FlutterSecureStorage();
                              storage.deleteAll();
                              Navigator.pushReplacementNamed(
                                  context, RoutePaths.loginscreen);
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
