import 'state.dart';
import 'action.dart';

AppState appReducer (AppState state, action) {

  return AppState(
    account: state.account,
    themeData: action,
  );
}