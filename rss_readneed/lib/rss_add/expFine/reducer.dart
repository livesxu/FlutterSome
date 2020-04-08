import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<expFineState> buildReducer() {
  return asReducer(
    <Object, Reducer<expFineState>>{
      expFineAction.refreshAction: _refreshAction,
    },
  );
}

expFineState _refreshAction(expFineState state, Action action) {
  final expFineState newState = state.clone();
  return newState;
}
