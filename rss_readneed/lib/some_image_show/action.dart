import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum some_image_showAction { datasAction,jumpListAction }

class some_image_showActionCreator {
  static Action datasAction(datas) {
    return Action(some_image_showAction.datasAction,payload:datas);
  }
  static Action jumpListAction(jumpId) {
    return Action(some_image_showAction.jumpListAction,payload:jumpId);
  }
}
