import 'package:flutter/material.dart';

import 'package:rxdart/rxdart.dart';

import '../public.dart';
import '../rss_add/page.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
//https://pub.dev/packages/webview_flutter#-example-tab-
import 'package:webview_flutter/webview_flutter.dart';

import '../rss_add/effect.dart';

class CommonWebView extends StatefulWidget {

  String urlString;
  String urlTitle;
  String currentLink;

  CommonWebView({

    this.urlString,
    this.urlTitle,
  });

  List<String> urlIn = [];

  @override
  _CommonWebViewState createState() => new _CommonWebViewState();
}

class _CommonWebViewState extends State<CommonWebView> {

  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

  final _subject = ReplaySubject();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        title:Text(widget.urlTitle,style: TextStyle(color: Colors.white,),),
        leading:CustomBackBtn(backAction: (){

          _controller.future.then((WebViewController ctr){

            ctr.canGoBack().then((canBack){

              if (canBack) {

                ctr.goBack();
              } else {
                Navigator.maybePop(context);
              }
            });
          });
        },),
        actions:<Widget>[
          IconButton(icon: Icon(Icons.create), onPressed: (){

            Navigator.of(context).push(MaterialPageRoute(builder: (_) => rss_addPage().buildPage({'url':widget.currentLink})))
                .then((_){
            });
          })
        ],
        shadowColor: Theme.of(context).primaryColor,
        gradient: RadialGradient(//更改为圆扩散
            colors: [Theme.of(context).primaryColorLight,Theme.of(context).primaryColorDark],
            center: Alignment.topLeft,
            radius: 4),
      ),
      body: Builder(builder: (BuildContext context) {
        return WebView(
          initialUrl: widget.urlString,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          javascriptChannels: <JavascriptChannel>[
            _toasterJavascriptChannel(context),
          ].toSet(),
          navigationDelegate: (NavigationRequest request) {
//            if (request.url.startsWith('https://www.youtube.com/')) {
//              print('blocking navigation to $request}');
//              return NavigationDecision.prevent;
//            }
//            print('allowing navigation to $request');
            return NavigationDecision.navigate;
          },
          onPageStarted: (String url) {
//            print('Page started loading: $url');
            _subject.add(url);
            widget.urlIn.add(url);
            //todo 添加loading
          },
          onPageFinished: (String url) {
//            print('Page finished loading: $url');
            widget.currentLink = url;
            widget.urlIn.remove(url);
            //todo 移除loading
          },
          gestureNavigationEnabled: true,
        );
      }),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }

  @override
  void initState() {
    super.initState();

    _subject.delay(Duration(seconds: 5)).listen((url){

      if (widget.urlIn.contains(url)) {

        //todo 移除loading
        print(url);
        judgeRssFeed(url);
      }
    });
  }

  void judgeRssFeed (String url) async {

    //1.获取内容
    http.Response response = await http.get(url,
        headers: {'User-Agent':'Mozilla/5.0 (Windows NT 6.1; WOW64)AppleWebKit/535.1 (KHTML, like Gecko) Chrome/14.0.835.163 Safari/535.1'});

    String body = utf8.decode(response.bodyBytes);

    if (body.contains('<?xml') || body.contains('<html')) {

      body = body.replaceAll("\n", "");//将换行符清除
      body = body.replaceAll(RegExp(r'>(\s*?)<'), '><');//将标签之间的空格清除

      JudgeFeed.judgeRssFeed(url, body, context,'checkFeedInWeb');
    }
  }

  @override
  void dispose() {
    super.dispose();

    _subject.close();
  }

  @override
  void didUpdateWidget(CommonWebView oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}