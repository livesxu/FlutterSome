import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<contentComState> buildReducer() {
  return asReducer(
    <Object, Reducer<contentComState>>{
      contentComAction.action: _onAction,
    },
  );
}

contentComState _onAction(contentComState state, Action action) {
  final contentComState newState = state.clone();
  return newState;
}
