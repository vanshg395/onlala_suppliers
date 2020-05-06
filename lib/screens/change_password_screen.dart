import 'package:flutter/material.dart';

import '../widgets/common_field.dart';
import '../widgets/common_button.dart';

class ChangePasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        title: Text(
          'Change Password',
          style: Theme.of(context).primaryTextTheme.subtitle.copyWith(
                color: Colors.white,
                letterSpacing: 2,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Old Password',
              style: Theme.of(context).primaryTextTheme.headline,
            ),
            SizedBox(
              height: 5,
            ),
            CommonField(
              placeholder: 'Old Password',
              borderColor: Colors.white,
              bgColor: Colors.white,
              fontSize: 16,
              borderRadius: 5,
              isPassword: true,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'New Password',
              style: Theme.of(context).primaryTextTheme.headline,
            ),
            SizedBox(
              height: 5,
            ),
            CommonField(
              placeholder: 'New Password',
              borderColor: Colors.white,
              bgColor: Colors.white,
              fontSize: 16,
              borderRadius: 5,
              isPassword: true,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Confirm New Password',
              style: Theme.of(context).primaryTextTheme.headline,
            ),
            SizedBox(
              height: 5,
            ),
            CommonField(
              placeholder: 'Re-Enter New Password',
              borderColor: Colors.white,
              bgColor: Colors.white,
              fontSize: 16,
              borderRadius: 5,
              isPassword: true,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.07,
            ),
            CommonButton(
              bgColor: Theme.of(context).primaryColor,
              borderColor: Theme.of(context).primaryColor,
              title: 'SET NEW PASSWORD',
              fontSize: 16,
              width: double.infinity,
              borderRadius: 5,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
