import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dots_indicator/dots_indicator.dart';

import './tabsScreen.dart';
import './product_edit_screen.dart';
import './video_preview_screen.dart';
import '../widgets/common_button.dart';
import '../providers/auth.dart';
import '../utils/constants.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String name;
  final int id;
  final String price;

  ProductDetailsScreen({
    @required this.name,
    @required this.id,
    @required this.price,
  });

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  double _appBarHeight;
  bool _isFirst = false;
  double _currentCarouselIndex = 0;
  List<dynamic> _producatData = [];
  bool _isLoading = false;
  bool _isLoading2 = false;

  @override
  void initState() {
    super.initState();
    getData();
    Future.delayed(Duration.zero, () {
      _appBarHeight = MediaQuery.of(context).size.height * 0.3;
    });
  }

  Future<void> getData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final url = baseUrl + 'product/viewdetail/';
      final response = await http.post(
        url,
        headers: {
          'Authorization': Provider.of<Auth>(context, listen: false).token,
          'Content-Type': 'application/json',
        },
        body: json.encode({'id': widget.id}),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        setState(() {
          _producatData = json.decode(response.body)['payload'];
        });
        print(_producatData);
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
    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(
                  Theme.of(context).primaryColor,
                ),
              ),
            )
          : CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  leading: IconButton(
                    icon: Icon(
                      Icons.chevron_left,
                      size: 30,
                      color: _appBarHeight <
                              MediaQuery.of(context).size.height * 0.9
                          ? Colors.white
                          : Theme.of(context).primaryColor,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  // backgroundColor: Colors.transparent,
                  elevation: 0,
                  expandedHeight: MediaQuery.of(context).size.height * 0.3,
                  pinned: true,
                  backgroundColor: Theme.of(context).primaryColor,
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
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.3,
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.2),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: double.infinity,
                          color: Colors.white,
                          child: SafeArea(
                            child: Stack(
                              children: <Widget>[
                                CarouselSlider(
                                  options: CarouselOptions(
                                      enableInfiniteScroll: false,
                                      autoPlay: true,
                                      pauseAutoPlayOnTouch: true,
                                      viewportFraction: 1,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3,
                                      onPageChanged: (i, _) {
                                        setState(() {
                                          _currentCarouselIndex = i.toDouble();
                                        });
                                      }),
                                  items: <Widget>[
                                    ..._producatData[0]['pictures']
                                        .map(
                                          (pic) => Image.network(
                                            pic['product_image'],
                                            fit: BoxFit.contain,
                                          ),
                                        )
                                        .toList()
                                  ],
                                ),
                                Positioned(
                                  bottom: 20,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    alignment: Alignment.center,
                                    child: DotsIndicator(
                                      dotsCount: _producatData.length == 0
                                          ? 1
                                          : _producatData[0]['pictures'].length,
                                      position: _currentCarouselIndex,
                                      decorator: DotsDecorator(
                                        activeColor:
                                            Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
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
                          'Product Name',
                          // style: TextStyle(
                          //   fontSize: 20,
                          //   fontWeight: FontWeight.w700,
                          //   fontFamily: Theme.of(context)
                          //       .primaryTextTheme
                          //       .body1
                          //       .fontFamily,
                          // ),
                          style: Theme.of(context)
                              .primaryTextTheme
                              .subtitle
                              .copyWith(fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          '${widget.name}',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: Theme.of(context)
                                .primaryTextTheme
                                .body1
                                .fontFamily,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // Row(
                      //   children: <Widget>[
                      //     Padding(
                      //       padding: const EdgeInsets.only(left: 20.0),
                      //       child: Text(
                      //         'Model No: ',
                      //       ),
                      //     ),
                      //     Text(
                      //       _producatData[0]['product']['model_no'],
                      //       style: TextStyle(fontWeight: FontWeight.w700),
                      //     ),
                      //   ],
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          'Model Number',
                          style: Theme.of(context)
                              .primaryTextTheme
                              .subtitle
                              .copyWith(fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          _producatData[0]['product']['model_no'],
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: Theme.of(context)
                                .primaryTextTheme
                                .body1
                                .fontFamily,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 2,
                              spreadRadius: 0.1,
                              color: Colors.grey,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Product Information',
                              style:
                                  Theme.of(context).primaryTextTheme.subtitle,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              'Manufacturer Type',
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .headline
                                  .copyWith(
                                    fontSize: 16,
                                  ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              color: Theme.of(context).canvasColor,
                              padding: EdgeInsets.all(10),
                              width: double.infinity,
                              child: Text(
                                _producatData[0]['product']
                                    ['manufacturer_type'],
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .body1
                                    .copyWith(fontSize: 14),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Description',
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .headline
                                  .copyWith(
                                    fontSize: 16,
                                  ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              color: Theme.of(context).canvasColor,
                              padding: EdgeInsets.all(10),
                              width: double.infinity,
                              child: Text(
                                  _producatData[0]['product']
                                      ['product_description'],
                                  textAlign: TextAlign.justify,
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .body1
                                      .copyWith(fontSize: 14)),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Minimum Order Quantity',
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .headline
                                  .copyWith(
                                    fontSize: 16,
                                  ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              color: Theme.of(context).canvasColor,
                              padding: EdgeInsets.all(10),
                              width: double.infinity,
                              child: Text(
                                _producatData[0]['product']
                                        ['minimum_order_quantity']
                                    .toString(),
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .body1
                                    .copyWith(fontSize: 14),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Industry Name',
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .headline
                                  .copyWith(
                                    fontSize: 16,
                                  ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              color: Theme.of(context).canvasColor,
                              padding: EdgeInsets.all(10),
                              width: double.infinity,
                              child: Text(
                                _producatData[0]['product']['industry_name'],
                                textAlign: TextAlign.justify,
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .body1
                                    .copyWith(fontSize: 14),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Other Synonyms',
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .headline
                                  .copyWith(
                                    fontSize: 16,
                                  ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              color: Theme.of(context).canvasColor,
                              padding: EdgeInsets.all(10),
                              width: double.infinity,
                              child: Text(
                                _producatData[0]['product']['other_synonyms'],
                                textAlign: TextAlign.justify,
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .body1
                                    .copyWith(fontSize: 14),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Quantity Per Carton',
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .headline
                                  .copyWith(
                                    fontSize: 16,
                                  ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              color: Theme.of(context).canvasColor,
                              padding: EdgeInsets.all(10),
                              width: double.infinity,
                              child: Text(
                                _producatData[0]['product']
                                    ['quantity_per_carton'],
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .body1
                                    .copyWith(fontSize: 14),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Payment Method',
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .headline
                                  .copyWith(
                                    fontSize: 16,
                                  ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              color: Theme.of(context).canvasColor,
                              padding: EdgeInsets.all(10),
                              width: double.infinity,
                              child: Text(
                                _producatData[0]['product']['payment_method'],
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .body1
                                    .copyWith(fontSize: 14),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Tech Transfer Investment',
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .headline
                                  .copyWith(
                                    fontSize: 16,
                                  ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              color: Theme.of(context).canvasColor,
                              padding: EdgeInsets.all(10),
                              width: double.infinity,
                              child: Text(
                                _producatData[0]['product']
                                        ['tech_transfer_investment']
                                    ? 'Yes'
                                    : 'No',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .body1
                                    .copyWith(fontSize: 14),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'HS Code',
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .headline
                                  .copyWith(
                                    fontSize: 16,
                                  ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              color: Theme.of(context).canvasColor,
                              padding: EdgeInsets.all(10),
                              width: double.infinity,
                              child: Text(
                                _producatData[0]['sample_details']['hs_code'],
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .body1
                                    .copyWith(fontSize: 14),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Time Range',
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .headline
                                  .copyWith(
                                    fontSize: 16,
                                  ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              color: Theme.of(context).canvasColor,
                              padding: EdgeInsets.all(10),
                              width: double.infinity,
                              child: Text(
                                _producatData[0]['sample_details']
                                            ['sample_from_time_range']
                                        .toString() +
                                    ' to ' +
                                    _producatData[0]['sample_details']
                                            ['sample_to_time_range']
                                        .toString() +
                                    ' days',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .body1
                                    .copyWith(fontSize: 14),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Expiry Date',
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .headline
                                  .copyWith(
                                    fontSize: 16,
                                  ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              color: Theme.of(context).canvasColor,
                              padding: EdgeInsets.all(10),
                              width: double.infinity,
                              child: Text(
                                _producatData[0]['product']['expiry_date'],
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .body1
                                    .copyWith(fontSize: 14),
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
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 2,
                              spreadRadius: 0.1,
                              color: Colors.grey,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Sample Order',
                              style:
                                  Theme.of(context).primaryTextTheme.subtitle,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            if (!_producatData[0]['sample_details']['sample'])
                              Text(
                                'No Sample Order available',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .body1
                                    .copyWith(fontSize: 14),
                              )
                            else ...[
                              Text(
                                'Sample Cost (EUR)',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .headline
                                    .copyWith(
                                      fontSize: 16,
                                    ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                color: Theme.of(context).canvasColor,
                                padding: EdgeInsets.all(10),
                                width: double.infinity,
                                child: Text(
                                  _producatData[0]['sample_details']
                                          ['sample_cost']
                                      .toString(),
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .body1
                                      .copyWith(fontSize: 14),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Sample Length',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .headline
                                    .copyWith(
                                      fontSize: 16,
                                    ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                color: Theme.of(context).canvasColor,
                                padding: EdgeInsets.all(10),
                                width: double.infinity,
                                child: Text(
                                  _producatData[0]['sample_details']
                                          ['sample_dimension_length']
                                      .toString(),
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .body1
                                      .copyWith(fontSize: 14),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Sample Breadth',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .headline
                                    .copyWith(
                                      fontSize: 16,
                                    ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                color: Theme.of(context).canvasColor,
                                padding: EdgeInsets.all(10),
                                width: double.infinity,
                                child: Text(
                                  _producatData[0]['sample_details']
                                          ['sample_dimension_breadth']
                                      .toString(),
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .body1
                                      .copyWith(fontSize: 14),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Sample Height',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .headline
                                    .copyWith(
                                      fontSize: 16,
                                    ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                color: Theme.of(context).canvasColor,
                                padding: EdgeInsets.all(10),
                                width: double.infinity,
                                child: Text(
                                  _producatData[0]['sample_details']
                                          ['sample_dimension_height']
                                      .toString(),
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .body1
                                      .copyWith(fontSize: 14),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Sample Dimension Unit',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .headline
                                    .copyWith(
                                      fontSize: 16,
                                    ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                color: Theme.of(context).canvasColor,
                                padding: EdgeInsets.all(10),
                                width: double.infinity,
                                child: Text(
                                  _producatData[0]['sample_details']
                                      ['sample_dimension_unit'],
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .body1
                                      .copyWith(fontSize: 14),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Sample Weight',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .headline
                                    .copyWith(
                                      fontSize: 16,
                                    ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                color: Theme.of(context).canvasColor,
                                padding: EdgeInsets.all(10),
                                width: double.infinity,
                                child: Text(
                                  _producatData[0]['sample_details']
                                          ['sample_weight']
                                      .toString(),
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .body1
                                      .copyWith(fontSize: 14),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Sample Weight Unit',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .headline
                                    .copyWith(
                                      fontSize: 16,
                                    ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                color: Theme.of(context).canvasColor,
                                padding: EdgeInsets.all(10),
                                width: double.infinity,
                                child: Text(
                                  _producatData[0]['sample_details']
                                          ['sample_weight_unit']
                                      .toString(),
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .body1
                                      .copyWith(fontSize: 14),
                                ),
                              ),
                            ]
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 2,
                              spreadRadius: 0.1,
                              color: Colors.grey,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Bulk Order',
                              style:
                                  Theme.of(context).primaryTextTheme.subtitle,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            if (!_producatData[0]['bulkorder_details']
                                ['bulk_order'])
                              Text(
                                'No Bulk Order available',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .body1
                                    .copyWith(fontSize: 14),
                              )
                            else ...[
                              Text(
                                'Bulk Order Price Type',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .headline
                                    .copyWith(
                                      fontSize: 16,
                                    ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                color: Theme.of(context).canvasColor,
                                padding: EdgeInsets.all(10),
                                width: double.infinity,
                                child: Text(
                                  _producatData[0]['bulkorder_details']
                                          ['bulk_order_price_type']
                                      .toString(),
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .body1
                                      .copyWith(fontSize: 14),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Bulk Order Port Name',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .headline
                                    .copyWith(
                                      fontSize: 16,
                                    ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                color: Theme.of(context).canvasColor,
                                padding: EdgeInsets.all(10),
                                width: double.infinity,
                                child: Text(
                                  _producatData[0]['bulkorder_details']
                                          ['bulk_order_port']
                                      .toString(),
                                  textAlign: TextAlign.justify,
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .body1
                                      .copyWith(fontSize: 14),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Bulk Order Price',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .headline
                                    .copyWith(
                                      fontSize: 16,
                                    ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                color: Theme.of(context).canvasColor,
                                padding: EdgeInsets.all(10),
                                width: double.infinity,
                                child: Text(
                                  _producatData[0]['bulkorder_details']
                                          ['bulk_order_price']
                                      .toString()
                                      .toString(),
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .body1
                                      .copyWith(fontSize: 14),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Bulk Order Price Unit',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .headline
                                    .copyWith(
                                      fontSize: 16,
                                    ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                color: Theme.of(context).canvasColor,
                                padding: EdgeInsets.all(10),
                                width: double.infinity,
                                child: Text(
                                  _producatData[0]['bulkorder_details']
                                          ['bulk_order_price_unit']
                                      .toString(),
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .body1
                                      .copyWith(fontSize: 14),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Bulk Order Time Range',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .headline
                                    .copyWith(
                                      fontSize: 16,
                                    ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                color: Theme.of(context).canvasColor,
                                padding: EdgeInsets.all(10),
                                width: double.infinity,
                                child: Text(
                                  _producatData[0]['bulkorder_details']
                                              ['bulk_order_from_time_range']
                                          .toString() +
                                      ' to ' +
                                      _producatData[0]['bulkorder_details']
                                              ['bulk_order_to_time_range']
                                          .toString() +
                                      ' days',
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .body1
                                      .copyWith(fontSize: 14),
                                ),
                              ),
                            ]
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 2,
                              spreadRadius: 0.1,
                              color: Colors.grey,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Carton Details',
                              style:
                                  Theme.of(context).primaryTextTheme.subtitle,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              'Carton Length',
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .headline
                                  .copyWith(
                                    fontSize: 16,
                                  ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              color: Theme.of(context).canvasColor,
                              padding: EdgeInsets.all(10),
                              width: double.infinity,
                              child: Text(
                                _producatData[0]['carton_details']
                                        ['carton_dimension_length']
                                    .toString(),
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .body1
                                    .copyWith(fontSize: 14),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Carton Breadth',
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .headline
                                  .copyWith(
                                    fontSize: 16,
                                  ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              color: Theme.of(context).canvasColor,
                              padding: EdgeInsets.all(10),
                              width: double.infinity,
                              child: Text(
                                _producatData[0]['carton_details']
                                        ['carton_dimension_breadth']
                                    .toString(),
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .body1
                                    .copyWith(fontSize: 14),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Carton Height',
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .headline
                                  .copyWith(
                                    fontSize: 16,
                                  ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              color: Theme.of(context).canvasColor,
                              padding: EdgeInsets.all(10),
                              width: double.infinity,
                              child: Text(
                                _producatData[0]['carton_details']
                                        ['carton_dimension_height']
                                    .toString()
                                    .toString(),
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .body1
                                    .copyWith(fontSize: 14),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Carton Dimension Unit',
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .headline
                                  .copyWith(
                                    fontSize: 16,
                                  ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              color: Theme.of(context).canvasColor,
                              padding: EdgeInsets.all(10),
                              width: double.infinity,
                              child: Text(
                                _producatData[0]['carton_details']
                                        ['carton_dimension_unit']
                                    .toString(),
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .body1
                                    .copyWith(fontSize: 14),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Carton Weight',
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .headline
                                  .copyWith(
                                    fontSize: 16,
                                  ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              color: Theme.of(context).canvasColor,
                              padding: EdgeInsets.all(10),
                              width: double.infinity,
                              child: Text(
                                _producatData[0]['carton_details']
                                        ['carton_weight']
                                    .toString(),
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .body1
                                    .copyWith(fontSize: 14),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Carton Weight Unit',
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .headline
                                  .copyWith(
                                    fontSize: 16,
                                  ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              color: Theme.of(context).canvasColor,
                              padding: EdgeInsets.all(10),
                              width: double.infinity,
                              child: Text(
                                _producatData[0]['carton_details']
                                        ['carton_weight_unit']
                                    .toString(),
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .body1
                                    .copyWith(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 2,
                              spreadRadius: 0.1,
                              color: Colors.grey,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Videos',
                              style:
                                  Theme.of(context).primaryTextTheme.subtitle,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            if (_producatData[0]['videos'].length > 0)
                              GridView.count(
                                shrinkWrap: true,
                                crossAxisSpacing: 5,
                                crossAxisCount: 3,
                                padding: EdgeInsets.zero,
                                children: [
                                  ..._producatData[0]['videos']
                                      .map(
                                        (video) => InkWell(
                                          child: Icon(
                                            Icons.play_circle_filled,
                                            size: 40,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                          onTap: () =>
                                              Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (ctx) =>
                                                  VideoPreviewScreen(
                                                      video['product_video']),
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList()
                                ],
                              )
                            else
                              Text(
                                'No Videos Available',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .body1
                                    .copyWith(fontSize: 14),
                              )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 2,
                              spreadRadius: 0.1,
                              color: Colors.grey,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Catalogue',
                              style:
                                  Theme.of(context).primaryTextTheme.subtitle,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            if (_producatData[0]['catalog'].length > 0)
                              GridView.count(
                                shrinkWrap: true,
                                crossAxisSpacing: 5,
                                crossAxisCount: 3,
                                padding: EdgeInsets.zero,
                                children: [
                                  ..._producatData[0]['catalog']
                                      .map(
                                        (catalog) => InkWell(
                                            child: Icon(
                                              Icons.remove_red_eye,
                                              size: 40,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            onTap: () async {
                                              if (await canLaunch(
                                                  catalog['product_catalog'])) {
                                                await launch(
                                                    catalog['product_catalog']);
                                              }
                                            }),
                                      )
                                      .toList()
                                ],
                              )
                            else
                              Text(
                                'No Catalogue Available',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .body1
                                    .copyWith(fontSize: 14),
                              )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                      _isLoading2
                          ? Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(
                                    Theme.of(context).primaryColor),
                              ),
                            )
                          : Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                    onPressed: () async {
                                      bool isNotConfirm = false;
                                      await showDialog(
                                        context: context,
                                        child: AlertDialog(
                                          title: Text('Confirm'),
                                          content: Text(
                                              'Are you sure, you want to delete this product?'),
                                          actions: <Widget>[
                                            FlatButton(
                                              child: Text('YES'),
                                              onPressed: () =>
                                                  Navigator.of(context).pop(),
                                            ),
                                            FlatButton(
                                                child: Text('NO'),
                                                onPressed: () {
                                                  isNotConfirm = true;
                                                  Navigator.of(context).pop();
                                                }),
                                          ],
                                        ),
                                      );
                                      if (isNotConfirm) {
                                        return;
                                      }
                                      setState(() {
                                        _isLoading2 = true;
                                      });
                                      try {
                                        final url = baseUrl + 'product/delete/';
                                        final response = await http.post(
                                          url,
                                          headers: {
                                            'Authorization': Provider.of<Auth>(
                                                    context,
                                                    listen: false)
                                                .token,
                                            'Content-Type': 'application/json',
                                          },
                                          body: json.encode(
                                            {
                                              'product_id': _producatData[0]
                                                  ['product']['id']
                                            },
                                          ),
                                        );
                                        print(response.statusCode);
                                        if (response.statusCode == 204) {
                                          setState(() {
                                            _isLoading2 = false;
                                          });
                                          await showDialog(
                                            context: context,
                                            child: AlertDialog(
                                              title: Text('Success'),
                                              content: Text(
                                                  'Product has been deleted'),
                                              actions: <Widget>[
                                                FlatButton(
                                                  child: Text('OK'),
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pop(),
                                                ),
                                              ],
                                            ),
                                          );
                                          Navigator.of(context).pop('deleted');
                                        } else {
                                          await showDialog(
                                            context: context,
                                            child: AlertDialog(
                                              title: Text('Error'),
                                              content: Text(
                                                  'Product could not be deleted'),
                                              actions: <Widget>[
                                                FlatButton(
                                                  child: Text('OK'),
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pop(),
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                      } catch (e) {}
                                      setState(() {
                                        _isLoading2 = false;
                                      });
                                    },
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
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(
                                        MaterialPageRoute(
                                          builder: (ctx) => ProductEditScreen(
                                            _producatData[0]['sub_category']
                                                    ['categories']['department']
                                                ['name'],
                                            _producatData[0]['sub_category']
                                                ['categories']['name'],
                                            _producatData[0]['sub_category']
                                                ['sub_categories'],
                                            _producatData[0]['sub_category']
                                                ['id'],
                                            _producatData,
                                          ),
                                        ),
                                      )
                                          .then((value) {
                                        if (value == 'updated') {
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                              builder: (ctx) => TabsScreen(),
                                            ),
                                          );
                                        }
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
