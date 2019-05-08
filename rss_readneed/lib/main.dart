import 'package:flutter/material.dart';
import 'package:rss_readneed/main_tabBar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ReadNeed',
      theme: ThemeData(

        scaffoldBackgroundColor: Colors.grey[100],//背景色

//        primarySwatch: mainColor,
//        primaryColorDark:mainColor,
      ),
      home: MainTabBar(),
      routes: {},
    );
  }
}

//自定义 MaterialColor
const int _mainColorPrimaryValue = 0xFFED9C3C;

const MaterialColor mainColor = MaterialColor(
  _mainColorPrimaryValue,
  <int, Color>{
    50: Color(0xFFED9C3C),
    100: Color(0xFFED9C3C),
    200: Color(0xFFED9C3C),
    300: Color(0xFFED9C3C),
    400: Color(0xFFED9C3C),
    500: Color(_mainColorPrimaryValue),
    600: Color(0xFFED9C3C),
    700: Color(0xFFED9C3C),
    800: Color(0xFFED9C3C),
    900: Color(0xFFED9C3C),
  },
);
