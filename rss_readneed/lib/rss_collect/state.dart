import 'package:fish_redux/fish_redux.dart';

class collectState implements Cloneable<collectState> {

  @override
  collectState clone() {
    return collectState();
  }
}

collectState initState(Map<String, dynamic> args) {
  return collectState();
}
