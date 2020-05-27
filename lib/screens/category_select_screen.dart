import 'package:flutter/material.dart';

import '../widgets/subcategory_detail_card.dart';
import './subcategory_select_screen.dart';

class CategorySelectScreen extends StatelessWidget {
  final List<dynamic> cats;
  final String deptName;

  CategorySelectScreen(this.cats, this.deptName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        title: Text(
          'Select Category',
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
          // childAspectRatio: 4 / 5,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          padding: EdgeInsets.all(15),
          children: cats
              .map(
                (cat) => SubcategoryDetailCard(
                  name: cat['name'],
                  image: cat['image'],
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => SubCategorySelectScreen(
                          cat['sub_categories'], deptName, cat['name']),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
