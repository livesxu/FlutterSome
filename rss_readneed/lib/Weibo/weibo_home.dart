import 'package:flutter/material.dart';

import 'package:rss_readneed/Weibo/login/weibo_account.dart';
import 'package:rss_readneed/public.dart';

class WeiboHome extends StatefulWidget {
  @override
  _WeiboHomeState createState() => _WeiboHomeState();
}

class _WeiboHomeState extends State<WeiboHome> with WeiboLoginAction {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarCommon(titleString: "微博首页",ctx: context),
      body: Container(
        color: Colors.red,
        child: FlatButton(onPressed: (){
          this.judgeLogin(context, (){

            print(WeiboAccount.share.access_token);
          });
        }, child: Text("登录信息：")),
      )
    );
  }
}
