import 'package:flutter/material.dart';

import '../widgets/subcategory_detail_card.dart';

class SubcategoryDetailScreen extends StatelessWidget {
  final String categoryName;

  SubcategoryDetailScreen(this.categoryName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        title: Text(
          categoryName,
          style: Theme.of(context).primaryTextTheme.subtitle.copyWith(
                color: Colors.white,
                letterSpacing: 2,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
      body: Container(
        child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 3,
          childAspectRatio: 4 / 5,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          padding: EdgeInsets.all(15),
          children: <Widget>[
            SubcategoryDetailCard(),
            SubcategoryDetailCard(),
            SubcategoryDetailCard(),
            SubcategoryDetailCard(),
            SubcategoryDetailCard(),
          ],
        ),
      ),
    );
  }
}
