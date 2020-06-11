import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<interactionsComState> buildReducer() {
  return asReducer(
    <Object, Reducer<interactionsComState>>{
      interactionsComAction.action: _onAction,
    },
  );
}

interactionsComState _onAction(interactionsComState state, Action action) {
  final interactionsComState newState = state.clone();
  return newState;
}
