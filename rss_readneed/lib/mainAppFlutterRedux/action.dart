import 'package:flutter/material.dart';
import '../public.dart';

class AppAction {

  static ThemeData topicAction(MaterialColor color){

    ThemeManager.analysisInfo(color);

    ThemeManager.themeData = ThemeManager.themeFrom(color);

    return ThemeManager.themeData;
  }

  static AccountModel accountAction() {

    return Account.share;
  }
}

