import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './consts.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '../mainAppFlutterRedux/state.dart';
import '../mainAppFlutterRedux/reducer.dart';
import '../mainAppFlutterRedux/action.dart';

//主题颜色集，只可追加不可改变顺序
const List<MaterialColor> themeColors = [mainColor,Colors.blue,Colors.deepOrange,Colors.red,Colors.deepPurple,Colors.blueGrey];

//自定义 MaterialColor
const int _mainColorPrimaryValue = 0xFFED9C3C;

const MaterialColor mainColor = MaterialColor(
  _mainColorPrimaryValue,
  <int, Color>{
    50: Color(0xFFFFD700),
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

class ThemeManager {

  static ThemeData themeData = themeFrom(themeColors[0]);

  int themeIndex = 0;

  static ThemeManager _share;
  static ThemeManager get share {

    if (_share == null)  {

      _share = ThemeManager()
                  ..themeIndex = 0;

    }
    return _share;
  }

  //读取数据
  static Future<SharedPreferences> initTheme () async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    int themeInfo = prefs.get('theme');

    if (themeInfo != null) { //如果不存在就返回空

      ThemeManager.share.themeIndex = themeInfo;
      themeData = themeFrom(themeColors[themeInfo]);
    }

    return prefs;
  }

//  //读取数据
//  static readInfo () async {
//
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//
//    int themeInfo = prefs.get('theme');
//
//    if (themeInfo != null) { //如果不存在就返回空
//
//      ThemeManager.share.themeIndex = themeInfo;
//      themeData = themeFrom(themeColors[themeInfo]);
//
//    }
//  }

  //储存数据
  static writeInfo() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt('theme', ThemeManager.share.themeIndex);

  }

  //同步存储数据
  static analysisInfo(MaterialColor color){

    int themeIndex = themeColors.indexOf(color);

    ThemeManager.share.themeIndex = themeIndex;
    themeData = themeFrom(themeColors[themeIndex]);
    writeInfo();
  }

  static ThemeData themeFrom(MaterialColor color){

    return ThemeData(

      scaffoldBackgroundColor: Colors.grey[100],//背景色

      primaryColor: color,
      primaryColorLight: color[50],
      primaryColorDark:color[900],
    );
  }
}