import 'package:flutter/material.dart';

import 'package:flutter_boost/flutter_boost.dart';

import '../rss_recommend/rss_recommend.dart' as rss_recommend;
import 'package:rss_readneed/some_image_show/page.dart' as image_show;
import 'package:rss_readneed/rss_add/page.dart' as rss_add;
import '../Login/page.dart' as login;
import '../Login/Register/page.dart' as register;
import '../Home/page.dart' as home;


/*跳转基础类/规划类*/
class AppNavigator {

  static AppNavigator _instance;
  static AppNavigator get instance {

    if (_instance == null) {

      _instance = AppNavigator();
    }
    return _instance;
  }
  //路由集合
  Map _configRoutes = {

    'home':home.homePage().buildPage({}),
    'rssRecommend':rss_recommend.Recommend(),
    "imageShow":image_show.some_image_showPage().buildPage({}),
    "rssAdd":rss_add.rss_addPage().buildPage({}),
    "login":login.LoginPage().buildPage({}),
    "register":register.registerPage().buildPage({}),
  };


  static flutterMixRouterConfig () {

    //混合支持 - flutter_boost
    FlutterBoost.singleton.registerPageBuilders({

      'imageShow': (pageName, params, _) => AppNavigator.routePage("imageShow"),
    });
    //todo:?
//    FlutterBoost.handleOnStartPage();
  }

  //获取route对应的页面
  static Widget routePage (String route) {

    return AppNavigator.instance._configRoutes[route];
  }

  static push (BuildContext context,Widget scene) {

    Navigator.push(context, MaterialPageRoute(builder: (_) => scene));
  }

  static pushRoute (BuildContext context,String route) {

    if (AppNavigator.instance._configRoutes.containsKey(route)) {

      Widget widget = _instance._configRoutes[route];

      Navigator.of(context).push(MaterialPageRoute(builder: (_) => widget));
    }
  }

  static pop (BuildContext context) {
    Navigator.pop(context);
  }

//  static popTo (BuildContext context) {
//
//  Navigator.popUntil(context, predicate)
//}

}
