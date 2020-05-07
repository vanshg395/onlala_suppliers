import 'package:flutter/material.dart';

import '../widgets/common_field.dart';
import '../widgets/common_button.dart';
import '../widgets/dropdown.dart';

class ProductUploadScreen extends StatefulWidget {
  @override
  _ProductUploadScreenState createState() => _ProductUploadScreenState();
}

class _ProductUploadScreenState extends State<ProductUploadScreen> {
  int _currentPart = 1;
  Map<String, dynamic> _data = {
    'manufacturer_type': '',
    'sample': '',
    'sample_dimension_unit': '',
  };
  String _sampleDimensionUnit;
  String _sampleWeightUnit;
  String _samplePolicyChoice;
  String _samplePolicy;

  Widget pU1View() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Text(
              'Product Info',
              style: Theme.of(context).primaryTextTheme.subtitle,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Select Type (Manufacturer)',
              style: Theme.of(context).primaryTextTheme.headline,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Radio(
                  value: 'Manufacturer',
                  groupValue: _data['manufacturer_type'],
                  onChanged: (value) {
                    setState(() {
                      _data['manufacturer_type'] = value;
                    });
                  },
                ),
                Text('Manufacturer'),
              ],
            ),
            Row(
              children: <Widget>[
                Radio(
                  value: 'OEM Own Brand',
                  groupValue: _data['manufacturer_type'],
                  onChanged: (value) {
                    setState(() {
                      _data['manufacturer_type'] = value;
                    });
                  },
                ),
                Text('OEM Own Brand'),
              ],
            ),
            Row(
              children: <Widget>[
                Radio(
                  value: 'Trader',
                  groupValue: _data['manufacturer_type'],
                  onChanged: (value) {
                    setState(() {
                      _data['manufacturer_type'] = value;
                    });
                  },
                ),
                Text('Trader'),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Enter Minimum Quantity',
              style: Theme.of(context).primaryTextTheme.headline,
            ),
            SizedBox(
              height: 10,
            ),
            CommonField(
              placeholder: '',
              borderColor: Colors.white,
              bgColor: Colors.white,
              fontSize: 16,
              borderRadius: 5,
              keyboardType: TextInputType.number,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Product Name',
              style: Theme.of(context).primaryTextTheme.headline,
            ),
            SizedBox(
              height: 10,
            ),
            CommonField(
              placeholder: '',
              borderColor: Colors.white,
              bgColor: Colors.white,
              fontSize: 16,
              borderRadius: 5,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Product Description',
              style: Theme.of(context).primaryTextTheme.headline,
            ),
            SizedBox(
              height: 10,
            ),
            CommonField(
              placeholder: '',
              maxLines: 5,
              topPadding: 50,
              borderColor: Colors.white,
              bgColor: Colors.white,
              fontSize: 16,
              borderRadius: 5,
              keyboardType: TextInputType.multiline,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Industry Name',
              style: Theme.of(context).primaryTextTheme.headline,
            ),
            SizedBox(
              height: 10,
            ),
            CommonField(
              placeholder: '',
              borderColor: Colors.white,
              bgColor: Colors.white,
              fontSize: 16,
              borderRadius: 5,
              keyboardType: TextInputType.multiline,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Other Synonyms',
              style: Theme.of(context).primaryTextTheme.headline,
            ),
            SizedBox(
              height: 10,
            ),
            CommonField(
              placeholder: '',
              borderColor: Colors.white,
              bgColor: Colors.white,
              fontSize: 16,
              borderRadius: 5,
              keyboardType: TextInputType.multiline,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Model No. / Size',
              style: Theme.of(context).primaryTextTheme.headline,
            ),
            SizedBox(
              height: 10,
            ),
            CommonField(
              placeholder: '',
              borderColor: Colors.white,
              bgColor: Colors.white,
              fontSize: 16,
              borderRadius: 5,
              keyboardType: TextInputType.multiline,
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                CommonButton(
                  bgColor: Theme.of(context).primaryColor,
                  borderColor: Theme.of(context).primaryColor,
                  title: 'NEXT',
                  textColor: Colors.white,
                  fontSize: 16,
                  // width: double.infinity,
                  borderRadius: 5,
                  width: 150,
                  onPressed: () {
                    setState(() {
                      _currentPart++;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget pU2View() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Text(
              'Product Image',
              style: Theme.of(context).primaryTextTheme.subtitle,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.all(2),
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
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
                    'Primary Product Image',
                    style: Theme.of(context).primaryTextTheme.headline,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CommonButton(
                    bgColor: Color(0xFFE9F0F3),
                    borderColor: Color(0xFFE9F0F3),
                    title: 'Upload File',
                    textColor: Theme.of(context).primaryColor,
                    fontSize: 16,
                    width: double.infinity,
                    borderRadius: 5,
                    onPressed: () {
                      setState(() {
                        _currentPart++;
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.all(2),
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
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
                    'Additional Images',
                    style: Theme.of(context).primaryTextTheme.headline,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CommonButton(
                    bgColor: Color(0xFFE9F0F3),
                    borderColor: Color(0xFFE9F0F3),
                    title: 'Upload File',
                    textColor: Theme.of(context).primaryColor,
                    fontSize: 16,
                    width: double.infinity,
                    borderRadius: 5,
                    onPressed: () {
                      setState(() {
                        _currentPart++;
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.all(2),
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
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
                    'Add Video',
                    style: Theme.of(context).primaryTextTheme.headline,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CommonButton(
                    bgColor: Color(0xFFE9F0F3),
                    borderColor: Color(0xFFE9F0F3),
                    title: 'Upload File',
                    textColor: Theme.of(context).primaryColor,
                    fontSize: 16,
                    width: double.infinity,
                    borderRadius: 5,
                    onPressed: () {
                      setState(() {
                        _currentPart++;
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CommonButton(
                  bgColor: Color(0xFFE9F0F3),
                  borderColor: Color(0xFFE9F0F3),
                  title: 'BACK',
                  textColor: Theme.of(context).accentColor,
                  fontSize: 16,
                  // width: double.infinity,
                  borderRadius: 5,
                  width: 150,
                  onPressed: () {
                    setState(() {
                      _currentPart--;
                    });
                  },
                ),
                CommonButton(
                  bgColor: Theme.of(context).primaryColor,
                  borderColor: Theme.of(context).primaryColor,
                  title: 'NEXT',
                  textColor: Colors.white,
                  fontSize: 16,
                  // width: double.infinity,
                  borderRadius: 5,
                  width: 150,
                  onPressed: () {
                    setState(() {
                      _currentPart++;
                    });
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget pU3View() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Text(
              'Sample Product Details',
              style: Theme.of(context).primaryTextTheme.subtitle,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Sample Availablity',
              style: Theme.of(context).primaryTextTheme.headline,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Radio(
                        value: 'Yes',
                        groupValue: _data['sample'],
                        onChanged: (value) {
                          setState(() {
                            _data['sample'] = value;
                          });
                        },
                      ),
                      Text('Yes'),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Radio(
                        value: 'No',
                        groupValue: _data['sample'],
                        onChanged: (value) {
                          setState(() {
                            _data['sample'] = value;
                          });
                        },
                      ),
                      Text('No'),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Sample Policy',
              style: Theme.of(context).primaryTextTheme.headline,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Radio(
                  value: '1',
                  groupValue: _samplePolicyChoice,
                  onChanged: (value) {
                    setState(() {
                      _samplePolicyChoice = value;
                    });
                  },
                ),
                Text('Select a Sample Policy from the list'),
              ],
            ),
            Row(
              children: <Widget>[
                Radio(
                  value: '2',
                  groupValue: _samplePolicyChoice,
                  onChanged: (value) {
                    setState(() {
                      _samplePolicyChoice = value;
                    });
                  },
                ),
                Text('Enter your own Sample Policy'),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            if (_samplePolicyChoice == '1')
              MultilineDropdownButtonFormField(
                isExpanded: true,
                items: [
                  DropdownMenuItem(
                    child: Text(
                      'Free samples are available',
                      softWrap: false,
                      style: TextStyle(
                        color: Theme.of(context).cardColor,
                        fontFamily: Theme.of(context)
                            .primaryTextTheme
                            .display1
                            .fontFamily,
                        fontSize: 16,
                      ),
                    ),
                    value: 'Free samples are available',
                  ),
                  DropdownMenuItem(
                    child: Text(
                      'Samples are free within a certain price range',
                      style: TextStyle(
                        color: Theme.of(context).cardColor,
                        fontFamily: Theme.of(context)
                            .primaryTextTheme
                            .display1
                            .fontFamily,
                        fontSize: 16,
                      ),
                    ),
                    value: 'Samples are free within a certain price range',
                  ),
                  DropdownMenuItem(
                    child: Text(
                      'We offer free samples, with shipping and charges paid by buyer',
                      style: TextStyle(
                        color: Theme.of(context).cardColor,
                        fontFamily: Theme.of(context)
                            .primaryTextTheme
                            .display1
                            .fontFamily,
                        fontSize: 16,
                      ),
                    ),
                    value:
                        'We offer free samples, with shipping and charges paid by buyer',
                  ),
                  DropdownMenuItem(
                    child: Text(
                      'We offer free samples, and will pay for sample costs, shipping and taxes',
                      style: TextStyle(
                        color: Theme.of(context).cardColor,
                        fontFamily: Theme.of(context)
                            .primaryTextTheme
                            .display1
                            .fontFamily,
                        fontSize: 16,
                      ),
                    ),
                    value:
                        'We offer free samples, and will pay for sample costs, shipping and taxes',
                  ),
                  DropdownMenuItem(
                    child: Text(
                      'We offer samples, with sample costs, shipping and taxes paid by buyer',
                      style: TextStyle(
                        color: Theme.of(context).cardColor,
                        fontFamily: Theme.of(context)
                            .primaryTextTheme
                            .display1
                            .fontFamily,
                        fontSize: 16,
                      ),
                    ),
                    value:
                        'We offer samples, with sample costs, shipping and taxes paid by buyer',
                  ),
                  DropdownMenuItem(
                    child: Text(
                      'We don\'t offer free samples, but will reimburse the buyer once an order is confirmed',
                      style: TextStyle(
                        color: Theme.of(context).cardColor,
                        fontFamily: Theme.of(context)
                            .primaryTextTheme
                            .display1
                            .fontFamily,
                        fontSize: 16,
                      ),
                    ),
                    value:
                        'We don\'t offer free samples, but will reimburse the buyer once an order is confirmed',
                  ),
                  DropdownMenuItem(
                    child: Text(
                      'Contact us for information regarding our sample policy',
                      style: TextStyle(
                        color: Theme.of(context).cardColor,
                        fontFamily: Theme.of(context)
                            .primaryTextTheme
                            .display1
                            .fontFamily,
                        fontSize: 16,
                      ),
                    ),
                    value:
                        'Contact us for information regarding our sample policy',
                  ),
                ],
                value: _samplePolicy,
                iconSize: 30,
                icon: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Icon(Icons.keyboard_arrow_down),
                ),
                iconEnabledColor: Theme.of(context).cardColor,
                iconDisabledColor: Theme.of(context).cardColor,
                onChanged: (val) {
                  setState(() {
                    _samplePolicy = val;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 0,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 0,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 0,
                    ),
                  ),
                  hintText: 'Sample Policy',
                  hintStyle: TextStyle(
                    fontSize: 16,
                  ),
                  labelStyle: TextStyle(
                    fontSize: 16,
                  ),
                  contentPadding: EdgeInsets.only(
                    left: 30,
                    right: 10,
                  ),
                  errorStyle: TextStyle(color: Colors.red[200]),
                ),

                // validator: (value) {
                //   if (value == null) {
                //     return 'This field is required.';
                //   }
                // },
                // onSaved: (value) {
                //   _data['identity_choice'] = value;
                // },
              )
            else if (_samplePolicyChoice == '2')
              CommonField(
                placeholder: 'Enter your Sample Policy',
                borderColor: Colors.white,
                bgColor: Colors.white,
                fontSize: 16,
                borderRadius: 5,
                keyboardType: TextInputType.text,
              ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Sample Cost in USD',
              style: Theme.of(context).primaryTextTheme.headline,
            ),
            SizedBox(
              height: 10,
            ),
            CommonField(
              placeholder: '',
              borderColor: Colors.white,
              bgColor: Colors.white,
              fontSize: 16,
              borderRadius: 5,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.all(2),
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
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
                    'Dimension per Unit (For Courier)',
                    style: Theme.of(context).primaryTextTheme.headline,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CommonField(
                    placeholder: 'Length',
                    borderColor: Colors.grey,
                    bgColor: Colors.white,
                    fontSize: 16,
                    borderRadius: 5,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CommonField(
                    placeholder: 'Width',
                    borderColor: Colors.grey,
                    bgColor: Colors.white,
                    fontSize: 16,
                    borderRadius: 5,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CommonField(
                    placeholder: 'Height',
                    borderColor: Colors.grey,
                    bgColor: Colors.white,
                    fontSize: 16,
                    borderRadius: 5,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MultilineDropdownButtonFormField(
                    isExpanded: true,
                    items: [
                      DropdownMenuItem(
                        child: Text(
                          'Meters',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Theme.of(context).cardColor,
                            fontFamily: Theme.of(context)
                                .primaryTextTheme
                                .display1
                                .fontFamily,
                            fontSize: 16,
                          ),
                        ),
                        value: 'Meters',
                      ),
                      DropdownMenuItem(
                        child: Text(
                          'Centimeters',
                          style: TextStyle(
                            color: Theme.of(context).cardColor,
                            fontFamily: Theme.of(context)
                                .primaryTextTheme
                                .display1
                                .fontFamily,
                            fontSize: 16,
                          ),
                        ),
                        value: 'Centimeters',
                      ),
                      DropdownMenuItem(
                        child: Text(
                          'Feet',
                          style: TextStyle(
                            color: Theme.of(context).cardColor,
                            fontFamily: Theme.of(context)
                                .primaryTextTheme
                                .display1
                                .fontFamily,
                            fontSize: 16,
                          ),
                        ),
                        value: 'Feet',
                      ),
                      DropdownMenuItem(
                        child: Text(
                          'Inches',
                          style: TextStyle(
                            color: Theme.of(context).cardColor,
                            fontFamily: Theme.of(context)
                                .primaryTextTheme
                                .display1
                                .fontFamily,
                            fontSize: 16,
                          ),
                        ),
                        value: 'Inches',
                      ),
                      DropdownMenuItem(
                        child: Text(
                          'Yards',
                          style: TextStyle(
                            color: Theme.of(context).cardColor,
                            fontFamily: Theme.of(context)
                                .primaryTextTheme
                                .display1
                                .fontFamily,
                            fontSize: 16,
                          ),
                        ),
                        value: 'Yards',
                      ),
                    ],
                    value: _sampleDimensionUnit,
                    iconSize: 30,
                    icon: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Icon(Icons.keyboard_arrow_down),
                    ),
                    iconEnabledColor: Theme.of(context).cardColor,
                    iconDisabledColor: Theme.of(context).cardColor,
                    onChanged: (val) {
                      setState(() {
                        _sampleDimensionUnit = val;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 0,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 0,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 0,
                        ),
                      ),
                      alignLabelWithHint: true,
                      hintText: 'Unit',
                      hintStyle: TextStyle(
                        fontSize: 16,
                      ),
                      labelStyle: TextStyle(
                        fontSize: 16,
                      ),
                      contentPadding: EdgeInsets.only(
                        left: 30,
                        right: 10,
                      ),
                      errorStyle: TextStyle(color: Colors.red[200]),
                    ),

                    // validator: (value) {
                    //   if (value == null) {
                    //     return 'This field is required.';
                    //   }
                    // },
                    // onSaved: (value) {
                    //   _data['identity_choice'] = value;
                    // },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.all(2),
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
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
                    'Weight per Unit (For Courier)',
                    style: Theme.of(context).primaryTextTheme.headline,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CommonField(
                    placeholder: '',
                    borderColor: Colors.grey,
                    bgColor: Colors.white,
                    fontSize: 16,
                    borderRadius: 5,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MultilineDropdownButtonFormField(
                    isExpanded: true,
                    items: [
                      DropdownMenuItem(
                        child: Text(
                          'Grams',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Theme.of(context).cardColor,
                            fontFamily: Theme.of(context)
                                .primaryTextTheme
                                .display1
                                .fontFamily,
                            fontSize: 16,
                          ),
                        ),
                        value: 'Grams',
                      ),
                      DropdownMenuItem(
                        child: Text(
                          'Kilograms',
                          style: TextStyle(
                            color: Theme.of(context).cardColor,
                            fontFamily: Theme.of(context)
                                .primaryTextTheme
                                .display1
                                .fontFamily,
                            fontSize: 16,
                          ),
                        ),
                        value: 'Kilograms',
                      ),
                      DropdownMenuItem(
                        child: Text(
                          'Metric Tonnes',
                          style: TextStyle(
                            color: Theme.of(context).cardColor,
                            fontFamily: Theme.of(context)
                                .primaryTextTheme
                                .display1
                                .fontFamily,
                            fontSize: 16,
                          ),
                        ),
                        value: 'Metric Tonnes',
                      ),
                      DropdownMenuItem(
                        child: Text(
                          'Pounds',
                          style: TextStyle(
                            color: Theme.of(context).cardColor,
                            fontFamily: Theme.of(context)
                                .primaryTextTheme
                                .display1
                                .fontFamily,
                            fontSize: 16,
                          ),
                        ),
                        value: 'Pounds',
                      ),
                      DropdownMenuItem(
                        child: Text(
                          'Tons (US)',
                          style: TextStyle(
                            color: Theme.of(context).cardColor,
                            fontFamily: Theme.of(context)
                                .primaryTextTheme
                                .display1
                                .fontFamily,
                            fontSize: 16,
                          ),
                        ),
                        value: 'Tons (US)',
                      ),
                      DropdownMenuItem(
                        child: Text(
                          'Tons (UK)',
                          style: TextStyle(
                            color: Theme.of(context).cardColor,
                            fontFamily: Theme.of(context)
                                .primaryTextTheme
                                .display1
                                .fontFamily,
                            fontSize: 16,
                          ),
                        ),
                        value: 'Tons (UK)',
                      ),
                    ],
                    value: _sampleWeightUnit,
                    iconSize: 30,
                    icon: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Icon(Icons.keyboard_arrow_down),
                    ),
                    iconEnabledColor: Theme.of(context).cardColor,
                    iconDisabledColor: Theme.of(context).cardColor,
                    onChanged: (val) {
                      setState(() {
                        _sampleWeightUnit = val;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 0,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 0,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 0,
                        ),
                      ),
                      alignLabelWithHint: true,
                      hintText: 'Unit',
                      hintStyle: TextStyle(
                        fontSize: 16,
                      ),
                      labelStyle: TextStyle(
                        fontSize: 16,
                      ),
                      contentPadding: EdgeInsets.only(
                        left: 30,
                        right: 10,
                      ),
                      errorStyle: TextStyle(color: Colors.red[200]),
                    ),

                    // validator: (value) {
                    //   if (value == null) {
                    //     return 'This field is required.';
                    //   }
                    // },
                    // onSaved: (value) {
                    //   _data['identity_choice'] = value;
                    // },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.all(2),
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
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
                    'Order Lead Time Range',
                    style: Theme.of(context).primaryTextTheme.headline,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CommonField(
                    placeholder: '',
                    borderColor: Colors.grey,
                    bgColor: Colors.white,
                    fontSize: 16,
                    borderRadius: 5,
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Text('Days to'),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CommonField(
                    placeholder: '',
                    borderColor: Colors.grey,
                    bgColor: Colors.white,
                    fontSize: 16,
                    borderRadius: 5,
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CommonButton(
                  bgColor: Color(0xFFE9F0F3),
                  borderColor: Color(0xFFE9F0F3),
                  title: 'BACK',
                  textColor: Theme.of(context).accentColor,
                  fontSize: 16,
                  // width: double.infinity,
                  borderRadius: 5,
                  width: 150,
                  onPressed: () {
                    setState(() {
                      _currentPart--;
                    });
                  },
                ),
                CommonButton(
                  bgColor: Theme.of(context).primaryColor,
                  borderColor: Theme.of(context).primaryColor,
                  title: 'NEXT',
                  textColor: Colors.white,
                  fontSize: 16,
                  // width: double.infinity,
                  borderRadius: 5,
                  width: 150,
                  onPressed: () {
                    setState(() {
                      _currentPart++;
                    });
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget pU4View() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Text(
              'Payment Info',
              style: Theme.of(context).primaryTextTheme.subtitle,
            ),
            SizedBox(
              height: 20,
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
                        'Bulk Order Details',
                        style: Theme.of(context)
                            .primaryTextTheme
                            .headline
                            .copyWith(fontWeight: FontWeight.w500),
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
                        'Export Cartons Details',
                        style: Theme.of(context)
                            .primaryTextTheme
                            .headline
                            .copyWith(fontWeight: FontWeight.w500),
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
                        'Payment Methods',
                        style: Theme.of(context)
                            .primaryTextTheme
                            .headline
                            .copyWith(fontWeight: FontWeight.w500),
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
              height: 20,
            ),
            Container(
              margin: EdgeInsets.all(2),
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
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
                    'Product Catalogue',
                    style: Theme.of(context).primaryTextTheme.headline,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CommonButton(
                    bgColor: Color(0xFFE9F0F3),
                    borderColor: Color(0xFFE9F0F3),
                    title: 'Upload File',
                    textColor: Theme.of(context).primaryColor,
                    fontSize: 16,
                    width: double.infinity,
                    borderRadius: 5,
                    onPressed: () {
                      setState(() {
                        _currentPart++;
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CommonButton(
                  bgColor: Color(0xFFE9F0F3),
                  borderColor: Color(0xFFE9F0F3),
                  title: 'BACK',
                  textColor: Theme.of(context).accentColor,
                  fontSize: 16,
                  // width: double.infinity,
                  borderRadius: 5,
                  width: 150,
                  onPressed: () {
                    setState(() {
                      _currentPart--;
                    });
                  },
                ),
                CommonButton(
                  bgColor: Theme.of(context).primaryColor,
                  borderColor: Theme.of(context).primaryColor,
                  title: 'DONE',
                  textColor: Colors.white,
                  fontSize: 16,
                  // width: double.infinity,
                  borderRadius: 5,
                  width: 150,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        title: Text(
          'Add Product',
          style: Theme.of(context).primaryTextTheme.subtitle.copyWith(
                color: Colors.white,
                letterSpacing: 2,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          if (_currentPart == 1) pU1View(),
          if (_currentPart == 2) pU2View(),
          if (_currentPart == 3) pU3View(),
          if (_currentPart == 4) pU4View(),
          Column(
            children: <Widget>[
              Container(
                height: 60,
                color: Colors.white,
                alignment: Alignment.center,
                width: double.infinity,
                child: FittedBox(
                  child: Text(
                    'Category >> Subcategory >> Product Name',
                    style: Theme.of(context).primaryTextTheme.headline.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
              ),
              Stack(
                children: <Widget>[
                  Container(
                    height: 5,
                    width: double.infinity,
                    color: Colors.grey[300],
                  ),
                  Container(
                    height: 5,
                    width: MediaQuery.of(context).size.width *
                        (_currentPart == 1
                            ? 0.25
                            : _currentPart == 2
                                ? 0.5
                                : _currentPart == 3 ? 0.75 : 1),
                    color: Theme.of(context).accentColor,
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
