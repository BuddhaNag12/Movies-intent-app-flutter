import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movies_intent/screens/aboutScreen.dart';
import 'package:movies_intent/screens/detailScreen.dart';
import 'package:movies_intent/screens/helpScreen.dart';
import 'package:movies_intent/screens/homeScreen.dart';
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

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.amber,
        // scaffoldBackgroundColor: Colors.white,
        // brightness: Brightness.dark,
        accentColor: Color.fromRGBO(247, 236, 110, 100),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      title: 'Movies Intent',
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/Search': (context) => SearchScreen(),
        '/Details': (context) => DetailScreen(),
        '/About': (context) => AboutScreen(),
        '/Help': (context) => HelpScreen(),
      },
    );
  }
}
