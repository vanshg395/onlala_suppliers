import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:onlala_suppliers/utils/constants.dart';
import 'package:onlala_suppliers/widgets/dropdown.dart';
import 'package:provider/provider.dart';
import 'package:get_ip/get_ip.dart';
import 'package:http/http.dart' as http;

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
  GlobalKey<FormState> _formKey1 = GlobalKey();
  GlobalKey<FormState> _formKey = GlobalKey();
  int _currentPart = 1;
  bool _isLoading = false;
  bool _isVisible1 = false;
  bool _isVisible2 = false;
  List<FocusNode> _focus = [for (int i = 0; i < 14; i++) FocusNode()];
  String _countryCode = 'US';
  String _deptChoice;
  List<dynamic> _depts = [];
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

  @override
  void initState() {
    super.initState();
    getIp();
    getDepartments();
  }

  Future<void> getDepartments() async {
    try {
      final url = baseUrl + 'department/show/';
      final response = await http.get(url);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        final resBody = json.decode(response.body);
        setState(() {
          _depts = resBody['departments'];
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getIp() async {
    try {
      final response = await http.get(
          'http://api.ipapi.com/api/check?access_key=95235ad01973864b1878b2ff1c4e9bc6');
      print(response.statusCode);
      if (response.statusCode == 200) {
        final resBody = json.decode(response.body);
        setState(() {
          _countryCode = resBody['country_code'];
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
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
      await Provider.of<Auth>(context, listen: false)
          .login(_loginData, false, true);
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

  void _submitPart1() {
    FocusScope.of(context).unfocus();
    _formKey1.currentState.save();
    if (!_formKey1.currentState.validate()) {
      return;
    }
    setState(() {
      _currentPart++;
    });
  }

  Widget buildPart1() {
    return Form(
      key: _formKey1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
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
            focusNode: _focus[0],
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_focus[1]);
            },
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
            focusNode: _focus[1],
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_focus[2]);
            },
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
            focusNode: _focus[2],
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_focus[3]);
            },
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
            isPassword: !_isVisible1,
            suffixIcon: InkWell(
              child: SvgPicture.asset(
                _isVisible1
                    ? 'assets/icons/visible.svg'
                    : 'assets/icons/obscure.svg',
                height: 20,
                color: Theme.of(context).primaryColor,
              ),
              onTap: () {
                setState(() {
                  _isVisible1 = !_isVisible1;
                });
              },
            ),
            focusNode: _focus[3],
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_focus[4]);
            },
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
            isPassword: !_isVisible2,
            suffixIcon: InkWell(
              child: SvgPicture.asset(
                _isVisible2
                    ? 'assets/icons/visible.svg'
                    : 'assets/icons/obscure.svg',
                height: 20,
                color: Theme.of(context).primaryColor,
              ),
              onTap: () {
                setState(() {
                  _isVisible2 = !_isVisible2;
                });
              },
            ),
            focusNode: _focus[4],
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_focus[5]);
            },
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
            initialCountryCode: _countryCode,
            borderColor: Theme.of(context).canvasColor,
            bgColor: Theme.of(context).canvasColor,
            keyboardType: TextInputType.number,
            focusNode: _focus[5],
            onSubmitted: (_) {
              FocusScope.of(context).unfocus();
            },
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
            height: MediaQuery.of(context).size.height * 0.07,
          ),
          CommonButton(
            bgColor: Theme.of(context).primaryColor,
            borderColor: Theme.of(context).primaryColor,
            title: 'NEXT',
            fontSize: 16,
            width: double.infinity,
            borderRadius: 5,
            onPressed: _submitPart1,
          )
        ],
      ),
    );
  }

  Widget buildPart2() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Business Department',
            style: Theme.of(context).primaryTextTheme.headline,
          ),
          SizedBox(
            height: 5,
          ),
          MultilineDropdownButtonFormField(
            isExpanded: true,
            items: _depts.length == 0
                ? []
                : _depts
                    .map(
                      (dept) => DropdownMenuItem(
                        child: Text(
                          dept['department']['name'],
                          style: TextStyle(
                            color: Theme.of(context).cardColor,
                            fontFamily: Theme.of(context)
                                .primaryTextTheme
                                .display1
                                .fontFamily,
                            fontSize: 16,
                          ),
                        ),
                        value: dept['department']['name'],
                      ),
                    )
                    .toList(),
            value: _deptChoice,
            iconSize: 30,
            icon: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Icon(Icons.keyboard_arrow_down),
            ),
            iconEnabledColor: Theme.of(context).cardColor,
            iconDisabledColor: Theme.of(context).cardColor,
            onChanged: (val) {
              setState(() {
                _deptChoice = val;
              });
            },
            validator: (value) {
              if (_manufCreateData['department'] == null) {
                return 'This field is required.';
              }
            },

            onSaved: (value) {
              _manufCreateData['department'] = value;
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
              hintText: 'Choose Department',
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
            focusNode: _focus[7],
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_focus[8]);
            },
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
            focusNode: _focus[8],
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_focus[9]);
            },
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
            focusNode: _focus[9],
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_focus[10]);
            },
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
            focusNode: _focus[10],
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_focus[11]);
            },
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
            focusNode: _focus[11],
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_focus[12]);
            },
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
            focusNode: _focus[12],
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_focus[13]);
            },
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
            focusNode: _focus[13],
            onFieldSubmitted: (_) {
              FocusScope.of(context).unfocus();
            },
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
            height: MediaQuery.of(context).size.height * 0.07,
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
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: SingleChildScrollView(
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
                if (_currentPart == 1) buildPart1(),
                if (_currentPart == 2) buildPart2(),
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
    );
  }
}
