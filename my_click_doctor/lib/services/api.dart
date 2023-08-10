import 'dart:convert';
//import 'dart:js';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

import '../constants/appConstants.dart';

class ApiService {
  final http.Client _client = http.Client();

  Future<Map<String, dynamic>> login(String username, String password) async {
    final url = Uri.parse('${Api.baseUrl}Account/Login');

    final response = await _client.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'Email': username,
        'Password': password,
        'Usertype': "2"
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to login');
    }
  }

  void dispose() {
    _client.close();
  }
}
