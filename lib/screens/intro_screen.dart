import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './register_screen.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();

  static Future<bool> isFirstUse() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (!prefs.containsKey('isFirstLogin')) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}

class _IntroScreenState extends State<IntroScreen> {
  final List<PageViewModel> pages = [
    PageViewModel(
      title: "",
      body: "B2B MARKETING STRATEGIES TO ATTRACT MORE CUSTOMERS",
      image: Center(
        child: Image.asset(
          "assets/img/one.png",
          width: 300,
          fit: BoxFit.cover,
        ),
      ),
      decoration: const PageDecoration(
        pageColor: Colors.white,
        imageFlex: 2,
      ),
    ),
    PageViewModel(
      title: "",
      body: "FOREIGN EXPORT-ORIENTED COMPANIES",
      image: Center(
        child: Image.asset(
          "assets/img/two.png",
          width: 300,
          fit: BoxFit.cover,
        ),
      ),
      decoration: const PageDecoration(
        pageColor: Colors.white,
        imageFlex: 2,
      ),
    ),
    PageViewModel(
      title: "",
      body: "ATTRACTING NEW LEADS AS AN EXPERIENCED BUSINESSMAN WITH ONLALA",
      image: Center(
        child: Image.asset(
          "assets/img/three.png",
          width: 300,
          fit: BoxFit.cover,
        ),
      ),
      decoration: const PageDecoration(
        pageColor: Colors.white,
        imageFlex: 2,
      ),
    ),
    PageViewModel(
      title: "",
      body: "CONVEY INFORMATION TO YOUR AUDIENCE BY ONLALA, NO ADVERTISING",
      image: Center(
        child: Image.asset(
          "assets/img/four.png",
          width: 300,
          fit: BoxFit.cover,
        ),
      ),
      decoration: const PageDecoration(
        pageColor: Colors.white,
        imageFlex: 2,
        imagePadding: EdgeInsets.zero,
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: pages,
      onDone: () async {
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('isFirstLogin', 'false');
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (ctx) => RegisterScreen(),
          ),
        );
      },
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Text('Next', style: TextStyle(fontWeight: FontWeight.w600)),
    );
  }
}
