import 'package:flutter/material.dart';

import '../tabsScreen.dart';
import '../../widgets/product_card.dart';
import '../product_details_screen.dart';

class ProductTab1View extends StatelessWidget {
  final List<dynamic> myProducts;

  ProductTab1View(this.myProducts);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: myProducts.length == 0
          ? Center(
              child: Text(
                'No Products',
                style: Theme.of(context).primaryTextTheme.body1,
              ),
            )
          : GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              childAspectRatio: 2 / 3,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              padding: EdgeInsets.all(15),
              children: myProducts
                  .map((product) => ProductCard(
                        name: product['product_name'],
                        id: product['id'].toString(),
                        price: product['price'],
                        image: product['image'],
                        onTap: () => Navigator.of(context)
                            .push(
                              MaterialPageRoute(
                                builder: (ctx) => ProductDetailsScreen(
                                  name: product['product_name'],
                                  id: product['id'],
                                  price: product['price'],
                                ),
                              ),
                            )
                            .then(
                              (value) => {
                                if (value == 'deleted')
                                  {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (ctx) => TabsScreen(),
                                      ),
                                    )
                                  },
                              },
                            ),
                      ))
                  .toList(),
            ),
    );
  }
}
