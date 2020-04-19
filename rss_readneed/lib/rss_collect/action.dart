import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum collectAction { action }

class collectActionCreator {
  static Action onAction() {
    return const Action(collectAction.action);
  }
}
