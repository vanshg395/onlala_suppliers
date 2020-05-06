import 'package:flutter/material.dart';

class SubcategoryDetailCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            spreadRadius: 1,
            color: Colors.grey,
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (ctx, constraints) => Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 3, left: 3, right: 3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).accentColor,
              ),
              height: constraints.maxHeight * 0.6,
            ),
            Expanded(
              child: Center(
                child: Text('Product 1'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
