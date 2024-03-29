import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dots_indicator/dots_indicator.dart';

import '../../widgets/home_card.dart';
import '../../utils/constants.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<dynamic> _data = [];
  List<dynamic> _bannerData = [];
  bool _isLoading = false;
  double _currentCarouselPosition = 0;

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
      final bannerUrl = baseUrl + 'banner/create/';
      final bannerRes = await http.get(bannerUrl);
      print(bannerRes.statusCode);
      print(bannerRes.body);
      if (bannerRes.statusCode == 200) {
        final bResBody = json.decode(bannerRes.body);
        setState(() {
          _bannerData = bResBody['payload'];
        });
        print(_bannerData);
      }

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
            color: Colors.white,
            // child: Image.asset(
            //   'assets/img/drone.png',
            //   fit: BoxFit.cover,
            // ),
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                CarouselSlider(
                  options: CarouselOptions(
                      height: MediaQuery.of(context).size.height * 0.3,
                      viewportFraction: 1,
                      enableInfiniteScroll: true,
                      autoPlay: true,
                      onPageChanged: (i, _) {
                        setState(() {
                          _currentCarouselPosition = i.toDouble();
                        });
                      }),
                  // items: <Widget>[
                  //   HomeCard(title: 'DN'),
                  //   HomeCard(title: 'DN'),
                  //   HomeCard(title: 'DN'),
                  // ],
                  items: _bannerData
                      .map(
                        (banner) => Image.network(
                          banner['image'],
                          fit: BoxFit.cover,
                        ),
                      )
                      .toList(),
                ),
                Positioned(
                  bottom: 20,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    child: DotsIndicator(
                      dotsCount:
                          _bannerData.length == 0 ? 1 : _bannerData.length,
                      position: _currentCarouselPosition,
                      decorator: DotsDecorator(
                        activeColor: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            'All Categories',
            style: Theme.of(context).primaryTextTheme.body2,
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
