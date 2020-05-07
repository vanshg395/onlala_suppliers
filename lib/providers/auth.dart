import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../utils/constants.dart';
import '../utils/http_exception.dart';

class Auth with ChangeNotifier {
  String _token;

  String get token {
    return _token;
  }

  Future<void> login(Map<String, dynamic> loginData) async {
    try {
      print('>>>>>>>>>>>>>>login');
      final url = baseUrl + 'user/api/token/';
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(loginData),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        _token = 'JWT' + responseBody['refresh'];
      } else {
        throw HttpException('Error1');
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> register(Map<String, dynamic> registerData) async {
    try {
      print('>>>>>>>>>>>>>>register');
      final url = baseUrl + 'user/create/';
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(registerData),
      );
      print(response.statusCode);
      if (response.statusCode == 201) {
      } else if (response.statusCode == 400) {
        throw HttpException('User exists.');
      } else {
        throw HttpException('Error');
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> createManufacturer(Map<String, dynamic> manufData) async {
    try {
      print('>>>>>>>>>>>>>>createManuf');
      final url = baseUrl + 'business/manufacturer/create/';
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': _token,
        },
        body: json.encode(manufData),
      );
      print(response.statusCode);
      print(response.body);
    } catch (e) {
      throw e;
    }
  }

  Future<void> tryAutoLogin() async {}

  Future<void> logout() async {}
}
