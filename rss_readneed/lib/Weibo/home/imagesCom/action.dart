import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum imagesComAction { action }

class imagesComActionCreator {
  static Action onAction() {
    return const Action(imagesComAction.action);
  }
}
