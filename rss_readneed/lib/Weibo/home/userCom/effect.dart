import 'package:dio/dio.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:rss_readneed/Weibo/home/contentCom/model.dart';
import 'package:rss_readneed/Weibo/login/weibo_account.dart';
import 'action.dart';
import 'state.dart';

Effect<userComState> buildEffect() {
  return combineEffects(<Object, Effect<userComState>>{
    userComAction.action: _onAction,
    Lifecycle.initState:_initState
  });
}

void _onAction(Action action, Context<userComState> ctx) {
}

void _initState(Action action, Context<userComState> ctx) async {

}
