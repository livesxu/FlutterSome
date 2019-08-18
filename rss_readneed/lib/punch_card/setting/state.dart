import 'package:fish_redux/fish_redux.dart';

class punch_card_settingState implements Cloneable<punch_card_settingState> {

  String monthTime;

  @override
  punch_card_settingState clone() {
    return punch_card_settingState()
                ..monthTime = monthTime;
  }
}

punch_card_settingState initState(Map<String, dynamic> args) {

  punch_card_settingState newState = punch_card_settingState();

  newState.monthTime = args["monthTime"];

  return newState;
}
