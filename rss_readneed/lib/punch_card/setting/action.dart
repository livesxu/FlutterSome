import 'package:fish_redux/fish_redux.dart';

enum punch_card_settingAction {

  chooseMonthAction,//选择月份操作
  sureMonthAction,//选择月份
  changeSettingTime,//更改设置时间
  changeSettingCheck,//更改设置选择
  jumpListAction,//跳转列表页
  refreshCountInfo,//刷新统计信息
  planLeftFinishTimeAction,//规划加班时间
}

class punch_card_settingActionCreator {
  static Action chooseMonthAction() {
    return const Action(punch_card_settingAction.chooseMonthAction);
  }
  static Action sureMonthAction(monthModel) {
    return Action(punch_card_settingAction.sureMonthAction,payload:monthModel);
  }
  static Action changeSettingTime(key) {
    return Action(punch_card_settingAction.changeSettingTime,payload:key);
  }
  static Action changeSettingCheck(key) {
    return Action(punch_card_settingAction.changeSettingCheck,payload:key);
  }
  static Action jumpListAction() {
    return const Action(punch_card_settingAction.jumpListAction);
  }
  static Action refreshCountInfo() {
    return const Action(punch_card_settingAction.refreshCountInfo);
  }
  static Action planLeftFinishTimeAction() {
    return const Action(punch_card_settingAction.planLeftFinishTimeAction);
  }
}
