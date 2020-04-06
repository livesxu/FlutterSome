import 'package:flutter/material.dart';
import 'package:rss_readneed/public.dart';
import 'package:rss_readneed/main_tabBar.dart';

import 'package:flutter_boost/flutter_boost.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import './mainAppFlutterRedux/state.dart';
import './mainAppFlutterRedux/reducer.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {

  final store = Store<AppState>(appReducer,initialState: AppState(
    account: AccountModel(),
    themeData: ThemeData(

      scaffoldBackgroundColor: Colors.grey[100],//背景色

//        primarySwatch: mainColor,
      primaryColor: mainColor,
      primaryColorLight: mainColor[50],
      primaryColorDark:mainColor[900],

    )
  ));

  @override
  MyAppState createState() => new MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: StoreBuilder<AppState>(builder: (BuildContext context,Store store){

        return MaterialApp(
          title: 'ReadNeed',
          theme: store.state.themeData,
          home:MainTabBar(),
//      builder: FlutterBoost.init(),//FlutterBoost初始支持
          navigatorObservers: [NaviManagerObserver()],
        );
      }),
    );




      MaterialApp(
      title: 'ReadNeed',
      theme: ThemeData(

        scaffoldBackgroundColor: Colors.grey[100],//背景色

//        primarySwatch: mainColor,
        primaryColor: mainColor,
        primaryColorLight: mainColor[50],
        primaryColorDark:mainColor[900],

      ),
//      home: MyHomePage(),
      home:MainTabBar(),
//      builder: FlutterBoost.init(),//FlutterBoost初始支持
      navigatorObservers: [NaviManagerObserver()],
    );
  }
  @override
  void initState() {
    super.initState();

    ErrorHandle.systemError();
    Account.share;//默认自动加载缓存个人信息

    //FlutterBoost routers 统一至router
//    AppNavigator.flutterMixRouterConfig();
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
