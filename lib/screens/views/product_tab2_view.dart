import 'package:flutter/material.dart';

import '../../widgets/pending_product_card.dart';

class ProductTab2View extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        padding: EdgeInsets.all(15),
        children: <Widget>[
          PendingProductCard(),
          PendingProductCard(),
          PendingProductCard(),
        ],
      ),
    );
  }
}
