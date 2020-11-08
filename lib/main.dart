import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movies_intent/screens/aboutScreen.dart';
import 'package:movies_intent/screens/detailScreen.dart';
import 'package:movies_intent/screens/helpScreen.dart';
import 'package:movies_intent/screens/homeScreen.dart';
import 'package:movies_intent/screens/imageScreen.dart';
import 'package:movies_intent/screens/searchScreen.dart';
import 'package:flutter/material.dart';

Future main() async {
  await DotEnv().load('.env');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    return AdaptiveTheme(
      light: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.amber,
        accentColor: Colors.amber,
        // fontFamily: 'Nunito-Light'
      ),
      dark: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.amber,
        accentColor: Colors.amber,
        // fontFamily: 'Nunito-Light'
      ),
      initial: AdaptiveThemeMode.dark,
      builder: (theme, darkTheme) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movies Intent',
        initialRoute: '/',
        theme: theme,
        routes: {
          '/': (context) => HomeScreen(),
          '/Search': (context) => SearchScreen(),
          '/Details': (context) => DetailScreen(),
          '/About': (context) => AboutScreen(),
          '/Help': (context) => HelpScreen(),
          '/Image': (context) => ImageScreen(),
        },
      ),
    );
  }
}
