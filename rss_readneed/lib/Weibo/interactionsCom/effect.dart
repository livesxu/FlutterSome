import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<interactionsComState> buildEffect() {
  return combineEffects(<Object, Effect<interactionsComState>>{
    interactionsComAction.action: _onAction,
  });
}

void _onAction(Action action, Context<interactionsComState> ctx) {
}
