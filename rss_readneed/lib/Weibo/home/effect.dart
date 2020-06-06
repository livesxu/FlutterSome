import 'package:dio/dio.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:rss_readneed/Weibo/home/contentCom/model.dart';
import 'package:rss_readneed/Weibo/login/weibo_account.dart';
import 'package:rss_readneed/common/loading_common.dart';
import 'action.dart';
import 'state.dart';

Effect<weibo_homeState> buildEffect() {
  return combineEffects(<Object, Effect<weibo_homeState>>{
    Lifecycle.initState:_initState,
  });
}

void _onAction(Action action, Context<weibo_homeState> ctx) {
}

void _initState(Action action, Context<weibo_homeState> ctx) async {

  LoadingCommon.show(ctx.context, false);

  await WeiboAccount.readInfo(null);

  LoadingCommon.dismiss();

  if(WeiboAccount.isLogin) {

    //获取当前登录用户的信息基础信息
    Dio().get("https://api.weibo.com/2/users/show.json?access_token=" + WeiboAccount.share.access_token + "&uid=" + WeiboAccount.share.uid)
        .then(
            (Response response){

          if(response.statusCode == 200) {
            UserEntity userInfo = UserEntity.fromJson(response.data);
            WeiboAccount.share.userInfo = userInfo;
            WeiboAccount.writeInfo();
          }
        }
    );

    //已登录，获取当前登录用户及其所关注（授权）用户的最新微博
    //https://open.weibo.com/wiki/2/statuses/home_timeline
    Dio().get("https://api.weibo.com/2/statuses/home_timeline.json?access_token=" + WeiboAccount.share.access_token + "&count=20&page=1").then(
            (Response response){
          print(response.data);

          if (response.statusCode == 200) {

            Model model = Model.fromJson(response.data);

            ctx.state.contents.addAll(model.statuses);

            ctx.dispatch(weibo_homeActionCreator.onAction());
          }
        }
    );
  } else {

  }
}
