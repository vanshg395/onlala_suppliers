import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../widgets/home_card.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
            child: CarouselSlider(
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height * 0.43,
                viewportFraction: 0.7,
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
                // autoPlay: true,
              ),
              items: <Widget>[
                HomeCard(),
                HomeCard(),
                HomeCard(),
              ],
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
