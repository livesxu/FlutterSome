import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';
import '../public.dart';

//事件 执行 更新state信息
Reducer<rss_addState> buildReducer() {
  return asReducer(
    <Object, Reducer<rss_addState>>{
      rss_addAction.refreshAction: _refreshAction,
    },
  );
}

rss_addState _refreshAction(rss_addState state, Action action) {

  final rss_addState newState = state.clone();

  return newState;
}

