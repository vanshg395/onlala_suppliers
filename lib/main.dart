import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

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
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xFF255AE7),
          accentColor: Color(0xFF255AE7),
          primaryColorDark: Color(0xFF030708),
          cardColor: Color(0xFF3E4346),
          canvasColor: Color(0xFFF3F6F7),
          primaryTextTheme: TextTheme(
            title: GoogleFonts.montserrat(
              textStyle: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 26,
                color: Colors.black,
              ),
            ),
            subtitle: GoogleFonts.montserrat(
              textStyle: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            headline: GoogleFonts.montserrat(
              textStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            // headline1: GoogleFonts.montserrat(
            //   textStyle: TextStyle(
            //     fontSize: 18,
            //     fontWeight: FontWeight.w300,
            //     color: Colors.black,
            //   ),
            // ),
            body1: GoogleFonts.montserrat(
              textStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w300,
                color: Colors.black,
              ),
            ),

            body2: GoogleFonts.montserrat(
              textStyle: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
        ),
        home: SplashScreen(),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 2),
      () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (ctx) => MainScreen(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          child: Image.asset('assets/img/logo.png'),
        ),
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
      builder: (ctx, auth, _) {
        print('rebuilt');
        return auth.isAuth
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
                        if (data.connectionState == ConnectionState.waiting) {
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
              );
      },
    );
  }
}
