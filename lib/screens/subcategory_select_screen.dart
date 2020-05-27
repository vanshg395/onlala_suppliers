import 'package:flutter/material.dart';

import '../widgets/subcategory_detail_card.dart';
import './product_upload_screen.dart';

class SubCategorySelectScreen extends StatelessWidget {
  final List<dynamic> subCats;
  final String deptName;
  final String catName;

  SubCategorySelectScreen(this.subCats, this.deptName, this.catName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        title: Text(
          'Select Sub-Category',
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
          children: subCats
              .map(
                (subcat) => SubcategoryDetailCard(
                    name: subcat['sub_category']['sub_categories'],
                    image: subcat['image'],
                    onTap: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                      // int count = 0;
                      // Navigator.popUntil(context, (route) {
                      //   return count++ == 2;
                      // });
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => ProductUploadScreen(
                            deptName,
                            catName,
                            subcat['sub_category']['sub_categories'],
                            subcat['sub_category']['id'],
                          ),
                        ),
                      );
                    }),
              )
              .toList(),
        ),
      ),
    );
  }
}
