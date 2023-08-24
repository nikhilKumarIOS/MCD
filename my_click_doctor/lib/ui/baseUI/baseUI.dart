import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_click_doctor/services/api.dart';
import 'package:my_click_doctor/ui/baseUI/baseUI_bloc/baseUI_bloc.dart';
import 'package:my_click_doctor/ui/baseUI/baseUI_bloc/baseUI_state.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../constants/LocalImages.dart';
import '../../constants/appConstants.dart';
import '../../models/doctorProfile_model.dart';
import '../../services/router.dart';
import '../../shared/ui_helper.dart';
import 'baseUI_bloc/baseUI_events.dart';

class BaseUI extends StatelessWidget {
  BaseUI({Key key, this.title, this.hideLogo}) : super(key: key);
  String title = "";
  bool hideLogo = false;
  final storage = const FlutterSecureStorage();
  final popUpControler = CustomPopupMenuController();
  String profileimage = "";
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  hideLogo
                      ? Ink(
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
                        )
                      : Image(
                          height: h / 15,
                          image: const AssetImage('assets/logo.png')),
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
                                padding: const EdgeInsets.only(left: 15),
                                child: Row(
                                  children: [
                                    ClipOval(
                                      child: Material(
                                        color: Colors.white, // Button color
                                        child: InkWell(
                                          splashColor:
                                              Colors.black, // Splash color
                                          onTap: () {
                                            Navigator.pushNamed(context,
                                                RoutePaths.supportScreen);
                                          },
                                          child: Container(
                                              margin: const EdgeInsets.all(10),
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
                                    BlocProvider(
                                      lazy:
                                          false, // Set lazy to false to create the Bloc immediately
                                      create: (context) {
                                        final dataBloc =
                                            DataBloc(apiService: ApiService());
                                        dataBloc.add(GetDataEvent());
                                        return dataBloc;
                                      },
                                      child: BlocBuilder<DataBloc, DataState>(
                                        builder: (context, state) {
                                          if (state is DataLoaded) {
                                            final DoctorProfile doctorProfile =
                                                state.doctorProfile;
                                            return CustomPopupMenu(
                                              controller: popUpControler,
                                              child: CircleAvatar(
                                                radius: h / 40,
                                                backgroundColor:
                                                    Colors.grey[200],
                                                child: CircleAvatar(
                                                  radius: h / 22,
                                                  backgroundImage:
                                                      (doctorProfile.docProfile
                                                                  .photoUrl ==
                                                              null)
                                                          ? const AssetImage(
                                                              LocalImages
                                                                  .maleUser)
                                                          : NetworkImage(
                                                              "${Api.imageBaseUrl}${doctorProfile.docProfile.photoUrl}",
                                                            ),
                                                ),
                                              ),

                                              menuBuilder: () =>
                                                  GestureDetector(
                                                child: _buildAvatar(context),
                                              ),
                                              barrierColor: Colors.transparent,
                                              pressType: PressType.singleClick,
                                              arrowColor: Colors.blueAccent,
                                              // position: PreferredPosition.top,
                                            );
                                          } else if (state is DataLoading) {
                                            return CircleAvatar(
                                              radius: h / 40,
                                              backgroundColor: Colors.grey,
                                              backgroundImage: const AssetImage(
                                                  LocalImages.maleUser),
                                            );
                                          } else if (state is DataError) {
                                            return Text(
                                                'Error: ${state.errorMessage}');
                                          } else {
                                            return CircleAvatar(
                                              radius: h / 40,
                                              backgroundColor: Colors.grey,
                                            );
                                          }
                                        },
                                      ),
                                    )
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
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image(
                            height: h / 56,
                            image: const AssetImage('assets/four-dots.png')),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(title,
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
        ],
      ),
    );
  }

  Widget _buildAvatar(BuildContext context) {
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
                      // setState(() {});
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
