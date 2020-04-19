import 'package:flutter/material.dart';

import 'package:flutter_boost/flutter_boost.dart';

import '../rss_recommend/rss_recommend.dart' as rss_recommend;
import 'package:rss_readneed/some_image_show/page.dart' as image_show;
import 'package:rss_readneed/rss_add/page.dart' as rss_add;
import '../Login/page.dart' as login;
import '../Login/Register/page.dart' as register;
import '../Home/page.dart' as home;
import '../rss_collect/page.dart' as collect;


/*跳转基础类/规划类*/
class AppNavigator {

  String locationPageShortString = "/";

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
    'collect':collect.collectPage().buildPage({}),
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

class NaviManagerObserver extends NavigatorObserver{
  @override

  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {

    AppNavigator.instance.locationPageShortString = route.settings.name;
  }

  /// The [Navigator] popped `route`.
  ///
  /// The route immediately below that one, and thus the newly active
  /// route, is `previousRoute`.
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {

    AppNavigator.instance.locationPageShortString = previousRoute.settings.name;
  }

  /// The [Navigator] removed `route`.
  ///
  /// If only one route is being removed, then the route immediately below
  /// that one, if any, is `previousRoute`.
  ///
  /// If multiple routes are being removed, then the route below the
  /// bottommost route being removed, if any, is `previousRoute`, and this
  /// method will be called once for each removed route, from the topmost route
  /// to the bottommost route.
  void didRemove(Route<dynamic> route, Route<dynamic> previousRoute) {

  }

  /// The [Navigator] replaced `oldRoute` with `newRoute`.
  void didReplace({ Route<dynamic> newRoute, Route<dynamic> oldRoute }) {

  }

  /// The [Navigator]'s route `route` is being moved by a user gesture.
  ///
  /// For example, this is called when an iOS back gesture starts.
  ///
  /// Paired with a call to [didStopUserGesture] when the route is no longer
  /// being manipulated via user gesture.
  ///
  /// If present, the route immediately below `route` is `previousRoute`.
  /// Though the gesture may not necessarily conclude at `previousRoute` if
  /// the gesture is canceled. In that case, [didStopUserGesture] is still
  /// called but a follow-up [didPop] is not.
  void didStartUserGesture(Route<dynamic> route, Route<dynamic> previousRoute) {

  }

  /// User gesture is no longer controlling the [Navigator].
  ///
  /// Paired with an earlier call to [didStartUserGesture].
  void didStopUserGesture() {

  }
}
