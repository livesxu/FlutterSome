import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

import 'package:rss_readneed/punch_card/punchCardModel.dart';
import 'package:flutter/material.dart';

Reducer<punch_cardState> buildReducer() {
  return asReducer(
    <Object, Reducer<punch_cardState>>{
      punch_cardAction.restartTodayAction:_restartTodayAction,
      punch_cardAction.sureDatePickerAction: _sureDatePickerAction,
      punch_cardAction.retimeTodayAction:_retimeTodayAction,
      punch_cardAction.sureTimePickerAction: _sureTimePickerAction,
      punch_cardAction.addTomorrowThingsAction: _addTomorrowThingsAction,
      punch_cardAction.changeInCountAction:_changeInCountAction,
      punch_cardAction.refreshTodayDoThings:_refreshTodayDoThings,
      punch_cardAction.doTodayThing:_doTodayThing,
    },
  );
}

punch_cardState _restartTodayAction(punch_cardState state, Action action) {
  final punch_cardState newState = state.clone();

  Map map = action.payload;

  newState.isToday = map["isToday"];
  newState.isChange = map["isChange"];
  newState.model = map["model"];

  newState.controller.text = newState.model.workingThings;

  List<TextEditingController> storeControllers = [];
  for (String string in newState.model.tomorrowThings) {

    TextEditingController controller = TextEditingController(text: string);

    storeControllers.add(controller);
  }
  newState.tomorrowControllers = storeControllers;

  if (newState.model.tomorrowThings.length < 5 && newState.isToday) {//当天添加

    //突出的一条添加，最多可填5条
    TextEditingController controller = TextEditingController(text: "");
    newState.tomorrowControllers.add(controller);
  }

  return newState;
}
//同上方restart方法,本质相同
punch_cardState _sureDatePickerAction(punch_cardState state, Action action) {
  final punch_cardState newState = state.clone();

  Map map = action.payload;

  newState.isToday = map["isToday"];
  newState.isChange = map["isChange"];
  newState.model = map["model"];

  newState.controller.text = newState.model.workingThings;

  List<TextEditingController> storeControllers = [];
  for (String string in newState.model.tomorrowThings) {

    TextEditingController controller = TextEditingController(text: string);

    storeControllers.add(controller);
  }
  newState.tomorrowControllers = storeControllers;

  if (newState.model.tomorrowThings.length < 5 && newState.isToday) {//当天添加

    //突出的一条添加，最多可填5条
    TextEditingController controller = TextEditingController(text: "");
    newState.tomorrowControllers.add(controller);
  }

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

punch_cardState _addTomorrowThingsAction(punch_cardState state, Action action) {
  final punch_cardState newState = state.clone();

  //如果明天控制器已达到5个，则不可再添加 - 明日之星最多5条
  if (state.tomorrowControllers.length >= 5) return newState;

  TextEditingController controller = TextEditingController(text: "");
  newState.tomorrowControllers.add(controller);

  return newState;
}

punch_cardState _changeInCountAction(punch_cardState state, Action action) {
  final punch_cardState newState = state.clone();

  bool inCount = action.payload;

  newState.model = PunchCardModel(
    yearTime: state.model.yearTime,
    monthTime: state.model.monthTime,
    dateTime: state.model.dateTime,
    todayThings: state.model.todayThings,
    finishTime: state.model.finishTime,
    workingThings: state.model.workingThings,
    tomorrowThings: state.model.tomorrowThings,
    inCount:inCount,
  );

  return newState;
}

punch_cardState _refreshTodayDoThings(punch_cardState state, Action action) {
  final punch_cardState newState = state.clone();

  //当天 && 无当天所做的事 && 取到预约事件
  if (state.isToday == true && state.model.todayThings.length == 0 && state.storeTomorrowThings != null && state.storeTomorrowThings.length > 0) {

    newState.model = PunchCardModel(
      yearTime: state.model.yearTime,
      monthTime: state.model.monthTime,
      dateTime: state.model.dateTime,
      todayThings: state.storeTomorrowThings,
      finishTime: state.model.finishTime,
      workingThings: state.model.workingThings,
      tomorrowThings: state.model.tomorrowThings,
      inCount:state.model.inCount,
    );

    return newState;

  } else {

    return  newState;
  }
}

punch_cardState _doTodayThing(punch_cardState state, Action action) {
  final punch_cardState newState = state.clone();

  String thing = action.payload;

  //通过文本改变和判断勾选
  String newThingString ;
  if (thing.contains("over|")) {

    newThingString = thing.substring(5);
  } else {

    newThingString = "over|" + thing;
  }
  List newTodayThings = state.model.todayThings;

  int index = state.model.todayThings.indexOf(thing);

  newTodayThings.removeAt(index);

  newTodayThings.insert(index, newThingString);

  newState.model = PunchCardModel(
    yearTime: state.model.yearTime,
    monthTime: state.model.monthTime,
    dateTime: state.model.dateTime,
    todayThings: newTodayThings,
    finishTime: state.model.finishTime,
    workingThings: state.model.workingThings,
    tomorrowThings: state.model.tomorrowThings,
    inCount:state.model.inCount,
  );

  return newState;
}
