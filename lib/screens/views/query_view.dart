import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../utils/constants.dart';
import '../../providers/auth.dart';
import '../../widgets/query_card.dart';

class QueryView extends StatefulWidget {
  @override
  _QueryViewState createState() => _QueryViewState();
}

class _QueryViewState extends State<QueryView> {
  List<dynamic> _queries = [];
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
      final url = baseUrl + 'query/manufacturer/view/';
      final response = await http.get(
        url,
        headers: {
          'Authorization': Provider.of<Auth>(context, listen: false).token,
        },
      );
      print(response.statusCode);
      if (response.statusCode == 201) {
        setState(() {
          final resBody = json.decode(response.body);
          _queries = resBody['payload'];
        });
        print(_queries);
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
        : _queries.length == 0
            ? Center(
                child: Text(
                  'No Inquiries',
                  style: Theme.of(context).primaryTextTheme.body1,
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    // Container(
                    //   margin: EdgeInsets.symmetric(horizontal: 20),
                    //   child: QueryCard(),
                    // ),
                    ..._queries
                        .map(
                          (q) => Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            child: QueryCard(
                              q['type_of_user'],
                              q['technical_specifications'],
                              q['terms_of_delivery'],
                              q['payment_terms'],
                              q['additional_message'],
                              q['quantity'].toString(),
                              q['manufacturer_review'],
                              q['admin_review'],
                              q['recycle'],
                              q['id'],
                              getData,
                            ),
                          ),
                        )
                        .toList(),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              );
  }
}
