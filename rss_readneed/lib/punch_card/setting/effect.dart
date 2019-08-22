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
    punch_card_settingAction.refreshCountInfo:_refreshCountInfo,
    punch_card_settingAction.planLeftFinishTimeAction:_planLeftFinishTimeAction,
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
        //月度计划计算
        //1.是否当月,是当月则计算，非当月则不管
        bool isCurrentMonth = DateTime.now().toString().contains(model.monthTime);

        if (isCurrentMonth == true && ctx.state.monthPlanTime != null) {
          //已存在的最后一条数据
          PunchCardModel lastExitModel = monthList.last;
          //本月最后一天
          //取下个月的第一天使用while语句
          DateTime nextMonthFirstDay = DateTime.parse(model.monthTime + "-32");

          //取计划规划的第一天 - 已存在数据的第二天
          DateTime planFirstDay = DateTime.parse(lastExitModel.dateTime).add(Duration(days: 1));
          int leftDayCount = 0;
          while (planFirstDay.isBefore(nextMonthFirstDay)) {

            PunchCardModel model = PunchCardModel().initModelWith(planFirstDay);
            if (model.inCount){

              dayCount += 1;
              leftDayCount += 1;
            }
            planFirstDay = planFirstDay.add(Duration(days: 1));
          }
          //拿到每天计划时长
          int planMinutes = DateTime.parse(model.monthTime + "-01" + " " + ctx.state.monthPlanTime + ":00").difference(DateTime.parse(model.monthTime + "-01" + model.finishTime.substring(10))).inMinutes;
          //用每天的计划时长乘以总天数
          int allMinutes = planMinutes * dayCount;

          int leftMinutes = allMinutes - total;
          //剩余天数应该理论下班时间
          String leftDayPlanFinishTime = DateTime.parse(model.finishTime).add(Duration(minutes:(leftMinutes/leftDayCount).ceil())).toString().substring(11,16);

          ctx.state.leftDayPlanFinishTime = leftDayPlanFinishTime;
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

  ctx.state.model = PunchCardSettingModel.fromJson(modelMap);

  //保存下来，同时更新单例settings
  PunchCardSettingModel().save(PunchCardSettingModel.fromJson(modelMap));
  PunchCardSettingModel.refreshSettings;

  monthTotalInfo(ctx.state.model, ctx);

  ctx.dispatch( punch_card_settingActionCreator.sureMonthAction(PunchCardSettingModel.fromJson(modelMap)) );
}

void _changeSettingCheck(Action action, Context<punch_card_settingState> ctx) async {

  Map modelMap = ctx.state.model.toJson();

  String key = action.payload;

  bool check = modelMap[key];

  modelMap.update(key, (check) => !check);

  ctx.state.model = PunchCardSettingModel.fromJson(modelMap);

  //保存下来，同时更新单例settings
  PunchCardSettingModel().save(PunchCardSettingModel.fromJson(modelMap));
  PunchCardSettingModel.refreshSettings;

  monthTotalInfo(ctx.state.model, ctx);

  ctx.dispatch( punch_card_settingActionCreator.sureMonthAction(PunchCardSettingModel.fromJson(modelMap)) );
}

void _jumpListAction(Action action, Context<punch_card_settingState> ctx) async {

  Navigator.push(ctx.context, MaterialPageRoute(builder: (context) => list.punch_card_listPage().buildPage({"monthList":ctx.state.monthList,"model":ctx.state.model})));
}

void _refreshCountInfo(Action action, Context<punch_card_settingState> ctx) async {

  monthTotalInfo(ctx.state.model, ctx);
  ctx.dispatch( punch_card_settingActionCreator.sureMonthAction(ctx.state.model));
}

void _planLeftFinishTimeAction(Action action, Context<punch_card_settingState> ctx) async {

  String planFinishTime;

  if (ctx.state.monthPlanTime == null) {

    planFinishTime = "20:00";
  } else {
    planFinishTime = ctx.state.monthPlanTime;
  }
  DateTime time = DateTime.parse(ctx.state.monthTime + "-01" + " " + planFinishTime + ":00");

  TimeOfDay dayTime = TimeOfDay(hour: time.hour,minute: time.minute);

  TimeOfDay timeSelected = await showTimePicker(context: ctx.context, initialTime: dayTime);

  if (timeSelected == null) return;

  String timeSelectedString = timeSelected.toString();
  if (timeSelectedString.contains("TimeOfDay")) {

    timeSelectedString = timeSelectedString.substring("TimeOfDay".length + 1,"TimeOfDay".length + 6);
  }

  ctx.state.monthPlanTime = timeSelectedString;

  monthTotalInfo(ctx.state.model, ctx);
  ctx.dispatch( punch_card_settingActionCreator.sureMonthAction(ctx.state.model));
}