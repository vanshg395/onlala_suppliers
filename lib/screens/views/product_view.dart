import 'package:flutter/material.dart';

import './product_tab1_view.dart';
import './product_tab2_view.dart';
import './product_tab3_view.dart';

class ProductView extends StatefulWidget {
  @override
  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).accentColor,
          title: Text(
            'My Products',
            style: Theme.of(context).primaryTextTheme.subtitle.copyWith(
                  color: Colors.white,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w500,
                ),
          ),
          centerTitle: true,
          bottom: TabBar(
            labelColor: Color(0xFF95BFD6),
            labelStyle: TextStyle(fontSize: 14),
            indicatorWeight: 3,
            indicatorColor: Color(0xFF95BFD6),
            labelPadding: EdgeInsets.zero,
            unselectedLabelColor: Colors.white,
            tabs: <Widget>[
              Tab(
                text: 'Product',
              ),
              Tab(
                text: 'Pending Product',
              ),
              Tab(
                text: 'Orders',
              ),
            ],
          ),
        ),
        body: TabBarView(children: [
          ProductTab1View(),
          ProductTab2View(),
          ProductTab3View(),
        ]),
      ),
    );
  }
}
