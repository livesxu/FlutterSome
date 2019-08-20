import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:rss_readneed/punch_card/punchCardModel.dart';
import 'package:rss_readneed/punch_card/list/page.dart' as list;

Effect<punch_card_settingState> buildEffect() {
  return combineEffects(<Object, Effect<punch_card_settingState>>{
    Lifecycle.initState:_init,
    punch_card_settingAction.chooseMonthAction: _chooseMonthAction,
    punch_card_settingAction.changeSettingTime:_changeSettingTime,
    punch_card_settingAction.changeSettingCheck:_changeSettingCheck,
    punch_card_settingAction.jumpListAction:_jumpListAction,
  });
}

void _init(Action action, Context<punch_card_settingState> ctx) async {

  //获取到当前的月份数据
  PunchCardSettingModel().getModel(ctx.state.monthTime).then(
          (PunchCardSettingModel model){

            monthTotalInfo(model, ctx);
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

            monthTotalInfo(model, ctx);
            ctx.dispatch( punch_card_settingActionCreator.sureMonthAction(model));
      });
}
//计算/赋值统计数据
void monthTotalInfo(PunchCardSettingModel model,Context<punch_card_settingState> ctx){

  PunchCardSettingModel().monthDatas(model).then(
          (List<PunchCardModel> monthList){

        if (monthList == null) return ;
        ctx.state.monthList = monthList;//数据存储下来
        int total = 0;
        int dayCount = 0;
        for (PunchCardModel dayModel in monthList) {

          if (dayModel.inCount) {

            Duration duration = DateTime.parse(dayModel.finishTime).difference(DateTime.parse(dayModel.dateTime + model.finishTime.substring(10)));

            total += duration.inMinutes;
            dayCount += 1;
          }
        }
        if (total <= 0) {
          ctx.state.totalShowTime = "00:00";
          ctx.state.alreadyfinishTime = model.finishTime.substring(11,16);
        } else {//设定的下班时间 + 总时间/统计天数
          ctx.state.totalShowTime = (total/60).floor().toString() + ":" + (total%60).toString();
          ctx.state.alreadyfinishTime = DateTime.parse(model.finishTime).add(Duration(minutes:(total/dayCount).floor())).toString().substring(11,16);
        }
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

void _jumpListAction(Action action, Context<punch_card_settingState> ctx) async {

  Navigator.push(ctx.context, MaterialPageRoute(builder: (context) => list.punch_card_listPage().buildPage({"monthList":ctx.state.monthList,"model":ctx.state.model})));
}
