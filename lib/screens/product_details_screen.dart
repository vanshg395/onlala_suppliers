import 'package:flutter/material.dart';

import '../widgets/common_button.dart';

class ProductDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      // ),
      // body: Column(
      //   children: <Widget>[
      //     Container(
      //       height: MediaQuery.of(context).size.height * 0.25,
      //       width: double.infinity,
      //       color: Colors.teal,
      //       child: Image.asset(
      //         'assets/img/homedevice.png',
      //         fit: BoxFit.cover,
      //       ),
      //     ),
      //   ],
      // ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            leading: IconButton(
              icon: Icon(
                Icons.chevron_left,
                size: 30,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            expandedHeight: MediaQuery.of(context).size.height * 0.3,
            // pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              // title: Text(
              //   'Product Stabilizer',
              //   style: Theme.of(context).primaryTextTheme.subtitle.copyWith(
              //         color: Colors.white,
              //         letterSpacing: 2,
              //         fontWeight: FontWeight.w500,
              //       ),
              // ),
              background: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: double.infinity,
                    // color: Colors.teal,
                    child: Image.asset(
                      'assets/img/ghar.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.3,
                    color: Theme.of(context).primaryColor.withOpacity(0.8),
                  )
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    'ID:22323234',
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Product Stabilizer',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
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
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text('It\'s Power Station\s Product.'),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Model: ',
                      ),
                    ),
                    Text(
                      'Hju790',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  indent: 20,
                  endIndent: 20,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10,
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Bulk Order',
                            style: Theme.of(context).primaryTextTheme.headline,
                          ),
                          InkWell(
                            child: Icon(Icons.keyboard_arrow_down),
                            onTap: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(
                  indent: 20,
                  endIndent: 20,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10,
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Sample Order',
                            style: Theme.of(context).primaryTextTheme.headline,
                          ),
                          InkWell(
                            child: Icon(Icons.keyboard_arrow_down),
                            onTap: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(
                  indent: 20,
                  endIndent: 20,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10,
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Export Details',
                            style: Theme.of(context).primaryTextTheme.headline,
                          ),
                          InkWell(
                            child: Icon(Icons.keyboard_arrow_down),
                            onTap: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(
                  indent: 20,
                  endIndent: 20,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      CommonButton(
                        bgColor: Color(0xFFDFE9ED),
                        borderColor: Color(0xFFDFE9ED),
                        title: 'DELETE',
                        textColor: Theme.of(context).primaryColor,
                        fontSize: 16,
                        // width: double.infinity,
                        borderRadius: 5,
                        width: 150,
                        onPressed: () {},
                      ),
                      CommonButton(
                        bgColor: Theme.of(context).primaryColor,
                        borderColor: Theme.of(context).primaryColor,
                        title: 'EDIT',
                        textColor: Colors.white,
                        fontSize: 16,
                        // width: double.infinity,
                        borderRadius: 5,
                        width: 150,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
