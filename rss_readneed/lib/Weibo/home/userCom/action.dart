import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum userComAction { action }

class userComActionCreator {
  static Action onAction() {
    return const Action(userComAction.action);
  }
}
