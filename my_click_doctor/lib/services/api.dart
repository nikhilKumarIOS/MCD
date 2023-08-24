import 'dart:convert';
//import 'dart:js';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

import '../constants/appConstants.dart';
import '../models/doctorProfile_model.dart';

class ApiService {
  final storage = FlutterSecureStorage();
  final http.Client _client = http.Client();
  var base = Api.baseUrl;

  Future<Map<String, dynamic>> login(String username, String password) async {
    final url = Uri.parse('$base/Account/Login');

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

  Future<dynamic> getBookedAppointments() async {
    try {
      var id = await storage.read(key: 'id');
      var token = await storage.read(key: 'token');

      var response = await _client.get(
        Uri.parse('$base/Doctor/GetDoctorRecomndedTimeslot?DocId=$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': '$token',
          'Lang': 'en',
          'Status': '1'
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('API getBookedAppointments Error');
      }
    } catch (error) {
      throw error;
    }
  }

  Future<dynamic> getRecommendAppointment() async {
    try {
      var id = await storage.read(key: 'id');
      var token = await storage.read(key: 'token');

      var response = await _client.get(
        Uri.parse('$base/Doctor/GetDoctorRecomndedTimeslot?DocId=$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': '$token',
          'Lang': 'en',
          'Status': '1'
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('API getRecommendAppointment Error');
      }
    } catch (error) {
      throw error;
    }
  }

  Future<Map<String, dynamic>> fetchDoctorProfile() async {
    String id = await storage.read(key: 'userId');
    final response =
        await http.get(Uri.parse('$base/Pharmacy/GetDoctorProfile?UserId=$id'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  void dispose() {
    _client.close();
  }
}
