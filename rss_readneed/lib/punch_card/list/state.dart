import 'package:fish_redux/fish_redux.dart';

class punch_card_listState implements Cloneable<punch_card_listState> {

  @override
  punch_card_listState clone() {
    return punch_card_listState();
  }
}

punch_card_listState initState(Map<String, dynamic> args) {
  return punch_card_listState();
}
