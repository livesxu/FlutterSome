import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

import 'package:rss_readneed/punch_card/punchCardModel.dart';

Reducer<punch_cardState> buildReducer() {
  return asReducer(
    <Object, Reducer<punch_cardState>>{
      punch_cardAction.restartTodayAction:_restartTodayAction,
      punch_cardAction.sureDatePickerAction: _sureDatePickerAction,
      punch_cardAction.retimeTodayAction:_retimeTodayAction,
      punch_cardAction.sureTimePickerAction: _sureTimePickerAction,
    },
  );
}

punch_cardState _restartTodayAction(punch_cardState state, Action action) {
  final punch_cardState newState = state.clone();

  Map map = action.payload;

  newState.isToday = map["isToday"];
  newState.isChange = map["isChange"];
  newState.model = map["model"];

  return newState;
}

punch_cardState _sureDatePickerAction(punch_cardState state, Action action) {
  final punch_cardState newState = state.clone();

  Map map = action.payload;

  newState.isToday = map["isToday"];
  newState.isChange = map["isChange"];
  newState.model = map["model"];

  return newState;
}

punch_cardState _retimeTodayAction(punch_cardState state, Action action) {
  final punch_cardState newState = state.clone();

  newState.model = PunchCardModel(
    yearTime: state.model.yearTime,
    monthTime: state.model.monthTime,
    dateTime: state.model.dateTime,
    todayThings: state.model.todayThings,
    finishTime: PunchCardModel().timeString(DateTime.now()),
    workingThings: state.model.workingThings,
    tomorrowThings: state.model.tomorrowThings,
    inCount:state.model.inCount,
  );

  return newState;
}

punch_cardState _sureTimePickerAction(punch_cardState state, Action action) {
  final punch_cardState newState = state.clone();

  String newFinishTime = action.payload;

  newState.model = PunchCardModel(
    yearTime: state.model.yearTime,
    monthTime: state.model.monthTime,
    dateTime: state.model.dateTime,
    todayThings: state.model.todayThings,
    finishTime: newFinishTime,
    workingThings: state.model.workingThings,
    tomorrowThings: state.model.tomorrowThings,
    inCount:state.model.inCount,
  );

  return newState;
}
