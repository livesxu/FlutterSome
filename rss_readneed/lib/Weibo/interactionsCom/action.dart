import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum interactionsComAction { action }

class interactionsComActionCreator {
  static Action onAction() {
    return const Action(interactionsComAction.action);
  }
}
