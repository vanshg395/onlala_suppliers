import 'package:flutter/material.dart';

import './common_button.dart';
import '../screens/order_details_screen.dart';

class OrderCard extends StatelessWidget {
  final String title;
  final String status;
  final Map<String, dynamic> details;

  OrderCard(this.title, this.status, this.details);

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
                  title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: Theme.of(context).primaryTextTheme.headline.copyWith(
                        fontSize: 14,
                      ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  status,
                  style: Theme.of(context).primaryTextTheme.headline.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: CommonButton(
                  bgColor: Theme.of(context).primaryColor,
                  borderColor: Theme.of(context).primaryColor,
                  title: 'VIEW',
                  fontSize: 16,
                  width: 200,
                  borderRadius: 5,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => OrderDetailsScreen(details),
                      ),
                    );
                  },
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
