import 'package:flutter/material.dart';

class SubcategoryCard extends StatelessWidget {
  final Widget icon;
  final Widget label;
  final Function onTap;

  SubcategoryCard(
      {@required this.icon, @required this.label, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            icon,
            SizedBox(
              width: 10,
            ),
            label,
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
