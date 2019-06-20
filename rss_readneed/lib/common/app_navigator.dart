import 'package:flutter/material.dart';

import 'package:rss_readneed/some_image_show/page.dart' as image_show;
import 'package:rss_readneed/rss_add/page.dart' as rss_add;

/*跳转基础类/规划类*/
class AppNavigator {

  static AppNavigator _instance;
  static AppNavigator get instance {

    if (_instance == null) {

      _instance = AppNavigator()
                    ..configRoutesAction();
    }
    return _instance;
  }
  //路由集合
  Map _configRoutes;
  //配置路由
  void configRoutesAction () {

    _instance._configRoutes = {

      "imageShow":image_show.some_image_showPage().buildPage({}),
      "rssAdd":rss_add.rss_addPage().buildPage({}),
    };
  }

  static push (BuildContext context,Widget scene) {

    Navigator.push(context, MaterialPageRoute(builder: (_) => scene));
  }

  static pushRoute (BuildContext context,String route) {

    if (AppNavigator._instance._configRoutes.containsKey(route)) {

      Widget widget = _instance._configRoutes[route];

      Navigator.of(context).push(MaterialPageRoute(builder: (_) => widget));
    }
  }

}
