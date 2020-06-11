import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum textsComAction { action }

class textsComActionCreator {
  static Action onAction() {
    return const Action(textsComAction.action);
  }
}
