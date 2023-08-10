import 'package:flutter/material.dart';
import '../shared/hex_converter.dart';

class AppColors {
  static Color backgroundColor2 = HexColor.fromHex('e0e9e8');
  static Color backgroundColor = HexColor.fromHex('eff7f8');
  static Color darkBlue = HexColor.fromHex('272b41');
  static Color red = HexColor.fromHex('f93838');
  static Color green = HexColor.fromHex('97cf63');
  static Color darkGreen = HexColor.fromHex('1a2c04');
}

class Api {
  static const baseUrl =
      'https://testapi.myclickdoctor.com/api/'; //'https://api.myclickdoctor.com/v3/api';
  static const imageBaseUrl =
      'https://testapi.myclickdoctor.com/'; //'https://api.myclickdoctor.com/v3/';
  static const imageBaseUrl2 =
      'https://testapi.myclickdoctor.com/'; //'https://api.myclickdoctor.com/v3';

}

class ApiEndPoints {
  static const login = 'Account/Login';
}


// Green- 97cf63
// Dark blue main -272b41
// Dark blue button - 314052
// light green eff7f8
// Red-f93838


// light gray - bebfc6