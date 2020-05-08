import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../widgets/common_field.dart';
import '../widgets/common_button.dart';
import '../providers/auth.dart';
import '../utils/constants.dart';
import '../utils/http_exception.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> _data = {};
  bool _isLoading = false;

  Future<void> _submit() async {
    _formKey.currentState.save();
    if (!_formKey.currentState.validate()) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    try {
      final url = baseUrl + 'user/profile/change/manufacturer/';
      final multipartRequest =
          new http.MultipartRequest('POST', Uri.parse(url));
      multipartRequest.headers.addAll(
        {
          'Authorization': Provider.of<Auth>(context, listen: false).token,
        },
      );
      print('<<<<<<<<<object>>>>>>>>>');
      multipartRequest.fields.addAll(_data);
      print('<<<<<<<<<object>>>>>>>>>>>>>>.');
      final response = await multipartRequest.send();
      print('<<<<<<<<<object>>>>>>>>>>>>>>.');
      print(response.statusCode);
      if (response.statusCode == 202) {
        setState(() {
          _isLoading = false;
        });
        await showDialog(
          context: context,
          child: AlertDialog(
            title: Text('Success'),
            content: Text('New Password has been set successfully.'),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
        Navigator.of(context).pop();
      } else {
        throw HttpException('Error');
      }
    } catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
      });
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
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
                validator: (value) {
                  if (value == '') {
                    return 'This field is required.';
                  }
                },
                onSaved: (value) {
                  _data['new_password'] = value;
                },
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
                validator: (value) {
                  if (value == '') {
                    return 'This field is required.';
                  }
                  if (value != _data['new_password']) {
                    return 'Passwords do not match.';
                  }
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
                      title: 'SET NEW PASSWORD',
                      fontSize: 16,
                      width: double.infinity,
                      borderRadius: 5,
                      onPressed: _submit,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
