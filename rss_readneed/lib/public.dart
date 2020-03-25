library public;

import 'package:flutter/material.dart';


//Widget
export './common/appbar_common.dart';
export './common/appbar_gradient.dart';
export './common/sliverAppbar_gradient.dart';

export './common/LoadingSupport.dart';
export './common/toast_common.dart';

export './common/app_navigator.dart';

export './common/request_common.dart';

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