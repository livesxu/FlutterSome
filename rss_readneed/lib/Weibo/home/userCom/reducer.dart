import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<userComState> buildReducer() {
  return asReducer(
    <Object, Reducer<userComState>>{
      userComAction.action: _onAction,
    },
  );
}

userComState _onAction(userComState state, Action action) {
  final userComState newState = state.clone();
  return newState;
}
