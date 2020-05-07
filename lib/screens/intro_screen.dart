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
      title: "Cross Country Platform",
      body: "Increase sales prompt business and engage with customers",
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
      title: "Limited Supplier",
      body: "Increase sales prompt business and engage with customers",
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
      title: "Nationwide Warehouse Facility",
      body: "Increase sales prompt business and engage with customers",
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
      title: "Promote Business Offline",
      body: "Increase sales prompt business and engage with customers",
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
