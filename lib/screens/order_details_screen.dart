import 'package:flutter/material.dart';

class OrderDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> details;

  OrderDetailsScreen(this.details);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        title: Text(
          'Order Details',
          style: Theme.of(context).primaryTextTheme.subtitle.copyWith(
                color: Colors.white,
                letterSpacing: 2,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Product Names',
                  style: Theme.of(context).primaryTextTheme.subtitle,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Product Name',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          'Quantity',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ...details['order_items']
                  .map((o) => Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 2,
                                  child: Text(o['item_name']['product_name']),
                                ),
                                Expanded(
                                  child: Center(
                                      child: Text(o['quantity'].toString())),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: Divider(
                                thickness: 2,
                              ),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Technical Specification',
                  style: Theme.of(context).primaryTextTheme.subtitle,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(details['technical_specification']),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Terms of Delivery',
                  style: Theme.of(context).primaryTextTheme.subtitle,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(details['terms_of_delivery']),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Payment Terms',
                  style: Theme.of(context).primaryTextTheme.subtitle,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(details['payment_terms']),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Additional Terms',
                  style: Theme.of(context).primaryTextTheme.subtitle,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(details['additional_message']),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Call Our Executive',
                  style: Theme.of(context).primaryTextTheme.subtitle,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: details['call_our_executive']
                    ? Icon(
                        Icons.check,
                        color: Colors.green,
                        size: 40,
                      )
                    : Icon(
                        Icons.clear,
                        color: Colors.red,
                        size: 40,
                      ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Reports QC Standard',
                  style: Theme.of(context).primaryTextTheme.subtitle,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: details['reports_qc_stand']
                    ? Icon(
                        Icons.check,
                        color: Colors.green,
                        size: 40,
                      )
                    : Icon(
                        Icons.clear,
                        color: Colors.red,
                        size: 40,
                      ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Order Status',
                  style: Theme.of(context).primaryTextTheme.subtitle,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child:
                    Text(details['order_status'] == 0 ? 'Processing' : 'Done'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
