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

  bool isLaunchStoreInfoSyn = false;

  Store store;
  // = Store<AppState>(appReducer,initialState: AppState(
//    account: Account.share,
//    themeData: ThemeManager.themeData
//  ));

  @override
  MyAppState createState() => new MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
        //使用FutureBuilder因为异步加载存储在本地的主题需要时间，所以添加一个开场页面
        future: didFinishLaunch(),
        builder: (BuildContext context,AsyncSnapshot<void> snapshot){

          if (snapshot.connectionState == ConnectionState.done) {

            return StoreProvider<AppState>(
              store: widget.store,
              child: StoreBuilder<AppState>(builder: (BuildContext context,Store store){

                return MaterialApp(
                  title: 'ReadNeed',
                  theme: store.state.themeData,
                  home:MainTabBar(),
//      builder: FlutterBoost.init(),//FlutterBoost初始支持
                  navigatorObservers: [NaviManagerObserver()],
                  builder: FlutterBoost.init(),
                );
              }),
            );
          } else {
            return MaterialApp(
              home: Scaffold(
                body: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Center(child: Text('时间是最宝贵的财富',style: TextStyle(
                    fontSize: 24
                  ),),)
                ),
              )
            );
          }
        }
    );
  }

  Future<void> didFinishLaunch () async {

    if (widget.isLaunchStoreInfoSyn == false) {

      final pref = await ThemeManager.initTheme();

      await Account.readInfo(pref);

      CollectCommon.readInfo(pref);//非必要性不需要等待，异步执行即可

      widget.isLaunchStoreInfoSyn = true;

      widget.store = Store<AppState>(appReducer,initialState: AppState(
          account: Account.share,
          themeData: ThemeManager.themeData
      ));

      await Future.delayed(Duration(milliseconds: 1000)); //等待1秒
    }
  }

  @override
  void initState() {
    super.initState();

    didFinishLaunch();

    ErrorHandle.systemError();

    //FlutterBoost routers 统一至router
    AppNavigator.flutterMixRouterConfig();
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
