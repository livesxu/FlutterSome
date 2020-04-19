import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<collectState> buildReducer() {
  return asReducer(
    <Object, Reducer<collectState>>{
      collectAction.action: _onAction,
    },
  );
}

collectState _onAction(collectState state, Action action) {
  final collectState newState = state.clone();
  return newState;
}
