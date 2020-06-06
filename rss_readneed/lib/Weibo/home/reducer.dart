import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<weibo_homeState> buildReducer() {
  return asReducer(
    <Object, Reducer<weibo_homeState>>{
      weibo_homeAction.action: _onAction,
    },
  );
}

weibo_homeState _onAction(weibo_homeState state, Action action) {
  final weibo_homeState newState = state.clone();
  return newState;
}
