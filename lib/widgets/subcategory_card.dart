import 'package:flutter/material.dart';

class SubcategoryCard extends StatelessWidget {
  final Widget icon;
  final String label;
  final Function onTap;

  SubcategoryCard({this.icon, @required this.label, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        margin: EdgeInsets.symmetric(vertical: 5),
        color: Theme.of(context).canvasColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Text(
                label,
                style: Theme.of(context).primaryTextTheme.body2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(Icons.chevron_right),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
