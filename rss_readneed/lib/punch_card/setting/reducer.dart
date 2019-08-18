import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<punch_card_settingState> buildReducer() {
  return asReducer(
    <Object, Reducer<punch_card_settingState>>{
      punch_card_settingAction.action: _onAction,
    },
  );
}

punch_card_settingState _onAction(punch_card_settingState state, Action action) {
  final punch_card_settingState newState = state.clone();
  return newState;
}
