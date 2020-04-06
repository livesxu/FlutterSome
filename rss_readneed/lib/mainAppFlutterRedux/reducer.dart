import 'store.dart';
import 'action.dart';

enum AppAction{
  action
}

AppStore appReducer (AppStore state, action) {

  if (action == AppAction.action) {

    print('1234');
  }
}