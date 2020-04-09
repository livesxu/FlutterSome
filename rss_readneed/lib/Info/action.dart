import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum infoAction {
  fetchAction,//获取数据
  checkSureInfo,//确认栏目
}

class infoActionCreator {
  static Action fetchAction() {
    return const Action(infoAction.fetchAction);
  }
  static Action checkSureInfo() {
    return const Action(infoAction.checkSureInfo);
  }
}
