import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Function onTap;

  ProductCard({@required this.onTap});

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
              child: Image.asset(
                'assets/img/ghar.png',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                'ID:22323234',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                'PRODUCT NAME',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                '\$50',
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: Theme.of(context).canvasColor,
                        border: Border(
                          right: BorderSide(color: Colors.grey, width: 0.5),
                          top: BorderSide(color: Colors.grey),
                        ),
                      ),
                      child: Center(
                        child: Icon(Icons.edit),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(15),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: Theme.of(context).canvasColor,
                        border: Border(
                          left: BorderSide(color: Colors.grey, width: 0.5),
                          top: BorderSide(color: Colors.grey),
                        ),
                      ),
                      child: Center(
                        child: Icon(Icons.delete),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
