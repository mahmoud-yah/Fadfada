import 'package:flutter/material.dart';
import 'package:intro_app/app_localizations.dart';
import 'package:intro_app/themes/theme_setup.dart';
// import 'screens/';
import 'screens/screens.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:stacked_themes/stacked_themes.dart';


Future main() async {
  await ThemeManager.initialise();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      themes: getThemes(),
      builder: (context,regularTheme,darkTheme,themeMode)=> MaterialApp(
        debugShowCheckedModeBanner: false,
        // theme: ThemeData(
        //   // primaryColor: Color(0xFF312F54),
        //   // accentColor: Color(0xFF66697D),
        //   primaryColor: Colors.red,
        //   accentColor: Color(0xFFFEF9EB),
        // ),
        theme: regularTheme,
        darkTheme: darkTheme,
        themeMode: themeMode,
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
        home: Register(),
      ),
    );

  }
}
// 0xFF21254A
