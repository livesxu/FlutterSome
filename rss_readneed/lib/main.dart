import 'package:flutter/material.dart';
import 'package:rss_readneed/public.dart';
import 'package:rss_readneed/main_tabBar.dart';

//import 'package:flutter_boost/flutter_boost.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import './mainAppFlutterRedux/action.dart';
import './mainAppFlutterRedux/state.dart';
import './mainAppFlutterRedux/reducer.dart';

import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {

  bool isLaunchStoreInfoSyn = false;

  Store store = Store<AppState>(appReducer,initialState: AppState(
    account: Account.share,
    themeData: ThemeManager.themeData
  ));

  @override
  MyAppState createState() => new MyAppState();
}

class MyAppState extends State<MyApp> with WidgetsBindingObserver {

  String nextAnalysisString = "";

  @override
  Widget build(BuildContext context) {

    return StoreProvider<AppState>(
      store: widget.store,
      child: StoreBuilder<AppState>(builder: (BuildContext context,Store store){

        return MaterialApp(
          title: 'ReadNeed',
          theme: store.state.themeData,
          home: AdView(
            completedCallback: (BuildContext adContext){
              //广告页加载完成之后 使主题生效
              Store<AppState> state = StoreProvider.of(adContext);
              state.dispatch(ThemeDataAction(color: themeColors[ThemeManager.share.themeIndex]));
//      state.dispatch(AccountAction(account: Account.share.));todo:账号同步

              Navigator.of(adContext).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context){
                    return MainTabBar();
                  }),
                      (route) => route == null
              );

              //处理剪切板 or scheme 的跳转逻辑
              getClipboardData();
            },
          ),
//      builder: FlutterBoost.init(),//FlutterBoost初始支持
          navigatorObservers: [NaviManagerObserver()],
//          builder: FlutterBoost.init(),
        );
      }),
    );
  }

  Future<void> didFinishLaunch () async {

    if (widget.isLaunchStoreInfoSyn == false) {

      final pref = await ThemeManager.initTheme();

      await Account.readInfo(pref);

      CollectCommon.readInfo(pref);//非必要性不需要等待，异步执行即可

      widget.isLaunchStoreInfoSyn = true;
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    initRegisterEvent();

    didFinishLaunch();

    ErrorHandle.systemError();

    //FlutterBoost routers 统一至router
//    AppNavigator.flutterMixRouterConfig();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.inactive: // 处于这种状态的应用程序应该假设它们可能在任何时候暂停。
        break;
      case AppLifecycleState.resumed: //从后台切换前台，界面可见

        getClipboardData();
        break;
      case AppLifecycleState.paused: // 界面不可见，后台
        break;
      case AppLifecycleState.detached: // APP结束时调用
        break;
    }
  }

  //注册 scheme event的交互事件
  void initRegisterEvent () {

//    EventChannel _eventChannel = EventChannel("scheme_open_url");
//
//    _eventChannel.receiveBroadcastStream().listen((event) {
//
//      //得到scheme url链接
//      nextAnalysisString = event.toString();
//      analysisHandleIfNext();
//    });
  }

  //解析剪切板内容
  void getClipboardData () async {

    /// 取出粘贴板的文本
    ClipboardData r = await Clipboard.getData(Clipboard.kTextPlain);

    if (r == null) return;

    nextAnalysisString = r.text;
    analysisHandleIfNext();
  }

  //处理将要执行的动作 - 针对性解析rss
  void analysisHandleIfNext() {

    if (nextAnalysisString.startsWith('readneed://') ||
        nextAnalysisString.startsWith('read://') ||
        nextAnalysisString.startsWith('rss://') ||
        nextAnalysisString.startsWith('feed://')
    ){
      nextAnalysisString = nextAnalysisString.replaceAll(RegExp(r'(.*?)://'), "http://");

      //解析链接
      LinkJudgeFeed.judgeRssFeed(nextAnalysisString);

      Future.delayed(Duration(seconds: 3),(){//延时3秒

        Clipboard.setData(ClipboardData(text: ""));//解析结束将剪切板置空
      });
    }


  }

  @override
  void dispose() {

    WidgetsBinding.instance.removeObserver(this);
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

typedef AdCallback = void Function(BuildContext adContext);

class AdView extends StatefulWidget {

  AdCallback completedCallback;

  AdCallback clickCallBack;

  AdView({
    @required this.completedCallback,
    this.clickCallBack,
  });

  @override
  _AdViewState createState() => _AdViewState();
}

class _AdViewState extends State<AdView> with SingleTickerProviderStateMixin{

  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 3000));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);

    //监听动画运行状态，当状态为completed时，动画执行结束，跳转首页
    _animation.addStatusListener((status){

      if(status == AnimationStatus.completed){

        widget.completedCallback(context);
      }
    });
    _controller.forward(); // 播放动画
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();//释放动画
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(//透明度动画组件
        opacity: _animation, //动画
        child:InkWell(
          child: Container(
              width: double.infinity,
              height: double.infinity,
              child: Center(child: Text('时间是最宝贵的财富',style: TextStyle(
                  fontSize: 24
              ),),)
          ),
          onTap: (){
            if (widget.clickCallBack != null) {
              widget.clickCallBack(context);
            }
          },
        ),
      ),
    );
  }
}


