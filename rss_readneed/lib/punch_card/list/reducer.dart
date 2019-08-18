import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<punch_card_listState> buildReducer() {
  return asReducer(
    <Object, Reducer<punch_card_listState>>{
      punch_card_listAction.action: _onAction,
    },
  );
}

punch_card_listState _onAction(punch_card_listState state, Action action) {
  final punch_card_listState newState = state.clone();
  return newState;
}
