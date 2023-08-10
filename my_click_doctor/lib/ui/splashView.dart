import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_click_doctor/services/router.dart';

import '../constants/LocalImages.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 2),
        () => Navigator.pushReplacementNamed(context, RoutePaths.loginscreen,
            arguments: true));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                LocalImages.splash,
                fit: BoxFit.cover,
              ),
            ),
            // Center(
            //   child: Image.asset(
            //     LocalImages.logo,
            //     width: MediaQuery.of(context).size.width / 1.5,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
