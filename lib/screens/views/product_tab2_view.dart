import 'package:flutter/material.dart';

import '../product_details_screen.dart';
import '../../widgets/pending_product_card.dart';
import '../tabsScreen.dart';

class ProductTab2View extends StatelessWidget {
  final List<dynamic> pendingProducts;

  ProductTab2View(this.pendingProducts);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: pendingProducts.length == 0
          ? Center(
              child: Text('No Pending Products'),
            )
          : GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              childAspectRatio: 2 / 3,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              padding: EdgeInsets.all(15),
              children: pendingProducts
                  .map((product) => PendingProductCard(
                        name: product['product_name'],
                        id: product['id'].toString(),
                        price: product['price'].toString(),
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
