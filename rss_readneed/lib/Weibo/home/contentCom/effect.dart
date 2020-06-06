import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<contentComState> buildEffect() {
  return combineEffects(<Object, Effect<contentComState>>{
    contentComAction.action: _onAction,
    Lifecycle.initState:_initState
  });
}

void _onAction(Action action, Context<contentComState> ctx) {
}

void _initState(Action action, Context<contentComState> ctx) {


}
