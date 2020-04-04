import 'package:fish_redux/fish_redux.dart';

class infoState implements Cloneable<infoState> {

  @override
  infoState clone() {
    return infoState();
  }
}

infoState initState(Map<String, dynamic> args) {
  return infoState();
}
