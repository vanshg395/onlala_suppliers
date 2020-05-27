import 'package:flutter/material.dart';

import '../widgets/subcategory_detail_card.dart';
import './product_upload_screen.dart';

class SubcategoryDetailScreen extends StatelessWidget {
  final String deptName;
  final String categoryName;
  final List<dynamic> subCat;

  SubcategoryDetailScreen(this.deptName, this.categoryName, this.subCat);

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
          crossAxisCount: 1,
          childAspectRatio: 8 / 7,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          padding: EdgeInsets.all(15),
          children: subCat
              .map(
                (sc) => SubcategoryDetailCard(
                  name: sc['sub_category']['sub_categories'],
                  image: sc['image'],
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => ProductUploadScreen(
                          deptName,
                          categoryName,
                          sc['sub_category']['sub_categories'],
                          sc['sub_category']['id'],
                        ),
                      ),
                    );
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
