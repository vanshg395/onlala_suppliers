import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../utils/constants.dart';
import '../../providers/auth.dart';
import '../../widgets/order_card.dart';

class ProductTab3View extends StatefulWidget {
  @override
  _ProductTab3ViewState createState() => _ProductTab3ViewState();
}

class _ProductTab3ViewState extends State<ProductTab3View> {
  List<dynamic> _orders = [];
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
      final url = baseUrl + 'order/manufacturer/view/';
      final response = await http.get(
        url,
        headers: {
          'Authorization': Provider.of<Auth>(context, listen: false).token,
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        setState(() {
          final resBody = json.decode(response.body);
          _orders = resBody['payload'];
        });
        print(_orders);
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
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(
                Theme.of(context).primaryColor,
              ),
            ),
          )
        : Container(
            child: _orders.length == 0
                ? Center(
                    child: Text('No Orders'),
                  )
                : ListView(
                    padding: EdgeInsets.all(20),
                    children: _orders
                        .map(
                          (order) => OrderCard(
                            order['order_items']
                                .map((o) => o['item_name']['product_name'])
                                .toString(),
                            order['order_status'] == 0 ? 'Processing' : 'Done',
                            order,
                          ),
                        )
                        .toList(),
                  ),
          );
  }
}
