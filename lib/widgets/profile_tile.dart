import 'package:flutter/material.dart';

class ProfileTile extends StatelessWidget {
  final Widget icon;
  final Widget label;
  final Function onTap;

  ProfileTile(
      {@required this.icon, @required this.label, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
        child: Row(
          children: <Widget>[
            icon,
            SizedBox(
              width: 20,
            ),
            label,
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
