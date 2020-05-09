import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../widgets/home_card.dart';
import '../../utils/constants.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<dynamic> _data = [];
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
      final url = baseUrl + 'subcategories/manuf/app/';
      final response = await http.get(url);
      print(response.statusCode);
      if (response.statusCode == 200) {
        final resBody = json.decode(response.body);
        setState(() {
          _data = resBody;
        });
      }
    } catch (e) {
      print(e);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Theme.of(context).canvasColor,
      child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: double.infinity,
            color: Colors.teal,
            child: Image.asset(
              'assets/img/drone.png',
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'All Category',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w300,
            ),
          ),
          Expanded(
            child: _isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(
                          Theme.of(context).primaryColor),
                    ),
                  )
                : CarouselSlider(
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.height * 0.43,
                      viewportFraction: 0.7,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: false,
                      // autoPlay: true,
                    ),
                    // items: <Widget>[
                    //   HomeCard(title: 'DN'),
                    //   HomeCard(title: 'DN'),
                    //   HomeCard(title: 'DN'),
                    // ],
                    items: _data
                        .map(
                          (dep) => HomeCard(
                            title: dep['name'],
                            cat: dep['cat'],
                          ),
                        )
                        .toList(),
                  ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
