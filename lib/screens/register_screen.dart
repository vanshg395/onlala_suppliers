import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../widgets/common_field.dart';
import '../widgets/common_button.dart';

class RegisterScreen extends StatelessWidget {
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
              InternationalPhoneNumberInput.withCustomDecoration(
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
                  alignLabelWithHint: true,
                  hintText: 'Phone Number',
                  hintStyle: TextStyle(
                    color: Theme.of(context).cardColor,
                  ),
                ),
                selectorType: PhoneInputSelectorType.DIALOG,
                onInputChanged: (phone) {
                  print(phone.phoneNumber);
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
                isPassword: true,
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
                isPassword: true,
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
                onPressed: () {},
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
            ],
          ),
        ),
      ),
    );
  }
}
