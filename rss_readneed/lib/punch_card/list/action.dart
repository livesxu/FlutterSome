import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum punch_card_listAction {
  action,
  changeCheckAction,
}

class punch_card_listActionCreator {
  static Action onAction() {
    return const Action(punch_card_listAction.action);
  }
  static Action changeCheckAction(model) {
    return Action(punch_card_listAction.changeCheckAction,payload: model);
  }
}
