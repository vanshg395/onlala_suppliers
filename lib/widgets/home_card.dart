import 'package:flutter/material.dart';

import './subcategory_card.dart';
import '../screens/subcategory_detail_screen.dart';

class HomeCard extends StatelessWidget {
  final String title;
  final List<dynamic> cat;

  HomeCard({
    @required this.title,
    @required this.cat,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 1,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: <Widget>[
            Text(
              title,
              style: Theme.of(context).primaryTextTheme.subtitle,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 3,
              width: double.infinity,
              color: Theme.of(context).canvasColor,
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                alignment: Alignment.center,
                child: ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  children: <Widget>[
                    // SubcategoryCard(
                    //   icon: Image.asset(
                    //     'assets/img/plug.png',
                    //     scale: 0.8,
                    //   ),
                    //   label: Text(
                    //     'Subcategory 1',
                    //     style: Theme.of(context).primaryTextTheme.body2,
                    //   ),
                    //   onTap: () => Navigator.of(context).push(
                    //     MaterialPageRoute(
                    //       builder: (ctx) =>
                    //           SubcategoryDetailScreen('Subcategory 1'),
                    //     ),
                    //   ),
                    // ),
                    // Divider(),
                    // SubcategoryCard(
                    //   icon: Image.asset(
                    //     'assets/img/phone.png',
                    //     scale: 0.8,
                    //   ),
                    //   label: Text(
                    //     'Subcategory 2',
                    //     style: Theme.of(context).primaryTextTheme.body2,
                    //   ),
                    //   onTap: () => Navigator.of(context).push(
                    //     MaterialPageRoute(
                    //       builder: (ctx) =>
                    //           SubcategoryDetailScreen('Subcategory 2'),
                    //     ),
                    //   ),
                    // ),
                    // Divider(),
                    // SubcategoryCard(
                    //   icon: Image.asset(
                    //     'assets/img/board.png',
                    //     scale: 0.8,
                    //   ),
                    //   label: Text(
                    //     'Subcategory 3',
                    //     style: Theme.of(context).primaryTextTheme.body2,
                    //   ),
                    //   onTap: () => Navigator.of(context).push(
                    //     MaterialPageRoute(
                    //       builder: (ctx) =>
                    //           SubcategoryDetailScreen('Subcategory 3'),
                    //     ),
                    //   ),
                    // ),
                    // Divider(),
                    // SubcategoryCard(
                    //   icon: Image.asset(
                    //     'assets/img/cycle.png',
                    //     scale: 0.8,
                    //   ),
                    //   label: Text(
                    //     'Subcategory 4',
                    //     style: Theme.of(context).primaryTextTheme.body2,
                    //   ),
                    //   onTap: () => Navigator.of(context).push(
                    //     MaterialPageRoute(
                    //       builder: (ctx) =>
                    //           SubcategoryDetailScreen('Subcategory 4'),
                    //     ),
                    //   ),
                    // ),
                    // Divider(),
                    // SubcategoryCard(
                    //   icon: Image.asset(
                    //     'assets/img/react.png',
                    //     scale: 0.8,
                    //   ),
                    //   label: Text(
                    //     'Subcategory 5',
                    //     style: Theme.of(context).primaryTextTheme.body2,
                    //   ),
                    //   onTap: () => Navigator.of(context).push(
                    //     MaterialPageRoute(
                    //       builder: (ctx) =>
                    //           SubcategoryDetailScreen('Subcategory 5'),
                    //     ),
                    //   ),
                    // ),
                    // Divider(),
                    // SubcategoryCard(
                    //   icon: Image.asset(
                    //     'assets/img/specs.png',
                    //     scale: 0.8,
                    //   ),
                    //   label: Text(
                    //     'Subcategory 6',
                    //     style: Theme.of(context).primaryTextTheme.body2,
                    //   ),
                    //   onTap: () => Navigator.of(context).push(
                    //     MaterialPageRoute(
                    //       builder: (ctx) =>
                    //           SubcategoryDetailScreen('Subcategory 6'),
                    //     ),
                    //   ),
                    // ),
                    ...cat
                        .map(
                          (c) => Column(
                            children: <Widget>[
                              SubcategoryCard(
                                // icon: Image.asset(
                                //   'assets/img/specs.png',
                                //   scale: 0.8,
                                // ),
                                label: Text(
                                  c['name'],
                                  style:
                                      Theme.of(context).primaryTextTheme.body2,
                                ),
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (ctx) => SubcategoryDetailScreen(
                                      title,
                                      c['name'],
                                      c['sub_categories'],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                        .toList()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
