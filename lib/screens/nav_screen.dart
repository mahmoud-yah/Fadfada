import 'package:flutter/material.dart';
import 'package:intro_app/app_localizations.dart';
import 'package:intro_app/screens/Notifications.dart';
// import 'package:intro_app/screens/home_screen.dart';
// import 'package:intro_app/screens/messenger_screen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'screens.dart';
// import 'profilev2.dart';
import 'profilev4.dart';

class NavScreen extends StatefulWidget {
  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  List<Widget> _screens = [
    HomeScreen(),
    // MessengerScreen(),
    // CreatePost(),
    // Scaffold(
    //   backgroundColor: Colors.black,
    //   body: Center(
    //     child: Text(
    //       'New Post',
    //       style: TextStyle(
    //         color: Colors.white,
    //         fontSize: 25.0,
    //         fontWeight: FontWeight.bold,
    //       ),
    //     ),
    //   ),
    // ),
    Notifications(),
    MessengerScreen(),
    // Profile(),
    ProfileV4(),
  ];
  final List<IconData> _icons = const [
    Icons.home,
    // Icons.mail_outline,
    MdiIcons.facebookMessenger,
    // Icons.add_circle_outline_rounded,
    MdiIcons.bellOutline,
    MdiIcons.accountCircleOutline,
    // Icons.menu,
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _icons.length,
      child: Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: _screens,
        ),
        // bottomNavigationBar: CustomTabBar(
        //   icons: _icons,
        //   selectedIndex: _selectedIndex,
        //   onTap: (index) => setState(() => _selectedIndex = index),
        // ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: AppLocalizations.of(context).translate("home"),
              backgroundColor: Colors.black,
            ),

            // BottomNavigationBarItem(
            //   icon: Icon(Icons.add_circle_outline_rounded),
            //   label: 'New post',
            //   backgroundColor: Colors.black,
            // ),
            BottomNavigationBarItem(
              icon: Icon(MdiIcons.bellOutline),
              label: AppLocalizations.of(context).translate("notifications"),
              backgroundColor: Colors.black,
            ),

            BottomNavigationBarItem(
              // icon: Icon(MdiIcons.facebookMessenger),
              icon: Icon(Icons.mail_outline),
              label: AppLocalizations.of(context).translate("messages"),
              backgroundColor: Colors.black,
            ),

            BottomNavigationBarItem(
              icon: Icon(MdiIcons.accountCircleOutline),
              label: AppLocalizations.of(context).translate("profile"),
              backgroundColor: Colors.black,
            ),
          ],
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
