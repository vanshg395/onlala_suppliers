import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../settings_screen.dart';
import '../help_screen.dart';
import '../../widgets/home_card.dart';
import '../../widgets/profile_tile.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Theme.of(context).canvasColor,
      child: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: double.infinity,
                  color: Colors.teal,
                  child: Image.asset(
                    'assets/img/homedevice.png',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 90,
                ),
                Text(
                  'Profile Name',
                  style: Theme.of(context)
                      .primaryTextTheme
                      .subtitle
                      .copyWith(fontSize: 26),
                ),
                Text(
                  'INDIA',
                  style: Theme.of(context)
                      .primaryTextTheme
                      .body2
                      .copyWith(fontWeight: FontWeight.w300),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  indent: 20,
                  endIndent: 20,
                ),
                SizedBox(
                  height: 10,
                ),
                ProfileTile(
                  icon: Image.asset(
                    'assets/img/profile.png',
                    scale: 0.6,
                  ),
                  label: Text(
                    'Profile',
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () {},
                ),
                Divider(
                  indent: 90,
                  endIndent: 20,
                ),
                ProfileTile(
                  icon: Image.asset(
                    'assets/img/payment.png',
                    scale: 0.6,
                  ),
                  label: Text(
                    'Payment',
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () {},
                ),
                Divider(
                  indent: 90,
                  endIndent: 20,
                ),
                ProfileTile(
                  icon: Image.asset(
                    'assets/img/settings.png',
                    scale: 0.6,
                  ),
                  label: Text(
                    'Settings',
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => SettingsScreen(),
                    ),
                  ),
                ),
                Divider(
                  indent: 90,
                  endIndent: 20,
                ),
                ProfileTile(
                  icon: Image.asset(
                    'assets/img/help.png',
                    scale: 0.6,
                  ),
                  label: Text(
                    'Help',
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => HelpScreen(),
                    ),
                  ),
                ),
                Divider(
                  indent: 90,
                  endIndent: 20,
                ),
                ProfileTile(
                  icon: Image.asset(
                    'assets/img/logout.png',
                    scale: 0.6,
                  ),
                  label: Text(
                    'Logout',
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () {},
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
            Positioned(
              left: MediaQuery.of(context).size.width / 2 - 75,
              top: MediaQuery.of(context).size.height * 0.25 - 75,
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFE1F0F7),
                  border: Border.all(color: Colors.white, width: 5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
