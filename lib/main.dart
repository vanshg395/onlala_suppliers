import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/terms_and_conditions_screen.dart';
import './screens/register_screen.dart';
import './screens/login_screen.dart';
import './screens/video_tutorial_screen.dart';
import './screens/tabsScreen.dart';
import './providers/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Auth(),
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          theme: ThemeData(
            primaryColor: Color(0xFF28566D),
            accentColor: Color(0xFF3D7895),
            primaryColorDark: Color(0xFF030708),
            cardColor: Color(0xFF3E4346),
            canvasColor: Color(0xFFF3F6F7),
            primaryTextTheme: TextTheme(
              title: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 26,
                color: Colors.black,
              ),
              subtitle: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: Colors.black,
              ),
              headline: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
              body2: TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Colors.black,
              ),
            ),
          ),
          home: RegisterScreen(),
        ),
      ),
    );
  }
}
