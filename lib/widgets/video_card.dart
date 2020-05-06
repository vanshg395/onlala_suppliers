import 'package:flutter/material.dart';

class VideoCard extends StatelessWidget {
  final String title;

  VideoCard({@required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      // padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            spreadRadius: 1,
            color: Colors.grey,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            child: Container(
              height: 200,
              child: Image.asset(
                'assets/img/homedevice.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Text(
              title,
              style: Theme.of(context).primaryTextTheme.subtitle,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
