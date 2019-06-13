import 'package:fish_redux/fish_redux.dart';

enum image_listAction {
  datasAction,//初始数据
  fetchAction,//拉取数据
  appendAction,//追加数据
}

class image_listActionCreator {
  static Action datasAction(List datas) {
    return Action(image_listAction.datasAction,payload:datas);
  }
  static Action fetchAction() {
    return Action(image_listAction.fetchAction);
  }
  static Action appendAction(List datas) {
    return Action(image_listAction.appendAction,payload:datas);
  }
}
