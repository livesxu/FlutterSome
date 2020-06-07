import 'package:flutter/material.dart';

import 'package:dio/dio.dart';

import 'package:rss_readneed/public.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:webview_flutter/webview_flutter.dart';

//https://developer.github.com/v3/
//https://developer.github.com/apps/quickstart-guides/using-the-github-api-in-your-app/

//先从搜索存储库入手 todo: https://developer.github.com/v3/search/#search-code

//https://developer.github.com/apps/building-oauth-apps/authorizing-oauth-apps/
//访问范围限制说明与设置,目前设置repo todo: https://developer.github.com/apps/building-oauth-apps/understanding-scopes-for-oauth-apps/
class GitHubLogin extends StatefulWidget {
  @override
  _GitHubLoginState createState() => _GitHubLoginState();
}

class _GitHubLoginState extends State<GitHubLogin> {

  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

  static final String stateString = "543210012345";
  static final String redirect_uri = "http://www.livesxu.tech";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarCommon(titleString: "GitHub授权登录",ctx: context,isNeedBack: true,),
      body: Builder(builder: (BuildContext context) {
        return WebView(
          initialUrl: "https://github.com/login/oauth/authorize?scope=repo&client_id=6383de22a139c04f2833&redirect_uri="+ redirect_uri + "&login=livesxu@163.com&state="+ stateString + "&allow_signup=true",
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          navigationDelegate: (NavigationRequest request) {
            if (request.url.startsWith(redirect_uri) && request.url.contains("code")) {
              print('blocking navigation to $request}');
              int index = request.url.indexOf("code=");
              String code = request.url.substring(index);

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

  void accessTokenAction(String code) async {

    Response response = await Dio().post("https://github.com/login/oauth/access_token?client_id=6383de22a139c04f2833&client_secret=eab9d9b7b51a4b17c2920db1e5737dd72010b486&state="+ stateString + "&redirect_uri="+ redirect_uri + "&" + code);

    print(response.data);
    if (response.statusCode == 200) {
//      access_token=594ff723a7872fa276adf8d3e671774fc2774d46&scope=&token_type=bearer
      GitHubAccount.analysisInfo(response.data);

      Navigator.of(context).pop({"success":true});
    }
  }
}

mixin GitHubLoginAction {

  void judgeLogin (BuildContext context,VoidCallback voidAction) async {

    if (GitHubAccount.isLogin == false) {

      final backInfo = await Navigator.of(context).push(MaterialPageRoute(builder:(_) => GitHubLogin()));

      print("back_____" + backInfo.toString());
      if (backInfo != null && voidAction != null && backInfo['success'] == true) {

        voidAction();
      }
    } else if (voidAction != null) {

      voidAction();
    }
  }
}

class GitHubAccount {

  static bool isLogin = false;

  static String access_token = "";

  //读取数据
  static readInfo (SharedPreferences prefs) async {

    if (access_token != "") {

      return ;
    }

    if (prefs == null) {

      prefs = await SharedPreferences.getInstance();
    }

    String accountInfo = prefs.get('github_account');

    if (accountInfo == null || accountInfo.length == 0) { //如果不存在就返回空

    } else {

      access_token = accountInfo;
      isLogin = true;
    }
  }

  //储存数据
  static writeInfo() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('github_account', access_token);

  }

  //清理登录信息
  static clearInfo() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('github_account', '');

    access_token = "";
    isLogin = false;
  }

  //解析存储数据
  static analysisInfo(Map info){

    access_token = info["access_token"];
    isLogin = true;
    writeInfo();
  }
}