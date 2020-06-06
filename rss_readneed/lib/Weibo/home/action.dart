import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum weibo_homeAction { action }

class weibo_homeActionCreator {
  static Action onAction() {
    return const Action(weibo_homeAction.action);
  }
}
