import 'package:flutter/material.dart';
import 'package:rss_readneed/public.dart';
import 'package:rss_readneed/main_tabBar.dart';

import 'package:flutter_boost/flutter_boost.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => new MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ReadNeed',
      theme: ThemeData(

        scaffoldBackgroundColor: Colors.grey[100],//背景色

//        primarySwatch: mainColor,
//        primaryColorDark:mainColor,
      ),
      home: Container(),
      builder: FlutterBoost.init(),
      routes: {'imageShow': (BuildContext context) => AppNavigator.routePage("imageShow"),},
    );
  }
  @override
  void initState() {
    super.initState();

    //混合支持 - flutter_boost
    FlutterBoost.singleton.registerPageBuilders({

      'imageShow': (pageName, params, _) => AppNavigator.routePage("imageShow"),

    });

    FlutterBoost.handleOnStartPage();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(MyApp oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
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
