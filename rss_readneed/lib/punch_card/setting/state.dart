import 'package:fish_redux/fish_redux.dart';

import 'package:rss_readneed/punch_card/punchCardModel.dart';

class punch_card_settingState implements Cloneable<punch_card_settingState> {

  String monthTime;

  PunchCardSettingModel model;

  @override
  punch_card_settingState clone() {
    return punch_card_settingState()
                ..monthTime = monthTime
                ..model = model;
  }
}

punch_card_settingState initState(Map<String, dynamic> args) {

  punch_card_settingState newState = punch_card_settingState();

  newState.monthTime = args["monthTime"];

  newState.model = PunchCardSettingModel.instance;

  return newState;
}
