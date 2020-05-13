import 'package:flutter/material.dart';
import 'package:onlala_suppliers/screens/views/message_view2.dart';

import './views/faq_view.dart';
import './views/video_view.dart';
import './views/message_view.dart';

class HelpScreen extends StatefulWidget {
  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).accentColor,
          title: Text(
            'Help',
            style: Theme.of(context).primaryTextTheme.subtitle.copyWith(
                  color: Colors.white,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w500,
                ),
          ),
          centerTitle: true,
          bottom: TabBar(
            labelColor: Color(0xFF95BFD6),
            labelStyle: TextStyle(fontSize: 14),
            indicatorWeight: 3,
            indicatorColor: Color(0xFF95BFD6),
            labelPadding: EdgeInsets.zero,
            unselectedLabelColor: Colors.white,
            tabs: <Widget>[
              Tab(
                text: 'FAQ',
              ),
              Tab(
                text: 'Videos',
              ),
              Tab(
                text: 'Message',
              ),
            ],
          ),
        ),
        body: TabBarView(children: [
          FAQView(),
          VideoView(),
          MessageView2(),
        ]),
      ),
    );
  }
}
