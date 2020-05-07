import 'package:flutter/material.dart';

import '../widgets/nav_bar.dart';
import './views/home_view.dart';
import './views/product_view.dart';
import './views/message_view.dart';
import './views/profile_view.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  List<Widget> _pages = [
    HomeView(),
    ProductView(),
    MessageView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[_selectedPageIndex],
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          size: 34,
        ),
        onPressed: () {},
        elevation: 0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: NavBar(
        onTap: (i) {
          setState(() {
            _selectedPageIndex = i;
          });
        },
      ),
    );
  }
}
