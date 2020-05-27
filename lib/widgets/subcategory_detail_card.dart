import 'package:flutter/material.dart';

class SubcategoryDetailCard extends StatelessWidget {
  final Function onTap;
  final String image;
  final String name;

  SubcategoryDetailCard({this.name, this.image, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              spreadRadius: 1,
              color: Colors.grey,
            ),
          ],
        ),
        child: LayoutBuilder(
          builder: (ctx, constraints) => Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 3, left: 3, right: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).canvasColor,
                  image: DecorationImage(
                    image: NetworkImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
                height: constraints.maxHeight * 0.6,
              ),
              Expanded(
                child: Center(
                  child: Text(
                    name,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    maxLines: 3,
                    style: Theme.of(context)
                        .primaryTextTheme
                        .body1
                        .copyWith(fontSize: 12),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
