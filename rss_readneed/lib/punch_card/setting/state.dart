import 'package:fish_redux/fish_redux.dart';

import 'package:rss_readneed/punch_card/punchCardModel.dart';

class punch_card_settingState implements Cloneable<punch_card_settingState> {

  String monthTime;

  PunchCardSettingModel model;

  //捞取、计算获得
  List<PunchCardModel> monthList = [];

  //展示的加班时长 预计下班时间
  String totalShowTime = "";
  String alreadyfinishTime = "";

  @override
  punch_card_settingState clone() {
    return punch_card_settingState()
                ..monthTime = monthTime
                ..model = model
                ..monthList = monthList
                ..totalShowTime = totalShowTime
                ..alreadyfinishTime = alreadyfinishTime;
  }
}

punch_card_settingState initState(Map<String, dynamic> args) {

  punch_card_settingState newState = punch_card_settingState();

  newState.monthTime = args["monthTime"];

  newState.model = PunchCardSettingModel.instance;//没有时拿单例里面的当前数据用一下，在init里面会初始刷新

  return newState;
}
