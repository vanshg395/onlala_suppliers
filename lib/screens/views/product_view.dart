import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../utils/constants.dart';
import '../../providers/auth.dart';
import './product_tab1_view.dart';
import './product_tab2_view.dart';
import './product_tab3_view.dart';

class ProductView extends StatefulWidget {
  @override
  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  List<dynamic> _myProducts = [];
  List<dynamic> _pendingProducts = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final url = baseUrl + 'product/allproduct/app/';
      final response = await http.get(
        url,
        headers: {
          'Authorization': Provider.of<Auth>(context, listen: false).token,
        },
      );
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        final List<dynamic> allProducts = json.decode(response.body)['payload'];
        setState(() {
          _isLoading = false;
          _myProducts =
              allProducts.where((product) => product['admin_review']).toList();
          _pendingProducts =
              allProducts.where((product) => !product['admin_review']).toList();
        });
        print(_myProducts);
        print(_pendingProducts);
      }
    } catch (e) {
      print(e);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
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
                child: Text(
                  'Product',
                  style: Theme.of(context).primaryTextTheme.body1.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
              Tab(
                child: Text(
                  'Pending Product',
                  style: Theme.of(context).primaryTextTheme.body1.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
            ],
          ),
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(
                    Theme.of(context).primaryColor,
                  ),
                ),
              )
            : TabBarView(children: [
                ProductTab1View(_myProducts),
                ProductTab2View(_pendingProducts),
              ]),
      ),
    );
  }
}
