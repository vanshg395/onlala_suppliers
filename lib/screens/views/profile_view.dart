import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../settings_screen.dart';
import '../help_screen.dart';
import '../profile_screen.dart';
import '../../widgets/profile_tile.dart';
import '../../providers/auth.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    await Provider.of<Auth>(context, listen: false).getManufData();
    setState(() {});
  }

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
                  Provider.of<Auth>(context, listen: false).userDetails[0]
                          ['user']['first_name'] +
                      ' ' +
                      Provider.of<Auth>(context, listen: false).userDetails[0]
                          ['user']['last_name'],
                  style: Theme.of(context)
                      .primaryTextTheme
                      .subtitle
                      .copyWith(fontSize: 26),
                ),
                Text(
                  Provider.of<Auth>(context, listen: false).userDetails[0]
                      ['postal_details'][0]['postal_country'],
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
                  icon: Icon(
                    Icons.person,
                    size: 36,
                    color: Theme.of(context).primaryColor,
                  ),
                  label: Text(
                    'Profile',
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () => Navigator.of(context)
                      .push(
                    MaterialPageRoute(
                      builder: (ctx) => ProfileScreen(),
                    ),
                  )
                      .then((value) {
                    setState(() {});
                  }),
                ),
                Divider(
                  indent: 90,
                  endIndent: 20,
                ),
                // ProfileTile(
                //   icon: Image.asset(
                //     'assets/img/payment.png',
                //     scale: 0.6,
                //   ),
                //   label: Text(
                //     'Payment',
                //     style: TextStyle(fontSize: 18),
                //   ),
                //   onTap: () {},
                // ),
                // Divider(
                //   indent: 90,
                //   endIndent: 20,
                // ),
                ProfileTile(
                  icon: Icon(
                    Icons.settings,
                    size: 36,
                    color: Colors.amber,
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
                  icon: Icon(
                    Icons.help,
                    size: 36,
                    color: Colors.green,
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
                    icon: Icon(
                      Icons.exit_to_app,
                      size: 36,
                      color: Theme.of(context).errorColor,
                    ),
                    label: Text(
                      'Logout',
                      style: TextStyle(fontSize: 18),
                    ),
                    onTap: () {
                      RestartWidget.restartApp(context);
                      Provider.of<Auth>(context, listen: false).logout();
                    }),
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
                  image:
                      Provider.of<Auth>(context, listen: false).userDetails[0]
                                  ['image_url'][0]['profile_image'] ==
                              null
                          ? null
                          : DecorationImage(
                              image: NetworkImage(
                                Provider.of<Auth>(context, listen: false)
                                        .userDetails[0]['image_url'][0]
                                    ['profile_image'],
                              ),
                              fit: BoxFit.cover,
                            ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
