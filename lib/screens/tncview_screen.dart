import 'package:flutter/material.dart';

class TnCViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        title: Text(
          'Terms and Conditions',
          style: Theme.of(context).primaryTextTheme.subtitle.copyWith(
                color: Colors.white,
                letterSpacing: 2,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Text(
                'Terms and Conditions',
                style: Theme.of(context).primaryTextTheme.subtitle,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce tincidunt lectus a ante imperdiet mattis. Pellentesque sodales fermentum pellentesque. Donec aliquam tortor nunc, eu pulvinar enim condimentum dignissim. Sed vulputate tortor et porta lacinia. Suspendisse at velit eu elit maximus placerat eget ut magna. Curabitur dui enim, eleifend non libero feugiat, dictum consectetur sem. Etiam at ligula aliquam, suscipit augue efficitur, mollis tortor. Mauris libero mauris, suscipit ut risus non. \n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce tincidunt lectus a ante imperdiet mattis. Pellentesque sodales fermentum pellentesque. Donec aliquam tortor nunc, eu pulvinar enim condimentum dignissim. Sed vulputate tortor et porta lacinia. Suspendisse at velit eu elit maximus placerat eget ut magna. Curabitur dui enim, eleifend non libero feugiat, dictum consectetur sem. Etiam at ligula aliquam, suscipit augue efficitur, mollis tortor. Mauris libero mauris, suscipit ut risus non.',
                style: Theme.of(context).primaryTextTheme.body2,
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
