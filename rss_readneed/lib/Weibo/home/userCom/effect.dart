import 'package:dio/dio.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:rss_readneed/Weibo/home/contentCom/model.dart';
import 'package:rss_readneed/Weibo/login/weibo_account.dart';
import 'action.dart';
import 'state.dart';

Effect<userComState> buildEffect()  {
  return combineEffects(<Object, Effect<userComState>>{
    userComAction.action: _onAction,
    userComAction.loginAction: _loginAction,
    Lifecycle.initState:_initState
  });
}

void _onAction(Action action, Context<userComState> ctx) {
}

void _loginAction(Action action, Context<userComState> ctx) {

  //登录
  ctx.state.judgeLogin(ctx.context, (){

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
}

void _initState(Action action, Context<userComState> ctx) async {

}
