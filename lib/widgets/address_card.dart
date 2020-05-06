import 'package:flutter/material.dart';

class AddressCard extends StatelessWidget {
  final String title;
  final String address;

  AddressCard({@required this.title, @required this.address});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: EdgeInsets.all(10),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context).primaryTextTheme.subtitle,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            address,
            style: Theme.of(context)
                .primaryTextTheme
                .body2
                .copyWith(fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }
}
