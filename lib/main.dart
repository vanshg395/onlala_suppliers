import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/terms_and_conditions_screen.dart';
import './screens/register_screen.dart';
import './screens/login_screen.dart';
import './screens/video_tutorial_screen.dart';
import './screens/tabsScreen.dart';
import './screens/intro_screen.dart';
import './providers/auth.dart';

void main() {
  runApp(
    RestartWidget(
      child: MyApp(),
    ),
  );
}

class RestartWidget extends StatefulWidget {
  RestartWidget({this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>().restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Auth(),
      child: Consumer<Auth>(
        builder: (ctx, auth, _) {
          print('rebuilt');
          return MaterialApp(
            theme: ThemeData(
              primaryColor: Color(0xFF255AE7),
              accentColor: Color(0xFF255AE7),
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
            home: auth.isAuth
                ? TabsScreen()
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (ctx, data) {
                      if (data.connectionState == ConnectionState.waiting) {
                        return Scaffold();
                      } else {
                        return FutureBuilder(
                          future: IntroScreen.isFirstUse(),
                          builder: (ctx, data) {
                            if (data.connectionState ==
                                ConnectionState.waiting) {
                              print('rebuilt2');
                              return Scaffold();
                            } else {
                              print('rebuilt3');
                              if (data.data) {
                                return IntroScreen();
                              } else {
                                return LoginScreen();
                              }
                            }
                          },
                        );
                      }
                    },
                  ),
          );
        },
      ),
    );
  }
}
