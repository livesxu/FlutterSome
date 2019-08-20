import 'package:fish_redux/fish_redux.dart';

import 'package:rss_readneed/punch_card/punchCardModel.dart';

class punch_card_listState implements Cloneable<punch_card_listState> {

  List<PunchCardModel> monthList = [];
  PunchCardSettingModel model;

  @override
  punch_card_listState clone() {
    return punch_card_listState()
                      ..monthList = monthList;
  }
}

punch_card_listState initState(Map<String, dynamic> args) {
  punch_card_listState newState = punch_card_listState();

  newState.monthList = args["monthList"];
  newState.model = args["model"];

  return newState;
}
