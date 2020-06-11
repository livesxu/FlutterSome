import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum userComAction {
  loginAction,
  action
}

class userComActionCreator {
  static Action loginAction() {
    return const Action(userComAction.loginAction);
  }
  static Action onAction() {
    return const Action(userComAction.action);
  }
}
