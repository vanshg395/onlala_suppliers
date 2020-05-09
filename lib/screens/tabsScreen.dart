import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../utils/constants.dart';
import '../widgets/nav_bar.dart';
import './views/home_view.dart';
import './views/product_view.dart';
import './views/message_view.dart';
import './views/profile_view.dart';
import './department_select_screen.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  bool _isLoading = false;
  List<dynamic> _data = [];
  List<Widget> _pages = [
    HomeView(),
    ProductView(),
    MessageView(),
    ProfileView(),
  ];

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final url = baseUrl + 'subcategories/manuf/app/';
      final response = await http.get(url);
      print(response.statusCode);
      if (response.statusCode == 200) {
        final resBody = json.decode(response.body);
        setState(() {
          _data = resBody;
        });
        print(_data);
      }
    } catch (e) {
      print(e);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(
                  Theme.of(context).primaryColor,
                ),
              ),
            )
          : _pages[_selectedPageIndex],
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          size: 34,
        ),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            // builder: (ctx) => ProductUploadScreen(),
            builder: (ctx) => DepartmentSelectScreen(_data),
          ),
        ),
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
