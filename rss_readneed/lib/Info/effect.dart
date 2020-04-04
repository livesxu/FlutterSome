import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<infoState> buildEffect() {
  return combineEffects(<Object, Effect<infoState>>{
    infoAction.action: _onAction,
  });
}

void _onAction(Action action, Context<infoState> ctx) {
}
