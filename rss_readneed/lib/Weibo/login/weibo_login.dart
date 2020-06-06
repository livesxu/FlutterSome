import 'package:flutter/material.dart';

import 'package:dio/dio.dart';

import 'package:rss_readneed/public.dart';
import 'dart:async';
import 'package:webview_flutter/webview_flutter.dart';
import 'weibo_account.dart';

//https://open.weibo.com/wiki/授权机制说明
//https://open.weibo.com/wiki/Oauth2/authorize todo:注册验证流程 web适配查看验证: 1.host:https://api.weibo.com/oauth2  2.display=default
class WeiboLogin extends StatefulWidget {
  @override
  _WeiboLoginState createState() => _WeiboLoginState();
}

class _WeiboLoginState extends State<WeiboLogin> {

  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarCommon(titleString: "微博授权登录",ctx: context,isNeedBack: true,),
      body: Builder(builder: (BuildContext context) {
        return WebView(
          initialUrl: "https://open.weibo.cn/oauth2/authorize?client_id=1791529406&display=mobile&redirect_uri=https://api.weibo.com/oauth2/default.html&response_type=code",
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          navigationDelegate: (NavigationRequest request) {
            if (request.url.startsWith('https://api.weibo.com/oauth2')) {
              print('blocking navigation to $request}');
              int index = request.url.indexOf("code=");
              String code = request.url.substring(index + 5);

              print("code    " + code);

              //拿到code,获取token
              accessTokenAction(code);

              return NavigationDecision.navigate;
            }
            print('allowing navigation to $request');
            return NavigationDecision.navigate;
          },
          onPageStarted: (String url) {

            print('Page started loading: $url');
          },
          onPageFinished: (String url) {

            print('Page finished loading: $url');
          },
          gestureNavigationEnabled: true,
        );
      }),
    );
  }

//  https://open.weibo.com/wiki/Oauth2/access_token
  void accessTokenAction(String code) async {

    Response response = await Dio().post("https://open.weibo.cn/oauth2/access_token?client_id=1791529406&client_secret=bf245e3d4421d001e1ade25e60aba27f&grant_type=authorization_code&redirect_uri=https://api.weibo.com/oauth2/default.html&code=" + code);

    print(response.data);
    if (response.statusCode == 200) {

      WeiboAccount.analysisInfo(response.data);

      Navigator.of(context).pop({"success":true});
    }
  }
}