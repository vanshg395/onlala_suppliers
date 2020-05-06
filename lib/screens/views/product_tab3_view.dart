import 'package:flutter/material.dart';

import '../../widgets/order_card.dart';

class ProductTab3View extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        padding: EdgeInsets.all(20),
        children: <Widget>[
          OrderCard(),
          OrderCard(),
        ],
      ),
    );
  }
}
