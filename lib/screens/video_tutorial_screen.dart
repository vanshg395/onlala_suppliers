import 'package:flutter/material.dart';

import '../widgets/video_play_button.dart';
import '../widgets/common_button.dart';

class VideoTutorialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 30,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            VideoPlayButton(),
            SizedBox(
              height: mediaQuery.height * 0.1,
            ),
            Text(
              'Take a Video Tour',
              style: Theme.of(context)
                  .primaryTextTheme
                  .subtitle
                  .copyWith(color: Colors.white, letterSpacing: 1),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                'Upload your product and get your first order fast.',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .primaryTextTheme
                    .body2
                    .copyWith(color: Colors.white),
              ),
            ),
            SizedBox(
              height: mediaQuery.height * 0.1,
            ),
            CommonButton(
              bgColor: Theme.of(context).accentColor,
              borderColor: Theme.of(context).primaryColor,
              elevation: 5,
              title: 'SKIP VIDEO',
              fontSize: 16,
              width: 200,
              borderRadius: 5,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
