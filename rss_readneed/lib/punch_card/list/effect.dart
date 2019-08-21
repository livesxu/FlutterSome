import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

import 'package:flutter/material.dart';
import 'package:rss_readneed/punch_card/punchCardModel.dart';

Effect<punch_card_listState> buildEffect() {
  return combineEffects(<Object, Effect<punch_card_listState>>{
    punch_card_listAction.changeCheckAction:_changeCheckAction,
    punch_card_listAction.changeTimeAction:_changeTimeAction,
  });
}

void _changeCheckAction(Action action, Context<punch_card_listState> ctx) {

  PunchCardModel model = action.payload;

  PunchCardModel newModel = PunchCardModel(
    yearTime: model.yearTime,
    monthTime: model.monthTime,
    dateTime: model.dateTime,
    todayThings: model.todayThings,
    finishTime: model.finishTime,
    workingThings: model.workingThings,
    tomorrowThings: model.tomorrowThings,
    inCount:!model.inCount,
  );
  //变更存储数据
  PunchCardModel().save(newModel, true);
  //变更显示数据
  int index = ctx.state.monthList.indexOf(model);

  ctx.state.monthList.removeAt(index);
  ctx.state.monthList.insert(index, newModel);

  ctx.dispatch(punch_card_listActionCreator.refreshAction());

}

void _changeTimeAction(Action action, Context<punch_card_listState> ctx) async {

  PunchCardModel model = action.payload;

  //等同 punch_card _showTimePickerAction
  //如果选择9点以前的时间将会自动移至下一天 - 选择时间点还未到涉夜加班结束时间将自动移至下一天
  DateTime finishTime = DateTime.parse(model.finishTime);

  TimeOfDay dayTime = TimeOfDay(hour: finishTime.hour,minute: finishTime.minute);

  TimeOfDay timeSelected = await showTimePicker(context: ctx.context, initialTime: dayTime);

  if (timeSelected == null) return;

  String timeSelectedString = timeSelected.toString();
  if (timeSelectedString.contains("TimeOfDay")) {

    timeSelectedString = timeSelectedString.substring("TimeOfDay".length + 1,"TimeOfDay".length + 6);
  }

  String newFinishTimeString = model.dateTime + " " + timeSelectedString + ":00";

  //所在月设置信息
  PunchCardSettingModel monthModel = await PunchCardSettingModel().getModel(model.monthTime);

  String monthFinishNextDayTime = model.dateTime + monthModel.finishNextDayTime.substring(10);
  if (DateTime.parse(newFinishTimeString).isBefore(DateTime.parse(monthFinishNextDayTime))) {

    newFinishTimeString = PunchCardModel().timeString(DateTime.parse(newFinishTimeString).add(Duration(days: 1)));
  }

  PunchCardModel newModel = PunchCardModel(
    yearTime: model.yearTime,
    monthTime: model.monthTime,
    dateTime: model.dateTime,
    todayThings: model.todayThings,
    finishTime: newFinishTimeString,
    workingThings: model.workingThings,
    tomorrowThings: model.tomorrowThings,
    inCount:model.inCount,
  );
  //变更存储数据
  PunchCardModel().save(newModel, true);
  //变更显示数据
  int index = ctx.state.monthList.indexOf(model);

  ctx.state.monthList.removeAt(index);
  ctx.state.monthList.insert(index, newModel);

  ctx.dispatch(punch_card_listActionCreator.refreshAction());

}
