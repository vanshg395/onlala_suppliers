import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../widgets/common_button.dart';
import '../widgets/common_field.dart';
import '../utils/constants.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  bool _isLoading = false;
  GlobalKey<FormState> _formKey = GlobalKey();
  String _email;

  Future<void> _submit() async {
    _formKey.currentState.save();
    if (!_formKey.currentState.validate()) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    try {
      final url = baseUrl + 'user/password/reset/?email=$_email';
      final response = await http.get(url);
      print(response.statusCode);
      if (response.statusCode == 202) {
        await showDialog(
          context: context,
          child: AlertDialog(
            title: Text('Success'),
            content:
                Text('Password reset link has been sent to your email id.'),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
        Navigator.of(context).pop();
      } else if (response.statusCode == 403) {
        await showDialog(
          context: context,
          child: AlertDialog(
            title: Text('Error'),
            content: Text(
                'It seems that your account is blocked. Please contact our team.'),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
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
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        title: Text(
          'Reset Password',
          style: Theme.of(context).primaryTextTheme.subtitle.copyWith(
                color: Colors.white,
                letterSpacing: 2,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Email Address',
                style: Theme.of(context).primaryTextTheme.headline,
              ),
              SizedBox(
                height: 5,
              ),
              CommonField(
                placeholder: 'Your Email Address',
                borderColor: Colors.white,
                bgColor: Colors.white,
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
                  _email = value;
                  // _registerData['email'] = value;
                  // _loginData['username'] = value;
                  // _manufCreateData['company_email'] = value;
                },
              ),
              SizedBox(
                height: 30,
              ),
              _isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(
                          Theme.of(context).primaryColor,
                        ),
                      ),
                    )
                  : Center(
                      child: CommonButton(
                        bgColor: Theme.of(context).primaryColor,
                        borderColor: Theme.of(context).primaryColor,
                        title: 'RESET PASSWORD',
                        fontSize: 16,
                        width: 250,
                        borderRadius: 5,
                        onPressed: _submit,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
