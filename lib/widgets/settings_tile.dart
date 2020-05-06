import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  final Widget icon;
  final Widget label;
  final Widget trailing;
  final Function onTap;

  SettingsTile(
      {@required this.icon,
      @required this.label,
      @required this.onTap,
      @required this.trailing});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          children: <Widget>[
            icon,
            SizedBox(
              width: 20,
            ),
            label,
            Expanded(
              child: SizedBox(),
            ),
            trailing,
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
