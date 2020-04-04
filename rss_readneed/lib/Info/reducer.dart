import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<infoState> buildReducer() {
  return asReducer(
    <Object, Reducer<infoState>>{
      infoAction.action: _onAction,
    },
  );
}

infoState _onAction(infoState state, Action action) {
  final infoState newState = state.clone();
  return newState;
}
