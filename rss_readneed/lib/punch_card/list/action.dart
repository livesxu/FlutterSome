import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum punch_card_listAction { action }

class punch_card_listActionCreator {
  static Action onAction() {
    return const Action(punch_card_listAction.action);
  }
}
