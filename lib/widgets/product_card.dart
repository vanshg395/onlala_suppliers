import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final String id;
  final Function onTap;
  final String price;
  final String image;

  ProductCard({
    @required this.name,
    @required this.id,
    @required this.onTap,
    @required this.price,
    @required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
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
            SizedBox(
              height: 30,
            ),
            Center(
              child: Container(
                height: 100,
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                'ID:$id',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: FittedBox(
                child: Text(
                  name,
                  style: Theme.of(context).primaryTextTheme.headline,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                '\$ $price',
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
