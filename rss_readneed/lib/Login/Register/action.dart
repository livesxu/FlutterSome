import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum registerAction {
  action,
  focusAction,//命中操作
  submitAction
}

class registerActionCreator {
  static Action onAction() {
    return const Action(registerAction.action);
  }
  static Action focusAction(index) {
    return Action(registerAction.focusAction,payload: index);
  }
  static Action submitAction() {
    return const Action(registerAction.submitAction);
  }
}
