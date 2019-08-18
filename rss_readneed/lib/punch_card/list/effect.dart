import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<punch_card_listState> buildEffect() {
  return combineEffects(<Object, Effect<punch_card_listState>>{
    punch_card_listAction.action: _onAction,
  });
}

void _onAction(Action action, Context<punch_card_listState> ctx) {
}
