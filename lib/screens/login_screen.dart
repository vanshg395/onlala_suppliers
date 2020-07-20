import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/common_field.dart';
import '../widgets/common_button.dart';
import './register_screen.dart';
import './tabsScreen.dart';
import './tncview_screen.dart';
import './reset_password_screen.dart';
import '../providers/auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberLoginInfo = false;
  bool _isLoading = false;
  bool _isVisible = false;
  List<FocusNode> _focus = [for (int i = 0; i < 2; i++) FocusNode()];
  GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, dynamic> _loginData = {
    'username': '',
    'password': '',
  };

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    _formKey.currentState.save();
    if (!_formKey.currentState.validate()) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<Auth>(context, listen: false)
          .login(_loginData, _rememberLoginInfo, false);
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => TabsScreen(),
        ),
      );
    } catch (e) {
      print(e);
      if (e.toString() == 'Complete Profile') {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (ctx) => TabsScreen(
              initialIndex: 3,
            ),
          ),
        );
        showDialog(
          context: context,
          child: AlertDialog(
            title: Text('Attention'),
            content:
                Text('You are requested to upload the required documents.'),
          ),
        );
      } else if (e.toString() == 'Invalid Cred') {
        await showDialog(
          context: context,
          child: AlertDialog(
            title: Text('Error'),
            content: Text('Account with following credentials doesn\'t exist'),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      } else if (e.toString() == 'Not a manufacturer') {
        await showDialog(
          context: context,
          child: AlertDialog(
            title: Text('Error'),
            content: Text('This registered user is not a manufacturer.'),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      } else if (e.toString() == 'User Blocked') {
        await showDialog(
          context: context,
          child: AlertDialog(
            title: Text('Error'),
            content: Text(
                'Access for this user has been block due to some reason. Please contact our team to use your account.'),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      } else {
        await showDialog(
          context: context,
          child: AlertDialog(
            title: Text('Error'),
            content: Text('Something went wrong. Please try again later.'),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      }
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
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 30,
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
                    'Sign In',
                    style: Theme.of(context).primaryTextTheme.title,
                  ),
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
                  isPassword: !_isVisible,
                  suffixIcon: InkWell(
                    child: SvgPicture.asset(
                      _isVisible
                          ? 'assets/icons/visible.svg'
                          : 'assets/icons/obscure.svg',
                      height: 20,
                      color: Theme.of(context).primaryColor,
                    ),
                    onTap: () {
                      setState(() {
                        _isVisible = !_isVisible;
                      });
                    },
                  ),
                  focusNode: _focus[1],
                  validator: (value) {
                    if (value == '') {
                      return 'This field is required.';
                    }
                  },
                  onSaved: (value) {
                    _loginData['password'] = value;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    Checkbox(
                      value: _rememberLoginInfo,
                      onChanged: (value) {
                        setState(() {
                          _rememberLoginInfo = value;
                        });
                      },
                    ),
                    Text(
                      'Remember Login Info',
                      style: Theme.of(context).primaryTextTheme.body2,
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'By continuing, you agree to Onlala\'s',
                        style: Theme.of(context).primaryTextTheme.body2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          InkWell(
                            child: Text(
                              'Terms and Conditions',
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .body2
                                  .copyWith(
                                      color: Theme.of(context).primaryColor),
                            ),
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => TnCViewScreen(),
                              ),
                            ),
                          ),
                          Text(
                            ' of Use',
                            style: Theme.of(context).primaryTextTheme.body2,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: mediaQuery.height * 0.06,
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
                        title: 'LOGIN',
                        fontSize: 16,
                        width: double.infinity,
                        borderRadius: 5,
                        onPressed: _submit,
                      ),
                SizedBox(
                  height: mediaQuery.height * 0.07,
                ),
                Center(
                  child: FlatButton(
                    child: Text(
                      'Reset Password',
                      style: Theme.of(context).primaryTextTheme.body2,
                    ),
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => ResetPasswordScreen(),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'I don\'t have an account. ',
                      style: Theme.of(context).primaryTextTheme.body2,
                    ),
                    InkWell(
                      child: Text(
                        'Sign Up Now',
                        style: Theme.of(context)
                            .primaryTextTheme
                            .body2
                            .copyWith(color: Theme.of(context).accentColor),
                      ),
                      onTap: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (ctx) => RegisterScreen(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
