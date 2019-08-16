import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';
import 'package:flutter/material.dart';
import 'package:rss_readneed/punch_card/punchCardModel.dart';

Effect<punch_cardState> buildEffect() {
  return combineEffects(<Object, Effect<punch_cardState>>{
    Lifecycle.initState:_initAction,
    Lifecycle.dispose:_dispose,
    punch_cardAction.showDatePickerAction: _showDatePickerAction,
    punch_cardAction.showTimePickerAction: _showTimePickerAction,
    punch_cardAction.punchCardAction:_punchCardAction,
  });
}

void _initAction(Action action, Context<punch_cardState> ctx) {

  if (ctx.state.isChange == false && ctx.state.isToday == true) {//如果不是修改，同时又是今天，校验是否有相关数据已存在

    //获取当天string
    String dateString = PunchCardModel().dateTimeString(PunchCardModel().todayDateTime());

    //然后用当天做匹配，万一存储的数据里面有则应该展示,数据更改和查询放在effect
    Future<List<PunchCardModel>> datas = PunchCardModel().getDatas();

    datas.then((List<PunchCardModel> list){

      if (list == null) return ;

      for (int i = 0;i < list.length; i++) {

        PunchCardModel model = list[i];

        if (model.dateTime == dateString) {//命中当天存在数据，则返回更新当天数据

          ctx.dispatch(punch_cardActionCreator.restartTodayAction({"isToday":true,"isChange":true,"model":model}));
          return ;
        }
      }
    });

  }

  //刷新今天要做的事
  PunchCardModel().getTomorrowThings().then((List<String> list){

    ctx.state.storeTomorrowThings = list;

    ctx.dispatch(punch_cardActionCreator.refreshTodayDoThings());
  });

  //滑动收起键盘
  ctx.state.scrollController.addListener((){

    FocusScope.of(ctx.context).requestFocus(FocusNode());
  });

}

void _dispose(Action action, Context<punch_cardState> ctx) {

  ctx.state.scrollController.dispose();
  ctx.state.controller.dispose();

  for (int i = 0 ; i < ctx.state.tomorrowControllers.length ; i++ ) {

    TextEditingController controller = ctx.state.tomorrowControllers[i];
    controller.dispose();
  }
}

void _showDatePickerAction(Action action, Context<punch_cardState> ctx) async {

  DateTime timeSelected = await showDatePicker(
    context: ctx.context,
    initialDate: DateTime.parse(ctx.state.model.dateTime),
    firstDate: DateTime(2000),
    lastDate: DateTime(2099),
  );

  if (timeSelected == null) return ;
  //转换成model的dateTime
  String dateString = PunchCardModel().dateTimeString(timeSelected);

  if (dateString == ctx.state.model.dateTime) {//当前选择的日期与正在编辑的相同

    return ;
  }

  Future<List<PunchCardModel>> datas = PunchCardModel().getDatas();

  datas.then((List<PunchCardModel> list){

    if (list == null){//没有数据

      bool isToday = PunchCardModel().isToday(dateString);

      PunchCardModel model = PunchCardModel().initModelWith(timeSelected);

      ctx.dispatch(punch_cardActionCreator.sureDatePickerAction({"isToday":isToday,"isChange":false,"model":model}));
      return ;
    }

    for (int i = 0;i < list.length; i++) {

      PunchCardModel model = list[i];

      if (model.dateTime == dateString) {//命中存在数据，携带数据返回

        ctx.dispatch(punch_cardActionCreator.sureDatePickerAction({"isToday":PunchCardModel().isToday(dateString),"isChange":true,"model":model}));
        return ;
      }
    }
  });

  //不存在数据，则添加
  bool isToday = PunchCardModel().isToday(dateString);

  PunchCardModel model = PunchCardModel().initModelWith(timeSelected);

  ctx.dispatch(punch_cardActionCreator.sureDatePickerAction({"isToday":isToday,"isChange":false,"model":model}));
}

void _showTimePickerAction(Action action, Context<punch_cardState> ctx) async {

  //如果选择9点以前的时间将会自动移至下一天
  DateTime finishTime = DateTime.parse(ctx.state.model.finishTime);

  TimeOfDay dayTime = TimeOfDay(hour: finishTime.hour,minute: finishTime.minute);

  TimeOfDay timeSelected = await showTimePicker(context: ctx.context, initialTime: dayTime);

  if (timeSelected == null) return;

  String timeSelectedString = timeSelected.toString();
  if (timeSelectedString.contains("TimeOfDay")) {

    timeSelectedString = timeSelectedString.substring("TimeOfDay".length + 1,"TimeOfDay".length + 6);
  }

  String newFinishTimeString = ctx.state.model.dateTime + " " + timeSelectedString + ":00";

  if (timeSelected.hour < 9) {

    newFinishTimeString = PunchCardModel().timeString(DateTime.parse(newFinishTimeString).add(Duration(days: 1)));
  }

  ctx.dispatch(punch_cardActionCreator.sureTimePickerAction(newFinishTimeString));
}

//下班 提交操作
void _punchCardAction(Action action, Context<punch_cardState> ctx) {

  List<String> tomorrowThings = ctx.state.tomorrowControllers.map((controller) => controller.text).toList();
  tomorrowThings.remove("");//移除没有内容的目标
  //保存到下一个编写日使用
  PunchCardModel().saveTomorrowThings(tomorrowThings);

  PunchCardModel storeModel = PunchCardModel(
    yearTime: ctx.state.model.yearTime,
    monthTime: ctx.state.model.monthTime,
    dateTime: ctx.state.model.dateTime,
    todayThings: ctx.state.model.todayThings,
    finishTime: ctx.state.model.finishTime,
    workingThings: ctx.state.controller.text,//填充当天内容
    tomorrowThings: tomorrowThings,//填充内容
    inCount:ctx.state.model.inCount,
  );

  PunchCardModel().save(storeModel,ctx.state.isChange);

  Navigator.pop(ctx.context);
}