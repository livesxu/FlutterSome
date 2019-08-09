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

  //取最多的数据的那个
  int p = newState.tomorrowControllers.length > newState.model.tomorrowThings.length ? newState.tomorrowControllers.length : newState.model.tomorrowThings.length;//明日之星最多5条

  for (int i = p-1; i >= 0; i--){

    if (newState.tomorrowControllers.length > i) {//判断controllers的数量是否能取到 - 这个判断能进去说明控制器够，控制器更多

      TextEditingController controller = newState.tomorrowControllers[i];

      if (newState.model.tomorrowThings.length > i) {//这个判断能进去说明数据够
        controller.text = newState.model.tomorrowThings[i];
      } else {//数据量不够的时候把控制器移除并销毁

        newState.tomorrowControllers.remove(controller);
//        controller.dispose();？？这儿不需要销毁没事吗？
      }
    } else {//没有更多的controllers则创建 - 数据量更多

      TextEditingController controller = TextEditingController(text: newState.model.tomorrowThings[i]);

      newState.tomorrowControllers.add(controller);
    }
  }

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

  //取最多的数据的那个
  int p = newState.tomorrowControllers.length > newState.model.tomorrowThings.length ? newState.tomorrowControllers.length : newState.model.tomorrowThings.length;//明日之星最多5条

  for (int i = p-1; i >= 0; i--){

    if (newState.tomorrowControllers.length > i) {//判断controllers的数量是否能取到 - 这个判断能进去说明控制器够，控制器更多

      TextEditingController controller = newState.tomorrowControllers[i];

      if (newState.model.tomorrowThings.length > i) {//这个判断能进去说明数据够
        controller.text = newState.model.tomorrowThings[i];
      } else {//数据量不够的时候把控制器移除并销毁

        newState.tomorrowControllers.remove(controller);
//        controller.dispose();？？这儿不需要销毁没事吗？
      }
    } else {//没有更多的controllers则创建 - 数据量更多

      TextEditingController controller = TextEditingController(text: newState.model.tomorrowThings[i]);

      newState.tomorrowControllers.add(controller);
    }
  }

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
