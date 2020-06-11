import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<textsComState> buildEffect() {
  return combineEffects(<Object, Effect<textsComState>>{
    textsComAction.action: _onAction,
  });
}

void _onAction(Action action, Context<textsComState> ctx) {
}
