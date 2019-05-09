import 'package:flutter/material.dart';

//web页不能对http正确加载需要设置 - android和iOS都需要，设置完重新打开即可
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import 'package:rxdart/rxdart.dart';

class WebView extends StatefulWidget {

  String urlString;
  String urlTitle;

  WebView({

    this.urlString,
    this.urlTitle,
  });

  @override
  _WebViewState createState() => new _WebViewState();
}

class _WebViewState extends State<WebView> {

  final _flutterWebviewPlugin = new FlutterWebviewPlugin();

  final _subject = ReplaySubject();

  @override
  Widget build(BuildContext context) {
    return new WebviewScaffold(
      appBar: AppBar(title: Text(widget.urlTitle),),
      url: widget.urlString,
      withZoom: false,
    );
  }
  @override
  void initState() {
    super.initState();

    _subject.
    debounce((_) => TimerStream(true, const Duration(seconds: 2))).//连续2s内的信息不处理
    listen((data){

        if (data == "1") {

          _flutterWebviewPlugin.show();
        }
      });

    _flutterWebviewPlugin.onUrlChanged.listen((data){

      print("onUrlChanged:$data");
    });

    _flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state){

      print("onStateChanged:${state.type},${state.url},${state.navigationType}");

      if (state.type == WebViewState.startLoad) {

          _flutterWebviewPlugin.hide();
      }

      if (state.type == WebViewState.shouldStart) {

        _subject.add("1");
      }
      //有时候finishLoad不会回调 - 所以添加监听shouldStart,在停止回调shouldStart的两秒后展示
      if (state.type == WebViewState.finishLoad) {

        _flutterWebviewPlugin.show();
      }
    });

//    _flutterWebviewPlugin.onProgressChanged.listen((progress){
//
//      print("progress = $progress");
//    });

  }

  @override
  void dispose() {
    super.dispose();

    _flutterWebviewPlugin.dispose();
    _subject.close();
  }

  @override
  void didUpdateWidget(WebView oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}