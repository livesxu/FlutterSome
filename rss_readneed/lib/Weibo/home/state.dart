import 'package:fish_redux/fish_redux.dart';

class weibo_homeState implements Cloneable<weibo_homeState> {

  List contents = [];

  @override
  weibo_homeState clone() {
    return weibo_homeState()
      ..contents = contents;
  }
}

weibo_homeState initState(Map<String, dynamic> args) {
  return weibo_homeState();
}
