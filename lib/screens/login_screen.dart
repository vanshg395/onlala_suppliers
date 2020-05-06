import 'package:flutter/material.dart';

import '../widgets/common_field.dart';
import '../widgets/common_button.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberLoginInfo = false;
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
              height: mediaQuery.height * 0.07,
            ),
            CommonButton(
              bgColor: Theme.of(context).primaryColor,
              borderColor: Theme.of(context).primaryColor,
              title: 'LOGIN',
              fontSize: 16,
              width: double.infinity,
              borderRadius: 5,
              onPressed: () {},
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
                onPressed: () {},
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
