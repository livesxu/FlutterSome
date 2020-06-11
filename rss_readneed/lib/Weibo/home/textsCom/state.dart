import 'package:fish_redux/fish_redux.dart';

class textsComState implements Cloneable<textsComState> {

  String text = '';

  textsComState({String text}) {

    this.text = text;
  }

  @override
  textsComState clone() {
    return textsComState()
      ..text = text;
  }
}

textsComState initState(Map<String, dynamic> args) {
  return textsComState();
}
