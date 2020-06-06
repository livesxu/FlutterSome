import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum contentComAction { action }

class contentComActionCreator {
  static Action onAction() {
    return const Action(contentComAction.action);
  }
}
