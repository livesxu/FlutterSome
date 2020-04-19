import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<collectState> buildEffect() {
  return combineEffects(<Object, Effect<collectState>>{
    collectAction.action: _onAction,
  });
}

void _onAction(Action action, Context<collectState> ctx) {
}
