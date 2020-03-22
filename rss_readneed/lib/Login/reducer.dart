import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<LoginState> buildReducer() {
  return asReducer(
    <Object, Reducer<LoginState>>{
      LoginAction.action: _onAction,
      LoginAction.focusAction:_focusAction
    },
  );
}

LoginState _onAction(LoginState state, Action action) {
  final LoginState newState = state.clone();
  return newState;
}

LoginState _focusAction(LoginState state, Action action) {
  final LoginState newState = state.clone();
  newState.focusIndex = action.payload;

  return newState;
}

