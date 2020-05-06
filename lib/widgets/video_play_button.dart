import 'package:flutter/material.dart';

class VideoPlayButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.width * 0.6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.05),
              boxShadow: [
                BoxShadow(
                  blurRadius: 2,
                  spreadRadius: 2,
                  offset: Offset(1, 1),
                  color: Colors.white.withOpacity(0.05),
                ),
              ],
            ),
          ),
        ),
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.width * 0.5,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.1),
              boxShadow: [
                BoxShadow(
                  blurRadius: 2,
                  spreadRadius: 2,
                  offset: Offset(1, 1),
                  color: Colors.white.withOpacity(0.1),
                ),
              ],
            ),
          ),
        ),
        Center(
          child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.width * 0.4,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
            onTap: () {
              print('hey');
            },
          ),
        ),
        Center(
          child: InkWell(
            child: Icon(
              Icons.play_arrow,
              color: Theme.of(context).primaryColor,
              size: MediaQuery.of(context).size.width * 0.2,
            ),
            onTap: () {
              print('hey');
            },
          ),
        ),
      ],
    );
  }
}
