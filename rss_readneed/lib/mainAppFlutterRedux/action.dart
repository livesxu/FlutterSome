import 'package:flutter/material.dart';

class AppAction {

  static ThemeData topicAction(MaterialColor color){

    return ThemeData(

      scaffoldBackgroundColor: Colors.grey[100],//背景色

      primaryColor: color,
      primaryColorLight: color[50],
      primaryColorDark:color[900],
    );
  }


}

