import 'package:flutter/material.dart';

import '../widgets/settings_tile.dart';
import './change_password_screen.dart';
import './notifications_screen.dart';
import './address_screen.dart';
import './tncview_screen.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        title: Text(
          'Settings',
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
          children: <Widget>[
            SettingsTile(
              icon: Image.asset('assets/img/pencil.png'),
              label: Text('Change Password'),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => ChangePasswordScreen(),
                ),
              ),
              trailing: Icon(
                Icons.chevron_right,
              ),
            ),
            Divider(
              indent: 50,
            ),
            SettingsTile(
              icon: Image.asset('assets/img/bell.png'),
              label: Text('Notifications'),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => NotificationsScreen(),
                ),
              ),
              trailing: Icon(
                Icons.chevron_right,
              ),
            ),
            Divider(
              indent: 50,
            ),
            SettingsTile(
              icon: Image.asset('assets/img/hut.png'),
              label: Text('Address'),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => AddressScreen(),
                ),
              ),
              trailing: Icon(
                Icons.chevron_right,
              ),
            ),
            Divider(
              indent: 50,
            ),
            SettingsTile(
              icon: Image.asset('assets/img/doc.png'),
              label: Text('Terms and Conditions'),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => TnCViewScreen(),
                ),
              ),
              trailing: Icon(
                Icons.chevron_right,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
