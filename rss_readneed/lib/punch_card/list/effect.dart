import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

import 'package:rss_readneed/punch_card/punchCardModel.dart';

Effect<punch_card_listState> buildEffect() {
  return combineEffects(<Object, Effect<punch_card_listState>>{
    punch_card_listAction.action: _onAction,
    punch_card_listAction.changeCheckAction:_changeCheckAction,
  });
}

void _onAction(Action action, Context<punch_card_listState> ctx) {
}

void _changeCheckAction(Action action, Context<punch_card_listState> ctx) {

  PunchCardModel model = action.payload;

  PunchCardModel newModel = PunchCardModel(
    yearTime: model.yearTime,
    monthTime: model.monthTime,
    dateTime: model.dateTime,
    todayThings: model.todayThings,
    finishTime: model.finishTime,
    workingThings: model.workingThings,
    tomorrowThings: model.tomorrowThings,
    inCount:!model.inCount,
  );
  //变更存储数据
  PunchCardModel().save(newModel, true);
  //变更显示数据
  ctx.state.monthList;


}
