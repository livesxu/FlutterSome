import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum punch_cardAction {
  restartTodayAction,//刷新命中当天
  showDatePickerAction,//日期选择
  sureDatePickerAction,//确认日期
  retimeTodayAction,//刷新当天时间
  showTimePickerAction,//时间选择
  sureTimePickerAction,//确认时间

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
}
