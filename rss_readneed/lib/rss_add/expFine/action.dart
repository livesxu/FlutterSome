import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum expFineAction {

  focusAction,//命中输入框标记
  appendDPointAction,//追加双引号
  appendGreedyAction,//追加非贪婪匹配符
  refreshAction,//刷新页面
  syncAction,//同步内容解析数据
  analysisAction,//完整解析
}

class expFineActionCreator {

  static Action focusAction(index) {
    return Action(expFineAction.focusAction,payload: index);
  }

  static Action appendDPointAction() {
    return const Action(expFineAction.appendDPointAction);
  }

  static Action appendGreedyAction() {
    return const Action(expFineAction.appendGreedyAction);
  }

  static Action refreshAction() {
    return const Action(expFineAction.refreshAction);
  }

  static Action syncAction(index) {
    return Action(expFineAction.syncAction,payload: index);
  }

  static Action analysisAction() {
    return Action(expFineAction.analysisAction);
  }
}
