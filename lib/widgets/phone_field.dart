import 'package:flutter/material.dart';

import '../utils/countries.dart';

class PhoneField extends StatefulWidget {
  final String placeholder;
  final Color bgColor;
  final Color borderColor;
  final double borderRadius;
  final String fontFamily;
  final double fontSize;
  final bool isPassword;
  final Widget suffixIcon;
  final TextAlign textAlign;
  final Function onPressed;
  final bool readOnly;
  final double width;
  final Function validator;
  final Function onSaved;
  final Function onChanged;
  final TextInputType keyboardType;
  final int maxLines;
  final double topPadding;
  final TextEditingController controller;

  PhoneField({
    @required this.placeholder,
    @required this.borderColor,
    @required this.bgColor,
    this.fontFamily,
    this.borderRadius = 0,
    this.fontSize = 18,
    this.isPassword = false,
    this.suffixIcon,
    this.textAlign = TextAlign.left,
    this.onPressed,
    this.readOnly = false,
    this.width = double.infinity,
    this.validator,
    this.onSaved,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.topPadding = 0,
    this.controller,
  });

  @override
  _PhoneFieldState createState() => _PhoneFieldState();
}

class _PhoneFieldState extends State<PhoneField> {
  Map<String, dynamic> _selectedCountry =
      countries.where((item) => item['code'] == 'IN').toList()[0];

  List<dynamic> filteredCountries = countries;

  Future<void> _changeCountry() async {
    filteredCountries = countries;
    await showDialog(
      context: context,
      child: StatefulBuilder(
        builder: (ctx, setState) => Dialog(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.search),
                    labelText: 'Search by Country Name',
                  ),
                  onChanged: (value) {
                    setState(() {
                      filteredCountries = countries.where((country) {
                        return country['name'].toLowerCase().contains(value);
                      }).toList();
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (ctx, index) => Column(
                      children: <Widget>[
                        ListTile(
                          leading: Text(
                            filteredCountries[index]['flag'],
                            style: TextStyle(fontSize: 30),
                          ),
                          title: Text(
                            filteredCountries[index]['name'],
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          trailing: Text(
                            filteredCountries[index]['dial_code'],
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                            _selectedCountry = countries
                                .where(
                                  (country) =>
                                      country['code'] ==
                                      filteredCountries[index]['code'],
                                )
                                .toList()[0];
                          },
                        ),
                        Divider(
                          thickness: 1,
                        ),
                      ],
                    ),
                    itemCount: filteredCountries.length,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        InkWell(
          child: Container(
            width: 100,
            child: Row(
              children: <Widget>[
                Text(
                  _selectedCountry['flag'],
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(
                  width: 10,
                ),
                FittedBox(
                  child: Text(
                    _selectedCountry['dial_code'],
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
          onTap: _changeCountry,
        ),
        Expanded(
          child: TextFormField(
            readOnly: widget.readOnly,
            obscureText: widget.isPassword,
            textAlign: widget.textAlign,
            onTap: widget.onPressed,
            controller: widget.controller,
            decoration: InputDecoration(
              fillColor: widget.bgColor,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: BorderSide(
                  width: 0,
                  color: widget.borderColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: BorderSide(
                  width: 0,
                  color: widget.borderColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: BorderSide(
                  width: 0,
                  color: widget.borderColor,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: BorderSide(
                  width: 0,
                  color: widget.borderColor,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: BorderSide(
                  width: 0,
                  color: widget.borderColor,
                ),
              ),
              errorStyle: TextStyle(color: Colors.red[200]),
              alignLabelWithHint: true,
              hintText: widget.placeholder,
              hintStyle: TextStyle(
                color: Theme.of(context).cardColor,
                fontFamily: widget.fontFamily,
              ),
              suffixIcon: Padding(
                padding: const EdgeInsetsDirectional.only(end: 15, start: 10),
                child: widget.suffixIcon,
              ),
              suffixStyle: TextStyle(fontSize: 16),
              contentPadding: EdgeInsets.only(
                left: 30,
                top: widget.topPadding,
              ),
            ),
            style: TextStyle(
              color: Theme.of(context).cardColor,
              fontFamily: widget.fontFamily,
              fontSize: widget.fontSize,
            ),
            maxLines: widget.maxLines,
            onSaved: (value) {
              widget.onSaved([_selectedCountry['dial_code'], value]);
            },
            onChanged: widget.onChanged,
            validator: widget.validator,
            keyboardType: widget.keyboardType,
          ),
        ),
      ],
    );
  }
}
