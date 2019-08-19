import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:rss_readneed/punch_card/punchCardModel.dart';

Effect<punch_card_settingState> buildEffect() {
  return combineEffects(<Object, Effect<punch_card_settingState>>{
    Lifecycle.initState:_init,
    punch_card_settingAction.chooseMonthAction: _chooseMonthAction,
    punch_card_settingAction.changeSettingTime:_changeSettingTime,
    punch_card_settingAction.changeSettingCheck:_changeSettingCheck,
  });
}

void _init(Action action, Context<punch_card_settingState> ctx) async {

  //获取到当前的月份数据
  PunchCardSettingModel().getModel(ctx.state.monthTime).then(
          (PunchCardSettingModel model){

            PunchCardSettingModel().monthDatas(model);

            ctx.dispatch( punch_card_settingActionCreator.sureMonthAction(model));
          });
}

void _chooseMonthAction(Action action, Context<punch_card_settingState> ctx) async {

  DateTime timeSelected = await showMonthPicker(
    context: ctx.context,
    initialDate: DateTime.parse(ctx.state.monthTime + "-01"),
    firstDate: DateTime(2000),
    lastDate: DateTime(2099),
  );

  if (timeSelected == null) return ;

  PunchCardSettingModel().getModel(timeSelected.toString().substring(0,7)).then(
          (PunchCardSettingModel model){

        ctx.dispatch( punch_card_settingActionCreator.sureMonthAction(model));
      });
}

void _changeSettingTime(Action action, Context<punch_card_settingState> ctx) async {

  Map modelMap = ctx.state.model.toJson();

  String key = action.payload;

  String timeString = modelMap[key];

  DateTime time = DateTime.parse(timeString);

  TimeOfDay dayTime = TimeOfDay(hour: time.hour,minute: time.minute);

  TimeOfDay timeSelected = await showTimePicker(context: ctx.context, initialTime: dayTime);

  if (timeSelected == null) return;

  String timeSelectedString = timeSelected.toString();
  if (timeSelectedString.contains("TimeOfDay")) {

    timeSelectedString = timeSelectedString.substring("TimeOfDay".length + 1,"TimeOfDay".length + 6);
  }

  String newTimeString = timeString.substring(0,10) + " " + timeSelectedString + ":00";

  modelMap.update(key, (timeString) => newTimeString);

  ctx.dispatch( punch_card_settingActionCreator.sureMonthAction(PunchCardSettingModel.fromJson(modelMap)) );
}

void _changeSettingCheck(Action action, Context<punch_card_settingState> ctx) async {

  Map modelMap = ctx.state.model.toJson();

  String key = action.payload;

  bool check = modelMap[key];

  modelMap.update(key, (check) => !check);

  ctx.dispatch( punch_card_settingActionCreator.sureMonthAction(PunchCardSettingModel.fromJson(modelMap)) );
}
