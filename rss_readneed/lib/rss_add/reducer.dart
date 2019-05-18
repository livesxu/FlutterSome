import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

//事件 执行 更新state信息
Reducer<rss_addState> buildReducer() {
  return asReducer(
    <Object, Reducer<rss_addState>>{
      rss_addAction.urlAction: _urlAction,
      rss_addAction.testAction: _testAction,
    },
  );
}

rss_addState _urlAction(rss_addState state, Action action) {
  final rss_addState newState = state.clone();
  final Map<String,String> urlPayload = action.payload ?? {};

  newState.urlString = urlPayload["url"];

  print(urlPayload);

  return newState;
}

rss_addState _testAction(rss_addState state,Action action) {

  final rss_addState newState = state.clone();
  final Map<String,String> testPayload = action.payload ?? {};

  newState.testString = testPayload["test"];

  print(testPayload);

  return newState;
}
