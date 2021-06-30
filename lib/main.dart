import 'package:flutter/material.dart';
import 'package:intro_app/app_localizations.dart';
// import 'screens/';
import 'screens/screens.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // primaryColor: Color(0xFF312F54),
        // accentColor: Color(0xFF66697D),
        primaryColor: Colors.red,
        accentColor: Color(0xFFFEF9EB),
      ),
      supportedLocales: [
        Locale('en','US'),
        Locale('ar','SY'),
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales){
        for(var supportedLocale in supportedLocales){
          if(supportedLocale.languageCode == locale.languageCode && supportedLocale.countryCode == locale.countryCode){
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      home: NavScreen(),
    );
  }
}
// 0xFF21254A
