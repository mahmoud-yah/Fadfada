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
      backgroundColor: Colors.black,
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Colors.black,
        // centerTitle: true,
        // leading: IconButton(
        //   icon: Icon(Icons.menu),
        //   iconSize: 30.0,
        //   color: Colors.white,
        //   onPressed: () {},
        // ),
        title: Text(
          // 'Chats',
          AppLocalizations.of(context).translate("chats"),
          // textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        // elevation: 10.0,
        child: Container(
          color: Colors.black,
        ),
      ),
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
