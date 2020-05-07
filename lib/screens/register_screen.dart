import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';

import '../widgets/common_field.dart';
import '../widgets/common_button.dart';
import '../providers/auth.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, dynamic> _registerData = {
    'email': '',
    'password': '',
    'first_name': '',
    'last_name': '',
  };

  Map<String, dynamic> _loginData = {
    'username': '',
    'password': '',
  };

  Map<String, dynamic> _manufCreateData = {
    'postal_state': '',
    'postal_city': '',
    'postal_country': '',
    'postal_code': '',
    'mobile': '',
    'postal_address1': '',
    'company': '',
    'company_email': '',
    'department': '',
    'administrativeArea': '',
    'isoCountryCode': '',
  };

  Future<void> _submit() async {
    _formKey.currentState.save();
    print(_registerData);
    print(_loginData);
    print(_manufCreateData);
    if (!_formKey.currentState.validate()) {
      return;
    }
    print('hey');
    try {
      await Provider.of<Auth>(context, listen: false).register(_registerData);
      await Provider.of<Auth>(context, listen: false).login(_loginData);
      await Provider.of<Auth>(context, listen: false)
          .createManufacturer(_manufCreateData);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 50),
                    alignment: Alignment.center,
                    child: Text(
                      'Sign Up',
                      style: Theme.of(context).primaryTextTheme.title,
                    ),
                  ),
                  Text(
                    'First Name',
                    style: Theme.of(context).primaryTextTheme.headline,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CommonField(
                    placeholder: 'First Name',
                    borderColor: Theme.of(context).canvasColor,
                    bgColor: Theme.of(context).canvasColor,
                    fontSize: 16,
                    borderRadius: 5,
                    validator: (value) {
                      if (value == '') {
                        return 'This field is required.';
                      }
                    },
                    onSaved: (value) {
                      _registerData['first_name'] = value;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Last Name',
                    style: Theme.of(context).primaryTextTheme.headline,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CommonField(
                    placeholder: 'Last Name',
                    borderColor: Theme.of(context).canvasColor,
                    bgColor: Theme.of(context).canvasColor,
                    fontSize: 16,
                    borderRadius: 5,
                    validator: (value) {
                      if (value == '') {
                        return 'This field is required.';
                      }
                    },
                    onSaved: (value) {
                      _registerData['last_name'] = value;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Email Address',
                    style: Theme.of(context).primaryTextTheme.headline,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CommonField(
                    placeholder: 'Your Email Address',
                    borderColor: Theme.of(context).canvasColor,
                    bgColor: Theme.of(context).canvasColor,
                    fontSize: 16,
                    borderRadius: 5,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == '') {
                        return 'This field is required.';
                      }
                      if (!RegExp(
                              r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                          .hasMatch(value)) {
                        return 'Please enter a valid email.';
                      }
                    },
                    onSaved: (value) {
                      _registerData['email'] = value;
                      _loginData['username'] = value;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Password',
                    style: Theme.of(context).primaryTextTheme.headline,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CommonField(
                    placeholder: 'Password',
                    borderColor: Theme.of(context).canvasColor,
                    bgColor: Theme.of(context).canvasColor,
                    fontSize: 16,
                    borderRadius: 5,
                    isPassword: true,
                    validator: (value) {
                      if (value == '') {
                        return 'This field is required.';
                      }
                    },
                    onSaved: (value) {
                      _registerData['password'] = value;
                      _loginData['password'] = value;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Confirm Password',
                    style: Theme.of(context).primaryTextTheme.headline,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CommonField(
                    placeholder: 'Re-Enter Password',
                    borderColor: Theme.of(context).canvasColor,
                    bgColor: Theme.of(context).canvasColor,
                    fontSize: 16,
                    borderRadius: 5,
                    isPassword: true,
                    validator: (value) {
                      if (value == '') {
                        return 'This field is required.';
                      }
                      if (value != _registerData['password']) {
                        return 'Passwords do not match.';
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Phone Number',
                    style: Theme.of(context).primaryTextTheme.headline,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  InternationalPhoneNumberInput(
                    initialValue: PhoneNumber(isoCode: 'US'),
                    // autoFocus: true,
                    inputDecoration: InputDecoration(
                      fillColor: Theme.of(context).canvasColor,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          width: 0,
                          color: Theme.of(context).canvasColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          width: 0,
                          color: Theme.of(context).canvasColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          width: 0,
                          color: Theme.of(context).canvasColor,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          width: 0,
                          color: Theme.of(context).canvasColor,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          width: 0,
                          color: Theme.of(context).canvasColor,
                        ),
                      ),
                      // errorStyle: TextStyle(color: Colors.red[200]),
                      hintText: 'Phone Number',
                      hintStyle: TextStyle(
                        color: Theme.of(context).cardColor,
                      ),
                    ),
                    selectorType: PhoneInputSelectorType.DIALOG,
                    formatInput: false,
                    onInputChanged: (phone) {
                      // _manufCreateData['mobile'] = phone.phoneNumber;
                      // _manufCreateData['isoCountryCode'] = phone.isoCode;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Business Department',
                    style: Theme.of(context).primaryTextTheme.headline,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CommonField(
                    placeholder: '',
                    borderColor: Theme.of(context).canvasColor,
                    bgColor: Theme.of(context).canvasColor,
                    fontSize: 16,
                    borderRadius: 5,
                    validator: (value) {
                      if (value == '') {
                        return 'This field is required.';
                      }
                    },
                    onSaved: (value) {
                      _manufCreateData['department'] = value;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Company Name',
                    style: Theme.of(context).primaryTextTheme.headline,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CommonField(
                    placeholder: '',
                    borderColor: Theme.of(context).canvasColor,
                    bgColor: Theme.of(context).canvasColor,
                    fontSize: 16,
                    borderRadius: 5,
                    validator: (value) {
                      if (value == '') {
                        return 'This field is required.';
                      }
                    },
                    onSaved: (value) {
                      _manufCreateData['company'] = value;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Company Email',
                    style: Theme.of(context).primaryTextTheme.headline,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CommonField(
                    placeholder: '',
                    borderColor: Theme.of(context).canvasColor,
                    bgColor: Theme.of(context).canvasColor,
                    fontSize: 16,
                    borderRadius: 5,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == '') {
                        return 'This field is required.';
                      }
                      if (!RegExp(
                              r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                          .hasMatch(value)) {
                        return 'Please enter a valid email.';
                      }
                    },
                    onSaved: (value) {
                      _manufCreateData['company_email'] = value;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Administrative Area',
                    style: Theme.of(context).primaryTextTheme.headline,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CommonField(
                    placeholder: '',
                    borderColor: Theme.of(context).canvasColor,
                    bgColor: Theme.of(context).canvasColor,
                    fontSize: 16,
                    borderRadius: 5,
                    validator: (value) {
                      if (value == '') {
                        return 'This field is required.';
                      }
                    },
                    onSaved: (value) {
                      _manufCreateData['administrativeArea'] = value;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Postal Address',
                    style: Theme.of(context).primaryTextTheme.headline,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CommonField(
                    placeholder: '',
                    borderColor: Theme.of(context).canvasColor,
                    bgColor: Theme.of(context).canvasColor,
                    fontSize: 16,
                    borderRadius: 5,
                    validator: (value) {
                      if (value == '') {
                        return 'This field is required.';
                      }
                    },
                    onSaved: (value) {
                      _manufCreateData['postal_address1'] = value;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'City',
                    style: Theme.of(context).primaryTextTheme.headline,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CommonField(
                    placeholder: '',
                    borderColor: Theme.of(context).canvasColor,
                    bgColor: Theme.of(context).canvasColor,
                    fontSize: 16,
                    borderRadius: 5,
                    validator: (value) {
                      if (value == '') {
                        return 'This field is required.';
                      }
                    },
                    onSaved: (value) {
                      _manufCreateData['postal_city'] = value;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'State',
                    style: Theme.of(context).primaryTextTheme.headline,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CommonField(
                    placeholder: '',
                    borderColor: Theme.of(context).canvasColor,
                    bgColor: Theme.of(context).canvasColor,
                    fontSize: 16,
                    borderRadius: 5,
                    validator: (value) {
                      if (value == '') {
                        return 'This field is required.';
                      }
                    },
                    onSaved: (value) {
                      _manufCreateData['postal_state'] = value;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Country',
                    style: Theme.of(context).primaryTextTheme.headline,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CommonField(
                    placeholder: '',
                    borderColor: Theme.of(context).canvasColor,
                    bgColor: Theme.of(context).canvasColor,
                    fontSize: 16,
                    borderRadius: 5,
                    validator: (value) {
                      if (value == '') {
                        return 'This field is required.';
                      }
                    },
                    onSaved: (value) {
                      _manufCreateData['postal_country'] = value;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Postal Code',
                    style: Theme.of(context).primaryTextTheme.headline,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CommonField(
                    placeholder: '',
                    borderColor: Theme.of(context).canvasColor,
                    bgColor: Theme.of(context).canvasColor,
                    fontSize: 16,
                    borderRadius: 5,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == '') {
                        return 'This field is required.';
                      }
                    },
                    onSaved: (value) {
                      _manufCreateData['postal_code'] = value;
                    },
                  ),
                  SizedBox(
                    height: mediaQuery.height * 0.07,
                  ),
                  CommonButton(
                    bgColor: Theme.of(context).primaryColor,
                    borderColor: Theme.of(context).primaryColor,
                    title: 'SIGN UP',
                    fontSize: 16,
                    width: double.infinity,
                    borderRadius: 5,
                    onPressed: _submit,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'I already have an account. ',
                        style: Theme.of(context).primaryTextTheme.body2,
                      ),
                      InkWell(
                        child: Text(
                          'Login Now',
                          style: Theme.of(context)
                              .primaryTextTheme
                              .body2
                              .copyWith(color: Theme.of(context).accentColor),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
