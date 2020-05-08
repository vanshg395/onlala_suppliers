import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/common_field.dart';
import '../widgets/common_button.dart';
import '../widgets/phone_field.dart';
import './login_screen.dart';
import '../providers/auth.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> _formKey = GlobalKey();
  bool _isLoading = false;
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
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<Auth>(context, listen: false).register(_registerData);
      await Provider.of<Auth>(context, listen: false).login(_loginData, false);
      await Provider.of<Auth>(context, listen: false)
          .createManufacturer(_manufCreateData);
      setState(() {
        _isLoading = false;
      });
      await showDialog(
        context: context,
        child: AlertDialog(
          title: Text('Success'),
          content: Text(
              'You have been registered successfully. Please verify your email to login.'),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => LoginScreen(),
        ),
      );
    } catch (e) {
      print(e);
      String errorTitle = '';
      String errorMessage = '';
      if (e.toString() == 'User exists') {
        errorTitle = 'Error';
        errorMessage = 'This email is already in use. Please try again.';
      } else if (e.toString() == 'Error') {
        errorTitle = 'Error';
        errorMessage = 'Something went wrong. Please try again.';
      } else if (e.toString() == 'Error1') {
        errorTitle = 'Error';
        errorMessage = 'Something went wrong. Please try again.';
      } else if (e.toString() == 'Repeated Phone') {
        Provider.of<Auth>(context, listen: false).deleteUser();
        errorTitle = 'Error';
        errorMessage = 'This phone number is already in use. Please try again.';
      } else if (e.toString() == 'Server Overload') {
        errorTitle = 'Error';
        errorMessage = 'Server is under heavy load. Please try again later.';
      } else {
        errorTitle = 'Error';
        errorMessage = 'Something went wrong. Please try again.';
      }
      await showDialog(
        context: context,
        child: AlertDialog(
          title: Text(errorTitle),
          content: Text(errorMessage),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }
    setState(() {
      _isLoading = false;
    });
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
                      _manufCreateData['company_email'] = value;
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
                  PhoneField(
                    placeholder: '',
                    borderColor: Theme.of(context).canvasColor,
                    bgColor: Theme.of(context).canvasColor,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == '') {
                        return 'This field is required.';
                      }
                    },
                    onSaved: (value) {
                      print(value);
                      _manufCreateData['mobile'] = value[1];
                      _manufCreateData['isoCountryCode'] = value[0];
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
                  _isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(
                              Theme.of(context).primaryColor,
                            ),
                          ),
                        )
                      : CommonButton(
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
                        onTap: () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (ctx) => LoginScreen(),
                          ),
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
