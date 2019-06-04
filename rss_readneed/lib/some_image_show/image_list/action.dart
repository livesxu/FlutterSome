import 'package:fish_redux/fish_redux.dart';

enum image_listAction { datasAction }

class image_listActionCreator {
  static Action datasAction(List datas) {
    return Action(image_listAction.datasAction,payload:datas);
  }
}
