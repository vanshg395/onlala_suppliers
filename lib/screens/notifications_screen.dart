import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool _emailNotif = false;
  bool _smsNotif = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        title: Text(
          'Notifications',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'SMS Notifications',
                  style: Theme.of(context).primaryTextTheme.headline,
                ),
                Switch.adaptive(
                    activeColor: Theme.of(context).primaryColor,
                    value: _smsNotif,
                    onChanged: (value) {
                      setState(() {
                        _smsNotif = value;
                      });
                    })
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Email Notifications',
                  style: Theme.of(context).primaryTextTheme.headline,
                ),
                Switch.adaptive(
                    activeColor: Theme.of(context).primaryColor,
                    value: _emailNotif,
                    onChanged: (value) {
                      setState(() {
                        _emailNotif = value;
                      });
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }
}
