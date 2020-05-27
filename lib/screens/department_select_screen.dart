import 'package:flutter/material.dart';

import '../widgets/subcategory_detail_card.dart';
import './category_select_screen.dart';

class DepartmentSelectScreen extends StatelessWidget {
  final List<dynamic> depts;

  DepartmentSelectScreen(this.depts);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        title: Text(
          'Select Department',
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
          children: depts
              .map(
                (dept) => SubcategoryDetailCard(
                  name: dept['name'],
                  image: dept['image'],
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) =>
                          CategorySelectScreen(dept['cat'], dept['name']),
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
