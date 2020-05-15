import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../utils/constants.dart';

class TnCViewScreen extends StatefulWidget {
  @override
  _TnCViewScreenState createState() => _TnCViewScreenState();
}

class _TnCViewScreenState extends State<TnCViewScreen> {
  String _title = 'No Conditions Found';
  String _tnc = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final url = baseUrl + 'business/termsAndConditions/';
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final resBody = json.decode(response.body);
        setState(() {
          _title = resBody['payload'][0]['title'];
          _tnc = resBody['payload'][0]['description'];
        });
      }
    } catch (e) {}
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        title: Text(
          'Terms and Conditions',
          style: Theme.of(context).primaryTextTheme.subtitle.copyWith(
                color: Colors.white,
                letterSpacing: 2,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(
                  Theme.of(context).primaryColor,
                ),
              ),
            )
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      _title ?? 'No Conditions Found',
                      style: Theme.of(context).primaryTextTheme.subtitle,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      _tnc ?? '',
                      style: Theme.of(context).primaryTextTheme.body2,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
