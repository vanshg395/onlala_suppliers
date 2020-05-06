import 'package:flutter/material.dart';

import '../../widgets/product_card.dart';
import '../product_details_screen.dart';

class ProductTab1View extends StatelessWidget {
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
          ProductCard(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => ProductDetailsScreen(),
              ),
            ),
          ),
          ProductCard(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => ProductDetailsScreen(),
              ),
            ),
          ),
          ProductCard(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => ProductDetailsScreen(),
              ),
            ),
          ),
          ProductCard(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => ProductDetailsScreen(),
              ),
            ),
          ),
          ProductCard(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => ProductDetailsScreen(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
