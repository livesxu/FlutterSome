import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<punch_card_settingState> buildReducer() {
  return asReducer(
    <Object, Reducer<punch_card_settingState>>{
      punch_card_settingAction.sureMonthAction: _sureMonthAction,
    },
  );
}

punch_card_settingState _sureMonthAction(punch_card_settingState state, Action action) {
  final punch_card_settingState newState = state.clone();

  newState.model = action.payload;
  newState.monthTime = newState.model.monthTime;//在选择月份时月份数据也得重新赋值一下

  return newState;
}
