import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import './common_button.dart';
import '../providers/auth.dart';
import '../utils/constants.dart';

class QueryCard extends StatefulWidget {
  final String userType;
  final String techSpec;
  final String tod;
  final String paymentTerms;
  final String message;
  final String quantity;
  final bool mReview;
  final bool aReview;
  final bool recycle;
  final String id;
  final Function refreshData;
  // final String status;
  // final Map<String, dynamic> details;

  QueryCard(
    this.userType,
    this.techSpec,
    this.tod,
    this.paymentTerms,
    this.message,
    this.quantity,
    this.mReview,
    this.aReview,
    this.recycle,
    this.id,
    this.refreshData,
  );

  @override
  _QueryCardState createState() => _QueryCardState();
}

class _QueryCardState extends State<QueryCard> {
  bool _isLoading = false;

  Future<void> _submit(Map<String, dynamic> body) async {
    bool isConfirm = true;
    await showDialog(
      barrierDismissible: false,
      context: context,
      child: AlertDialog(
        title: Text('Confirm'),
        content: Text(body['manufacturer_review']
            ? 'Are you sure, you want to approve this Inquiry?'
            : 'Are you sure, you want to disapprove this Inquiry?'),
        actions: <Widget>[
          FlatButton(
            child: Text('Yes'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          FlatButton(
              child: Text('No'),
              onPressed: () {
                isConfirm = false;
                Navigator.of(context).pop();
              }),
        ],
      ),
    );
    if (!isConfirm) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    showDialog(
      barrierDismissible: false,
      context: context,
      child: AlertDialog(
        title: Text('Loading'),
        content: Container(
          height: 100,
          child: Center(child: CircularProgressIndicator()),
        ),
      ),
    );
    try {
      final url = baseUrl + 'query/status/';
      final response = await http.post(
        url,
        headers: {
          'Authorization': Provider.of<Auth>(context, listen: false).token,
          'Content-Type': 'application/json',
        },
        body: json.encode(body),
      );
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 202) {
        Navigator.of(context).pop();
        widget.refreshData();
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
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                blurRadius: 4,
                spreadRadius: 1,
                color: Colors.grey,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'User Type',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: Theme.of(context).primaryTextTheme.headline.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  widget.userType,
                  style: Theme.of(context).primaryTextTheme.headline,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Technical Specifications',
                  style: Theme.of(context).primaryTextTheme.headline.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  widget.techSpec,
                  style: Theme.of(context).primaryTextTheme.headline,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Terms of Delivery',
                  style: Theme.of(context).primaryTextTheme.headline.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  widget.tod,
                  style: Theme.of(context).primaryTextTheme.headline,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Payment Terms',
                  style: Theme.of(context).primaryTextTheme.headline.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  widget.paymentTerms,
                  style: Theme.of(context).primaryTextTheme.headline,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Additional Message',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: Theme.of(context).primaryTextTheme.headline.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  widget.message,
                  style: Theme.of(context).primaryTextTheme.headline,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Quantity',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: Theme.of(context).primaryTextTheme.headline.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  widget.quantity,
                  style: Theme.of(context).primaryTextTheme.headline,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Status',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: Theme.of(context).primaryTextTheme.headline.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  widget.mReview
                      ? 'Approved'
                      : (widget.recycle ? 'Rejected' : 'Pending'),
                  style: Theme.of(context).primaryTextTheme.headline,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: CommonButton(
                    bgColor: widget.mReview
                        ? Colors.red
                        : (widget.recycle
                            ? Theme.of(context).canvasColor
                            : (widget.aReview
                                ? Colors.green
                                : Theme.of(context).canvasColor)),
                    borderColor: widget.mReview
                        ? Colors.red
                        : (widget.recycle
                            ? Theme.of(context).canvasColor
                            : (widget.aReview
                                ? Colors.green
                                : Theme.of(context).canvasColor)),
                    title: widget.mReview
                        ? 'Disapprove'
                        : (widget.recycle
                            ? 'Already Rejected'
                            : (widget.aReview
                                ? 'Approve'
                                : 'Waiting for Admin Approval')),
                    fontSize: 16,
                    textColor: widget.mReview
                        ? Colors.white
                        : (widget.recycle
                            ? Colors.black
                            : (widget.aReview ? Colors.white : Colors.black)),
                    width: double.infinity,
                    borderRadius: 5,
                    // onPressed: () {
                    //   _submit(
                    //     widget.mReview
                    //         ? {
                    //             'recycle': true,
                    //             'query_id': widget.id,
                    //             'manufacturer_review': false,
                    //           }
                    //         : (widget.recycle
                    //             ? 'Already Rejected'
                    //             : (widget.aReview
                    //                 ? 'Approve'
                    //                 : 'Waiting for Admin Approval')),
                    //   );
                    // },
                    onPressed: widget.mReview
                        ? () => _submit({
                              'recycle': true,
                              'query_id': widget.id,
                              'manufacturer_review': false,
                            })
                        : (widget.recycle
                            ? () {}
                            : (widget.aReview
                                ? () => _submit({
                                      'recycle': true,
                                      'query_id': widget.id,
                                      'manufacturer_review': true,
                                    })
                                : () {})),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
