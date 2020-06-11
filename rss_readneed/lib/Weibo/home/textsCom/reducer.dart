import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<textsComState> buildReducer() {
  return asReducer(
    <Object, Reducer<textsComState>>{
      textsComAction.action: _onAction,
    },
  );
}

textsComState _onAction(textsComState state, Action action) {
  final textsComState newState = state.clone();
  return newState;
}
