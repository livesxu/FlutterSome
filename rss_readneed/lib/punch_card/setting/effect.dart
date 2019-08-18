import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<punch_card_settingState> buildEffect() {
  return combineEffects(<Object, Effect<punch_card_settingState>>{
    punch_card_settingAction.action: _onAction,
  });
}

void _onAction(Action action, Context<punch_card_settingState> ctx) {
}
