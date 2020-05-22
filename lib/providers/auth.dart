import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants.dart';
import '../utils/http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  List<dynamic> _details;
  List<dynamic> _docs;

  String get token {
    return _token;
  }

  List<dynamic> get userDetails {
    return _details;
  }

  List<dynamic> get docs {
    return _docs;
  }

  bool get isAuth {
    return token != null;
  }

  Future<void> login(
      Map<String, dynamic> loginData, bool stayLoggedIn, bool isSignUp) async {
    try {
      print('>>>>>>>>>>>>>>login');
      final url = baseUrl + 'user/api/token/manu/';
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
        _token = 'JWT ' + responseBody['access'];
        if (isSignUp) {
          return;
        }
        final url2 = baseUrl + 'business/manufacturer/create/';
        final response2 = await http.get(
          url2,
          headers: {
            'Authorization': _token,
          },
        );
        print(response2.statusCode);
        print(response2.body);
        if (response2.statusCode == 200) {
          final resBody = json.decode(response2.body);
          _details = resBody['payload'];
          _docs = resBody['documents'];
          if (stayLoggedIn) {
            final prefs = await SharedPreferences.getInstance();
            final _data = json.encode({
              'token': _token,
              'details': _details,
              'docs': _docs,
            });
            await prefs.setString('userData', _data);
          }
          notifyListeners();
        } else if (response2.statusCode == 403) {
          throw HttpException('Not a manufacturer');
        }
      } else if (response.statusCode == 202) {
        final responseBody = json.decode(response.body);
        _token = 'JWT ' + responseBody['access'];
        final url2 = baseUrl + 'business/manufacturer/create/';
        final response2 = await http.get(
          url2,
          headers: {
            'Authorization': _token,
          },
        );
        print(response2.statusCode);
        print(response2.body);
        if (response2.statusCode == 200) {
          final resBody = json.decode(response2.body);
          _details = resBody['payload'];
          _docs = resBody['documents'];
          if (stayLoggedIn) {
            final prefs = await SharedPreferences.getInstance();
            final _data = json.encode({
              'token': _token,
              'details': _details,
              'docs': _docs,
            });
            await prefs.setString('userData', _data);
          }
          notifyListeners();
          throw HttpException('Complete Profile');
        } else if (response2.statusCode == 403) {
          throw HttpException('Not a manufacturer');
        }
      } else if (response.statusCode == 401) {
        throw HttpException('Invalid Cred');
      } else if (response.statusCode == 412) {
        throw HttpException('User Blocked');
      } else {
        throw HttpException('Error1');
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> getManufData() async {
    try {
      final url2 = baseUrl + 'business/manufacturer/create/';
      final response2 = await http.get(
        url2,
        headers: {
          'Authorization': _token,
        },
      );
      print(response2.statusCode);
      if (response2.statusCode == 200) {
        final resBody = json.decode(response2.body);
        _details = resBody['payload'];
        _docs = resBody['documents'];
        // if (stayLoggedIn) {
        //   final prefs = await SharedPreferences.getInstance();
        //   final _data = json.encode({
        //     'token': _token,
        //     'details': _details,
        //     'docs': _docs,
        //   });
        //   await prefs.setString('userData', _data);
        // }
      }
    } catch (e) {}
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
      if (response.statusCode >= 200 && response.statusCode <= 299) {
      } else if (response.statusCode == 400) {
        throw HttpException('User exists');
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
      print(_token);
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
      if (response.statusCode == 201) {
        _token = null;
        notifyListeners();
      } else if (response.statusCode == 400) {
        throw HttpException('Repeated Phone');
      } else if (response.statusCode == 500) {
        throw HttpException('Server Overload');
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> deleteUser() async {
    final url = baseUrl + 'user/delete/';
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': _token,
        },
      );
      print(response.statusCode);
    } catch (e) {}
  }

  Future<void> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    _token = extractedUserData['token'];
    _details = extractedUserData['details'];
    _docs = extractedUserData['docs'];
    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userData');
    notifyListeners();
  }
}
