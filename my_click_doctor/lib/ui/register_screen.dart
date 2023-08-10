import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_click_doctor/main.dart';
import 'package:my_click_doctor/tabbar_view.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'book_appointment_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;
  bool isChecked4 = false;
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
            body: Container(
      height: h,
      width: w,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/login-bg.png'), fit: BoxFit.fill)),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      width: w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Ink(
                            decoration: const ShapeDecoration(
                                shape: CircleBorder(), color: Colors.grey),
                            child: IconButton(
                              icon: const Icon(Icons.arrow_back),
                              iconSize: h / 40,
                              color: Colors.black,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ],
                      )),
                  const Padding(
                    padding: EdgeInsets.only(top: 20, right: 110, left: 110),
                    child: Image(image: AssetImage('assets/logo.png')),
                  ),
                  Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        'Doctor Register',
                        style: TextStyle(
                            fontSize: h / 48, fontWeight: FontWeight.w800),
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
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
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
                                  'Prefix',
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
                                  color: Color.fromARGB(239, 239, 247, 248),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  value: selectedVal,
                                  underline: SizedBox(),
                                  items: <String>['Prefix', 'Dr.', 'Prof. Dr']
                                      .map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        overflow: TextOverflow.ellipsis,
                                        style: new TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            decoration: TextDecoration.none),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (_) {
                                    setState(() {
                                      selectedVal = _;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                  Padding(
                      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
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
                              mainAxisAlignment: MainAxisAlignment.start,
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
                                  'Surname (Jr., Sr. etc. without prefix)',
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

                                  // controller: nameController,
                                  // obscureText: isMail,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: w / 30,
                                  ),
                                  decoration: InputDecoration(

                                      // hintText: 'Enter Email',

                                      // hintStyle: TextStyle( color: Colors.white),

                                      // suffixIcon: Icon(Icons.timer),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide.none,
                                      ),
                                      fillColor:
                                          Color.fromARGB(239, 239, 247, 248),
                                      filled: true)),
                            ),
                          ],
                        ),
                      )),
                  Padding(
                      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
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
                              mainAxisAlignment: MainAxisAlignment.start,
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
                                  'First name',
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

                                  // controller: nameController,
                                  // obscureText: isMail,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: w / 30,
                                  ),
                                  decoration: InputDecoration(

                                      // hintText: 'Enter Email',

                                      // hintStyle: TextStyle( color: Colors.white),

                                      // suffixIcon: Icon(
                                      //   Icons.keyboard_arrow_down_outlined,
                                      // ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide.none,
                                      ),
                                      fillColor:
                                          Color.fromARGB(239, 239, 247, 248),
                                      filled: true)),
                            ),
                          ],
                        ),
                      )),
                  Padding(
                      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
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
                              mainAxisAlignment: MainAxisAlignment.start,
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
                                  'Seal number',
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

                                  // controller: nameController,
                                  // obscureText: isMail,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: w / 30,
                                  ),
                                  decoration: InputDecoration(

                                      // hintText: 'Enter Email',

                                      // hintStyle: TextStyle( color: Colors.white),

                                      // suffixIcon: Icon(
                                      //   Icons.group,
                                      // ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide.none,
                                      ),
                                      fillColor:
                                          Color.fromARGB(239, 239, 247, 248),
                                      filled: true)),
                            ),
                          ],
                        ),
                      )),
                  Padding(
                      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
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
                              mainAxisAlignment: MainAxisAlignment.start,
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
                                  'Main examinantion',
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

                                  // controller: nameController,
                                  // obscureText: isMail,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: w / 30,
                                  ),
                                  decoration: InputDecoration(

                                      // hintText: 'Enter Email',

                                      // hintStyle: TextStyle( color: Colors.white),

                                      // suffixIcon: Icon(
                                      //   Icons.menu_book_outlined,
                                      // ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide.none,
                                      ),
                                      fillColor:
                                          Color.fromARGB(239, 239, 247, 248),
                                      filled: true)),
                            ),
                          ],
                        ),
                      )),
                  Padding(
                      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
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
                              mainAxisAlignment: MainAxisAlignment.start,
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
                                  'Further professional examination',
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

                                  // controller: nameController,
                                  // obscureText: isMail,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: w / 30,
                                  ),
                                  decoration: InputDecoration(

                                      // hintText: 'Enter Email',

                                      // hintStyle: TextStyle( color: Colors.white),

                                      // suffixIcon: Icon(
                                      //   Icons.menu_book_outlined,
                                      // ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide.none,
                                      ),
                                      fillColor:
                                          Color.fromARGB(239, 239, 247, 248),
                                      filled: true)),
                            ),
                          ],
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 220, bottom: 20),
                    child: Container(
                      width: w,
                      height: h / 17,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        color: Color.fromARGB(159, 114, 190, 21),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Primary workspace     ',
                                    style: TextStyle(
                                        letterSpacing: 0.5,
                                        fontSize: w / 30,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
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
                              mainAxisAlignment: MainAxisAlignment.start,
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
                                  'Job name',
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

                                  // controller: nameController,
                                  // obscureText: isMail,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: w / 30,
                                  ),
                                  decoration: InputDecoration(

                                      // hintText: 'Enter Email',

                                      // hintStyle: TextStyle( color: Colors.white),

                                      // suffixIcon: Icon(
                                      //   Icons.menu_book_outlined,
                                      // ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide.none,
                                      ),
                                      fillColor:
                                          Color.fromARGB(239, 239, 247, 248),
                                      filled: true)),
                            ),
                          ],
                        ),
                      )),
                  Padding(
                      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
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
                              mainAxisAlignment: MainAxisAlignment.start,
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
                                  'Postal code',
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

                                  // controller: nameController,
                                  // obscureText: isMail,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: w / 30,
                                  ),
                                  decoration: InputDecoration(

                                      // hintText: 'Enter Email',

                                      // hintStyle: TextStyle( color: Colors.white),

                                      // suffixIcon: Icon(
                                      //   Icons.menu_book_outlined,
                                      // ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide.none,
                                      ),
                                      fillColor:
                                          Color.fromARGB(239, 239, 247, 248),
                                      filled: true)),
                            ),
                          ],
                        ),
                      )),
                  Padding(
                      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
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
                              mainAxisAlignment: MainAxisAlignment.start,
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
                                  'Settlement',
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

                                  // controller: nameController,
                                  // obscureText: isMail,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: w / 30,
                                  ),
                                  decoration: InputDecoration(

                                      // hintText: 'Enter Email',

                                      // hintStyle: TextStyle( color: Colors.white),

                                      // suffixIcon: Icon(
                                      //   Icons.menu_book_outlined,
                                      // ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide.none,
                                      ),
                                      fillColor:
                                          Color.fromARGB(239, 239, 247, 248),
                                      filled: true)),
                            ),
                          ],
                        ),
                      )),
                  Padding(
                      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
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
                              mainAxisAlignment: MainAxisAlignment.start,
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
                                  'Street Address',
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

                                  // controller: nameController,
                                  // obscureText: isMail,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: w / 30,
                                  ),
                                  decoration: InputDecoration(

                                      // hintText: 'Enter Email',

                                      // hintStyle: TextStyle( color: Colors.white),

                                      // suffixIcon: Icon(
                                      //   Icons.menu_book_outlined,
                                      // ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide.none,
                                      ),
                                      fillColor:
                                          Color.fromARGB(239, 239, 247, 248),
                                      filled: true)),
                            ),
                          ],
                        ),
                      )),
                  Padding(
                      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
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
                              mainAxisAlignment: MainAxisAlignment.start,
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
                                  'E-mail Address',
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

                                  // controller: nameController,
                                  // obscureText: isMail,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: w / 30,
                                  ),
                                  decoration: InputDecoration(

                                      // hintText: 'Enter Email',

                                      // hintStyle: TextStyle( color: Colors.white),

                                      // suffixIcon: Icon(
                                      //   Icons.menu_book_outlined,
                                      // ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide.none,
                                      ),
                                      fillColor:
                                          Color.fromARGB(239, 239, 247, 248),
                                      filled: true)),
                            ),
                          ],
                        ),
                      )),
                  Padding(
                      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
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
                              mainAxisAlignment: MainAxisAlignment.start,
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
                                  'Mobile phone number',
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

                                  // controller: nameController,
                                  // obscureText: isMail,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: w / 30,
                                  ),
                                  decoration: InputDecoration(

                                      // hintText: 'Enter Email',

                                      // hintStyle: TextStyle( color: Colors.white),

                                      // suffixIcon: Icon(
                                      //   Icons.menu_book_outlined,
                                      // ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide.none,
                                      ),
                                      fillColor:
                                          Color.fromARGB(239, 239, 247, 248),
                                      filled: true)),
                            ),
                          ],
                        ),
                      )),
                  Padding(
                      padding: EdgeInsets.all(20),
                      child: Container(
                        height: h / 1.5,
                        width: w,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin: EdgeInsets.only(right: 10, top: 10),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 20,
                                        top: 10,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Checkbox(
                                              activeColor: Color.fromARGB(
                                                  159, 114, 190, 21),
                                              value: _isChecked1,
                                              onChanged: (index) {
                                                setState(() {
                                                  _isChecked1 = !_isChecked1;
                                                });
                                              }),
                                          // Icon(
                                          //   Icons.adjust_rounded,
                                          //   color: Colors.grey[800],
                                          //   size: w / 20,
                                          // ),
                                          const SizedBox(width: 5),
                                          Expanded(
                                              // padding:
                                              // EdgeInsets.only(left: 5, right: 20),
                                              child: Text(
                                            "I consent to the management of my data and accept the Data Management Information.",
                                            style: TextStyle(
                                              fontSize: w / 30,
                                              color: Colors.black,
                                            ),
                                            maxLines: 4,
                                            // softWrap: !true,
                                          )),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 20,
                                        top: 20,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Checkbox(
                                              activeColor: Color.fromARGB(
                                                  159, 114, 190, 21),
                                              value: isChecked2,
                                              onChanged: (index) {
                                                setState(() {
                                                  isChecked2 = !isChecked2;
                                                });
                                              }),
                                          const SizedBox(width: 5),
                                          Expanded(
                                              // padding:
                                              // EdgeInsets.only(left: 5, right: 20),
                                              child: Text(
                                            "I have read the general terms and conditions of the myclickdoctor system (Terms and Conditions) , I acknowledge and expressly accept its contents.",
                                            style: TextStyle(
                                              fontSize: w / 30,
                                              color: Colors.black,
                                            ),
                                            maxLines: 10,
                                            // softWrap: !true,
                                          )),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 20,
                                        top: 20,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Checkbox(
                                              activeColor: Color.fromARGB(
                                                  159, 114, 190, 21),
                                              value: isChecked3,
                                              onChanged: (index) {
                                                setState(() {
                                                  isChecked3 = !isChecked3;
                                                });
                                              }),
                                          const SizedBox(width: 5),
                                          Expanded(
                                              // padding:
                                              // EdgeInsets.only(left: 5, right: 20),
                                              child: Text(
                                            "I agree that MedicalScan Kft. can send electronic mail within the framework of this authorization in the following topics: attention-grabbing services and information, extracts of its own analyses, results of international analyses, invitations and recordings of its own patient education lectures, invitations and recordings of patient education lectures of third parties and health (anonymous, non with sensitive data) opportunities to participate in market research.",
                                            style: TextStyle(
                                              fontSize: w / 30,
                                              color: Colors.black,
                                            ),
                                            maxLines: 10,
                                            // softWrap: !true,
                                          )),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 20,
                                        top: 20,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Checkbox(
                                              activeColor: Color.fromARGB(
                                                  159, 114, 190, 21),
                                              value: isChecked4,
                                              onChanged: (index) {
                                                setState(() {
                                                  isChecked4 = !isChecked4;
                                                });
                                              }),
                                          SizedBox(width: 5),
                                          Expanded(
                                              // padding:
                                              // EdgeInsets.only(left: 5, right: 20),
                                              child: Text(
                                            "By completing this registration process, I expressly consent to MedicalScan Kft. handling my data provided during registration in the manner and for the purposes specified in the above data management information sheet, making them known to its own and contracted partners in accordance with the information sheet, and contacting them directly with their offers and information.",
                                            style: TextStyle(
                                              fontSize: w / 30,
                                              color: Colors.black,
                                            ),
                                            maxLines: 10,
                                            // softWrap: !true,
                                          )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ))
                          ],
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          minimumSize: Size.fromHeight(50),
                          primary: Color.fromARGB(159, 114, 190, 21),
                        ),
                        onPressed: () async {
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
                                Text("SUCCESS",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center),
                                SizedBox(height: 5),
                                Text(
                                  "You have been successfully registered. Kindly login.",
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
                                color: Color.fromARGB(159, 114, 190, 21),
                                radius: BorderRadius.circular(20),
                                onPressed: () => {
                                  Navigator.pop(context),
                                  Navigator.pop(context),
                                },
                                child: Text(
                                  "Okay ",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ],
                          ).show();

                          // Navigator.
                          // Navigator.pop(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: w / 20,
                            ),
                            Text('I am registering',
                                style: TextStyle(
                                  fontSize: w / 30,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                )),
                            const Icon(
                              Icons.arrow_forward,
                              color: Colors.black,
                            )
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
    )
            //),
            ));
  }
}
