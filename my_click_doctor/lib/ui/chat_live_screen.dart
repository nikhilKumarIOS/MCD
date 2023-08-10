import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:my_click_doctor/services/router.dart';

import 'package:rflutter_alert/rflutter_alert.dart';

import 'basic_infomation.dart';
import 'booking_appointment.dart';
import 'doctor_profile.dart';

class ChatLiveScreen extends StatefulWidget {
  const ChatLiveScreen({Key key}) : super(key: key);

  @override
  State<ChatLiveScreen> createState() => _ChatLiveScreenPageState();
}

class _ChatLiveScreenPageState extends State<ChatLiveScreen> {
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
            Container(
                color: const Color.fromARGB(239, 239, 247, 248),
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 20),
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
                        padding: const EdgeInsets.only(
                            top: 20, left: 20, right: 20, bottom: 40),
                        child: Row(
                          children: [
                            Container(
                              width: w / 1.5,
                              height: h / 13,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0.0,
                                    shadowColor: Colors.transparent,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(40))),
                                    minimumSize: const Size.fromHeight(60),
                                    backgroundColor: Colors.white,
                                  ),
                                  onPressed: () async {
                                    Navigator.pushNamed(context,
                                        RoutePaths.doctorProfileScreen);
                                    // Navigator.
                                    // Navigator.pop(context);
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                                                Text('James Russell',
                                                    style: TextStyle(
                                                      fontSize: w / 30,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black,
                                                    )),
                                                SizedBox(height: 5),
                                                Text('Online',
                                                    style: TextStyle(
                                                      fontSize: w / 40,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.grey,
                                                    )),
                                              ])
                                        ],
                                      ),

                                      //   ],
                                      // )
                                    ],
                                  )),
                            ),
                            SizedBox(
                              width: 32,
                            ),
                            Row(
                              children: [
                                ClipOval(
                                  child: Material(
                                    color: const Color.fromARGB(
                                        159, 114, 190, 21), // Button color
                                    child: InkWell(
                                      splashColor: Colors.black, // Splash color
                                      onTap: () {
                                        Navigator.pushNamed(context,
                                            RoutePaths.bookAppointmentScreen);
                                      },
                                      child: Container(
                                          margin: EdgeInsets.all(10),
                                          width: h / 26,
                                          height: h / 26,
                                          child: const Image(
                                            color:
                                                Color.fromARGB(216, 2, 7, 29),
                                            image: AssetImage(
                                                'assets/green-phone.png'),
                                          )),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                    Container(
                      width: w,
                      height: h / 1.6,
                      color: const Color.fromARGB(239, 239, 247, 248),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                        width: w / 1.5,
                                        height: h / 8,
                                        decoration: const BoxDecoration(
                                          color: Color.fromARGB(216, 2, 7, 29),
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(30.0),
                                            bottomLeft: Radius.circular(30.0),
                                            topLeft: Radius.circular(30.0),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(20),
                                          child: Text(
                                            'Lorem ipsum dolor sit amet, consectetur adipisc-ing elit. Suspendisse condimentum hendreritfelis, eu posuere magna gravida non. Nunc quisquam in massa rutrum mattis...',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: w / 37),
                                          ),
                                        )),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                        width: w / 1.5,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              '10:00 AM',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: w / 37),
                                            ),
                                          ],
                                        ))
                                  ],
                                ),
                                SizedBox(
                                  width: 18,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                        width: w / 1.5,
                                        height: h / 15,
                                        decoration: const BoxDecoration(
                                          color: Color.fromARGB(216, 2, 7, 29),
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(30.0),
                                            bottomLeft: Radius.circular(30.0),
                                            topLeft: Radius.circular(30.0),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(20),
                                          child: Text(
                                            'Lorem ipsum dolor sit amet',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: w / 37),
                                          ),
                                        )),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                        width: w / 1.5,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              '10:00 AM',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: w / 37),
                                            ),
                                          ],
                                        ))
                                  ],
                                ),
                                SizedBox(
                                  width: 18,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                        width: w / 1.5,
                                        height: h / 12,
                                        decoration: const BoxDecoration(
                                          color: Color.fromARGB(216, 2, 7, 29),
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(30.0),
                                            bottomLeft: Radius.circular(30.0),
                                            topLeft: Radius.circular(30.0),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(20),
                                          child: Text(
                                            'Lorem ipsum dolor sit amet, consectetur adipi-sing elit. Nunc sed venenatis lacus.',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: w / 37),
                                          ),
                                        )),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                        width: w / 1.5,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              '10:00 AM',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: w / 37),
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  width: 18,
                                )
                              ],
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 40, left: 20, right: 10, bottom: 10),
                                  child: CircleAvatar(
                                    radius: h / 40,
                                    backgroundColor:
                                        Colors.grey, // Image radius
                                    backgroundImage: const AssetImage(
                                        'assets/male-user.png'),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        width: w / 1.5,
                                        height: h / 12,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(30.0),
                                            bottomLeft: Radius.circular(0.0),
                                            topLeft: Radius.circular(30.0),
                                            bottomRight: Radius.circular(30.0),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(20),
                                          child: Text(
                                            'Lorem ipsum dolor sit amet, consectetur adipi-sing elit. Nunc sed venenatis lacus.',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: w / 37),
                                          ),
                                        )),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                        width: w / 1.5,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              '10:00 AM',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: w / 37),
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  width: 18,
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 40, left: 20, right: 10, bottom: 10),
                                  child: CircleAvatar(
                                    radius: h / 40,
                                    backgroundColor:
                                        Colors.grey, // Image radius
                                    backgroundImage: const AssetImage(
                                        'assets/male-user.png'),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        width: w / 1.5,
                                        height: h / 12,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(30.0),
                                            bottomLeft: Radius.circular(0.0),
                                            topLeft: Radius.circular(30.0),
                                            bottomRight: Radius.circular(30.0),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(20),
                                          child: Text(
                                            'Lorem ipsum dolor sit amet, consectetur adipi-sing elit. Nunc sed venenatis lacus.',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: w / 37),
                                          ),
                                        )),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                        width: w / 1.5,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              '10:00 AM',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: w / 37),
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  width: 18,
                                )
                              ],
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 40, left: 20, right: 10, bottom: 10),
                                  child: CircleAvatar(
                                    radius: h / 40,
                                    backgroundColor:
                                        Colors.grey, // Image radius
                                    backgroundImage: const AssetImage(
                                        'assets/male-user.png'),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        width: w / 1.5,
                                        height: h / 12,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(30.0),
                                            bottomLeft: Radius.circular(0.0),
                                            topLeft: Radius.circular(30.0),
                                            bottomRight: Radius.circular(30.0),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(20),
                                          child: Text(
                                            'Lorem ipsum dolor sit amet, consectetur adipi-sing elit. Nunc sed venenatis lacus.',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: w / 37),
                                          ),
                                        )),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                        width: w / 1.5,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              '10:00 AM',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: w / 37),
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  width: 18,
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 40, left: 20, right: 10, bottom: 10),
                                  child: CircleAvatar(
                                    radius: h / 40,
                                    backgroundColor:
                                        Colors.grey, // Image radius
                                    backgroundImage: const AssetImage(
                                        'assets/male-user.png'),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        width: w / 1.5,
                                        height: h / 12,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(30.0),
                                            bottomLeft: Radius.circular(0.0),
                                            topLeft: Radius.circular(30.0),
                                            bottomRight: Radius.circular(30.0),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(20),
                                          child: Text(
                                            'Lorem ipsum dolor sit amet, consectetur adipi-sing elit. Nunc sed venenatis lacus.',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: w / 37),
                                          ),
                                        )),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                        width: w / 1.5,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              '10:00 AM',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: w / 37),
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  width: 18,
                                )
                              ],
                            ),

                            // SizedBox(
                            //   height: 10,
                            // )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: w,
                      height: h / 7,
                      color: const Color.fromARGB(239, 239, 247, 248),
                      child: Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 20, right: 20, bottom: 40),
                          child: Row(
                            children: [
                              Container(
                                width: w / 1.1 - 2.6,
                                height: h / 12,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0.0,
                                      shadowColor: Colors.transparent,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(40))),
                                      minimumSize: const Size.fromHeight(60),
                                      primary: Colors.white,
                                    ),
                                    onPressed: () async {
                                      Navigator.pushNamed(
                                          context, RoutePaths.chatLiveScreen);
                                      // Navigator.
                                      // Navigator.pop(context);
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            //  Expanded(

                                            Container(
                                              width: w / 1.5,
                                              child: TextField(
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12.0,
                                                  height: 0.1,
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
                                                  hintText: 'Type a message...',
                                                  hintStyle: TextStyle(
                                                    fontSize: h / 80,
                                                    // fontWeight: FontWeight.w500,
                                                  ),
                                                  ////search design
                                                  // suffixIcon: const Icon(
                                                  //   Icons.search_rounded,
                                                  //   color: Colors.grey,
                                                  // ),
                                                  focusedBorder:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                  ),
                                                  enabledBorder:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
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

                                            SizedBox(
                                              width: 13,
                                            ),

                                            // ),
                                            Row(
                                              children: [
                                                ClipOval(
                                                  child: Material(
                                                    color: const Color.fromARGB(
                                                        159,
                                                        114,
                                                        190,
                                                        21), // Button color
                                                    child: InkWell(
                                                      splashColor: Colors
                                                          .black, // Splash color
                                                      onTap: () {
                                                        // Navigator.push(
                                                        //   context,
                                                        //   MaterialPageRoute<void>(
                                                        //       builder: (context) =>
                                                        //           BookingAppointmentScreen()),
                                                        // );
                                                      },
                                                      child: Container(
                                                          margin:
                                                              EdgeInsets.all(
                                                                  10),
                                                          width: h / 26,
                                                          height: h / 26,
                                                          child: const Image(
                                                            color:
                                                                Color.fromARGB(
                                                                    216,
                                                                    2,
                                                                    7,
                                                                    29),
                                                            image: AssetImage(
                                                                'assets/send.png'),
                                                          )),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),

                                        //   ],
                                        // )
                                      ],
                                    )),
                              ),
                            ],
                          )),
                    ),
                  ],
                )),
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
