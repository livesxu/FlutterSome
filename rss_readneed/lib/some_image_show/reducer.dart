import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<some_image_showState> buildReducer() {
  return asReducer(
    <Object, Reducer<some_image_showState>>{
      some_image_showAction.datasAction: _datasAction,
    },
  );
}

some_image_showState _datasAction(some_image_showState state, Action action) {
  final some_image_showState newState = state.clone();

  List datas = action.payload ?? [];

  newState.datas = datas;

  return newState;
}
