import 'dart:convert';
//import 'dart:js';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class Api {
  static const baseUrl = 'https://api.myclickdoctor.com/v3/api';
  static const imageBaseUrl = 'https://api.myclickdoctor.com/v3/';
  static const imageBaseUrl2 = 'https://api.myclickdoctor.com/v3';

  var client = http.Client();

  Future<String> login(String username, String password) async {
    print(username);
    print(password);

    var response = await client.post(
      Uri.parse('$baseUrl/Account/Login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'Email': username,
        'Password': password,
        'Usertype': 2.toString()
      }),
    );
    if (response.statusCode == 200) {
      print(response);

      //final storage = FlutterSecureStorage();

      return "success";
    } else {
      return "Error";
    }
  }
}
