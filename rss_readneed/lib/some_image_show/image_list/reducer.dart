import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<image_listState> buildReducer() {
  return asReducer(
    <Object, Reducer<image_listState>>{
      image_listAction.datasAction: _datasAction,
    },
  );
}

image_listState _datasAction(image_listState state, Action action) {
  final image_listState newState = state.clone();

  newState.datas = action.payload;

  return newState;
}
