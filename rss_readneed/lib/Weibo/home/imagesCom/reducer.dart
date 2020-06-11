import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<imagesComState> buildReducer() {
  return asReducer(
    <Object, Reducer<imagesComState>>{
      imagesComAction.action: _onAction,
    },
  );
}

imagesComState _onAction(imagesComState state, Action action) {
  final imagesComState newState = state.clone();
  return newState;
}
