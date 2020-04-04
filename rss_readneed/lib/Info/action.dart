import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum infoAction { action }

class infoActionCreator {
  static Action onAction() {
    return const Action(infoAction.action);
  }
}
