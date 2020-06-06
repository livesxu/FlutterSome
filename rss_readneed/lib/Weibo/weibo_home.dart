import 'package:flutter/material.dart';
import 'package:rss_readneed/Weibo/home/contentCom/model.dart';

import 'package:rss_readneed/Weibo/login/weibo_account.dart';
import 'package:rss_readneed/public.dart';

import 'package:dio/dio.dart';

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
        child: Column(
          children: <Widget>[
            FlatButton(onPressed: (){
              this.judgeLogin(context, (){

                print(WeiboAccount.share.access_token);
              });
            }, child: Text("登录信息：")),
            FlatButton(onPressed: (){
              this.judgeLogin(context, (){

                print(WeiboAccount.share.access_token);
                Dio().get("https://api.weibo.com/2/users/show.json?access_token=" + WeiboAccount.share.access_token + "&uid=" + WeiboAccount.share.uid).then(
                    (Response response){
                      print(response.data);
                      UserEntity userInfo = UserEntity.fromJson(response.data);

                      WeiboAccount.share.userInfo = userInfo;
                      WeiboAccount.writeInfo();
                    }
                );
              });
            }, child: Text("登录信息：")),
          ],
        )
      )
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WeiboAccount.share;
  }
}
