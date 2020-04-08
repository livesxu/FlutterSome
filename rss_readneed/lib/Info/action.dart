import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum infoAction {
  fetchAction,//获取数据
}

class infoActionCreator {
  static Action fetchAction() {
    return const Action(infoAction.fetchAction);
  }
}
