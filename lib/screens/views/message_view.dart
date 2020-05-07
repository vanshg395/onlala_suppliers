import 'package:flutter/material.dart';

class MessageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: Center(
        child: Text(
          'Messages Coming Soon',
          style: Theme.of(context).primaryTextTheme.subtitle,
        ),
      ),
    );
  }
}
