import 'package:flutter/material.dart';

import '../../widgets/video_card.dart';

class VideoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            VideoCard(title: 'How to get Started'),
            VideoCard(title: 'How to get Started'),
            VideoCard(title: 'How to get Started'),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
