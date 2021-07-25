import 'package:flutter/material.dart';
import 'package:intro_app/app_localizations.dart';

class Privacy extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Theme.of(context).backgroundColor,
        brightness: Theme.of(context).brightness,
        title: Text(
          AppLocalizations.of(context).translate("privacy"),
          style: TextStyle(
            color: Theme.of(context).accentColor,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
      ),
    );
  }
}
