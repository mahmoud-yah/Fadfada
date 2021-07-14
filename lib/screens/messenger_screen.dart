import 'package:flutter/material.dart';
import 'package:intro_app/app_localizations.dart';
// import 'package:intro_app/widgets/favorite_contacts.dart';
import 'package:intro_app/widgets/recent_chats.dart';

class MessengerScreen extends StatefulWidget {
  @override
  _MessengerScreenState createState() => _MessengerScreenState();
}

class _MessengerScreenState extends State<MessengerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme
      //     .of(context)
      //     .primaryColor,
      // backgroundColor: Colors.black,
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        // brightness: Brightness.light,
        brightness: Theme.of(context).brightness,
        // backgroundColor: Colors.black,
        backgroundColor: Theme.of(context).backgroundColor,
        // centerTitle: true,
        // leading: IconButton(
        //   icon: Icon(Icons.menu),
        //   iconSize: 30.0,
        //   color: Colors.white,
        //   onPressed: () {},
        // ),
        leadingWidth: 0,
        leading: Container(),
        centerTitle: true,
        title: Text(
          // 'Chats',
          AppLocalizations.of(context).translate("chats"),
          // textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).accentColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(Icons.search),
        //     iconSize: 30.0,
        //     color: Colors.white,
        //     onPressed: () {},
        //   ),
        // ],
      ),
      // drawer: Drawer(
      //   // elevation: 10.0,
      //   child: Container(
      //     color: Colors.black,
      //   ),
      // ),
      body: Column(
        children: <Widget>[
          // CategorySelector(),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                // color: Theme
                //     .of(context)
                //     .accentColor,
                color: Colors.black54,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
              ),
              child: Column(
                children: <Widget>[
                  // FavoriteContacts(),
                  RecentChats(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
