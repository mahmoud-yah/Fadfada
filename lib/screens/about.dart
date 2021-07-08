import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Theme.of(context).backgroundColor,
        brightness: Theme.of(context).brightness,
        title: Text(
          'About',
          style: TextStyle(
            color: Theme.of(context).accentColor,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(
            top: 15.0,
            left: 8.0,
            right: 8.0
          ),
          child: Column(
            children: [
              Text(
                "Fadfada is a project developed by syrian students: \n\nAlan Hussein\nAbd Bayouni\nMahmoud Yahya\nWael Al-Haddad\n \nSubmitted to the Arab International University (AIU), faculty of informatics engineering as a graduation project."
                " \n\nAims to connect similar people together, as well as help people express their feelings without being criticized. ",
                style: TextStyle(fontSize: 20, height: 1.4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
