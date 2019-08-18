import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum punch_cardAction {
  restartTodayAction,//刷新命中当天
  showDatePickerAction,//日期选择
  sureDatePickerAction,//确认日期
  retimeTodayAction,//刷新当天时间
  showTimePickerAction,//时间选择
  sureTimePickerAction,//确认时间
  addTomorrowThingsAction,//添加明日之星
  changeInCountAction,//更改是否统计按钮
  punchCardAction,//下班打卡操作
  refreshTodayDoThings,//刷新当天应该做的事
  doTodayThing,//勾选今天该做的事
  pushSettingVC,//跳转月度设置页面
  pushListVC,//跳转传送门页面
}

class punch_cardActionCreator {
  static Action restartTodayAction(datas) {
    return Action(punch_cardAction.restartTodayAction,payload: datas);
  }
  static Action showDatePickerAction() {
    return const Action(punch_cardAction.showDatePickerAction);
  }
  static Action sureDatePickerAction(datas) {
    return Action(punch_cardAction.sureDatePickerAction,payload: datas);
  }
  static Action retimeTodayAction() {
    return Action(punch_cardAction.retimeTodayAction);
  }
  static Action showTimePickerAction() {
    return const Action(punch_cardAction.showTimePickerAction);
  }
  static Action sureTimePickerAction(time) {
    return Action(punch_cardAction.sureTimePickerAction,payload: time);
  }
  static Action addTomorrowThingsAction() {
    return const Action(punch_cardAction.addTomorrowThingsAction);
  }
  static Action changeInCountAction(isInCount) {
    return Action(punch_cardAction.changeInCountAction,payload: isInCount);
  }
  static Action punchCardAction() {
    return const Action(punch_cardAction.punchCardAction);
  }
  static Action refreshTodayDoThings() {
    return const Action(punch_cardAction.refreshTodayDoThings);
  }
  static Action doTodayThing(thing) {
    return Action(punch_cardAction.doTodayThing,payload: thing);
  }
  static Action pushSettingVC() {
    return const Action(punch_cardAction.pushSettingVC);
  }
  static Action pushListVC() {
    return const Action(punch_cardAction.pushListVC);
  }
}
