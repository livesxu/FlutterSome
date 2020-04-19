import 'package:flutter/material.dart';

import 'package:rxdart/rxdart.dart';

import '../public.dart';
import '../rss_add/page.dart';

import 'dart:async';
import 'dart:convert';
import 'package:gbk2utf8/gbk2utf8.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
//https://pub.dev/packages/webview_flutter#-example-tab-
import 'package:webview_flutter/webview_flutter.dart';

import '../rss_add/effect.dart';
import '../Home/model.dart';

class CommonWebView extends StatefulWidget {

  String urlString;
  String urlTitle;
  String currentLink;
  ArticleModel articleModel;//从内容条目进入将带入条目model，用以收藏并取消右侧编辑按钮

  CommonWebView({

    this.urlString,
    this.urlTitle,
    this.articleModel
  });

  List<String> urlIn = [];

  @override
  _CommonWebViewState createState() => new _CommonWebViewState();
}

class _CommonWebViewState extends State<CommonWebView> {

  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

  final _subject = ReplaySubject();

  //如果非内容条目进入则带入编辑按钮，可制作
  List<Widget> rightActions() {

    List<Widget> rightActions = [];
    if (widget.articleModel == null) {

      rightActions.add(
          IconButton(icon: Icon(Icons.create), onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => rss_addPage().buildPage({'url':widget.currentLink})))
                .then((_){
            });
          })
      );
    }
    return rightActions;
  }

  Widget floatBtn() {

    if (widget.articleModel == null) {

      return Container();
    } else {

      bool containInStore = CollectCommon.judgeArticleContain(widget.articleModel) != -1;

      return Container(
        width: 50,
        height: 150,
        child: IconButton(icon: Icon(containInStore ? Icons.star : Icons.star_border,size: 36,color: Theme.of(context).primaryColor,), onPressed: () async {

          if (containInStore) {

            bool result = await CollectCommon.removeCollectArticle(widget.articleModel);

            Toast.show(context, result ? '取消收藏成功':'取消收藏失败');

          } else {

            bool result = await CollectCommon.collectArticle(widget.articleModel);

            Toast.show(context, result ? '收藏成功':'收藏失败');
          }
          setState(() {

          });
        }),
      );
    }
  }

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
        actions:rightActions(),
        shadowColor: Theme.of(context).primaryColor,
        gradient: RadialGradient(//更改为圆扩散
            colors: [Theme.of(context).primaryColorLight,Theme.of(context).primaryColorDark],
            center: Alignment.topLeft,
            radius: 4),
      ),
      floatingActionButton: floatBtn(),
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
            LoadingCommon.show(context, true);
          },
          onPageFinished: (String url) {
//            print('Page finished loading: $url');
            widget.currentLink = url;
            widget.urlIn.remove(url);
            LoadingCommon.dismiss();
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

    _subject.delay(Duration(seconds: 2)).listen((url){

      if (widget.urlIn.contains(url)) {

        LoadingCommon.dismiss();
        print(url);
        judgeRssFeed(url);
      }
    });
  }

  void judgeRssFeed (String url) async {

    //1.获取内容
    http.Response response = await http.get(url,
        headers: {'User-Agent':RequestCommon.randomUserAgent()});

    //转码判断编码类型gbk or utf8
    String body_judge = response.body;
    RegExp exp_meta = RegExp('<meta(.*?)charset(.*?)>');
    Iterable<Match> matches_meta = exp_meta.allMatches(body_judge);
    RegExp exp_encoding = RegExp('encoding="(.*?)"');
    Iterable<Match> matches_encoding = exp_encoding.allMatches(body_judge);

    String body = '';
    if ((matches_meta.length > 0 && matches_meta.first.group(0).toLowerCase().contains('gb')) ||
        (matches_encoding.length > 0 && matches_encoding.first.group(0).toLowerCase().contains('gb'))) {

      body = gbk.decode(response.bodyBytes);
    } else {
      body = utf8.decode(response.bodyBytes);
    }

    if (body.contains('<?xml') || body.contains('<html') || body.contains('<rss')) {

      body = body.replaceAll("\r", "");//将enter符清除
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