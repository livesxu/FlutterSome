import 'package:fish_redux/fish_redux.dart';
import 'model.dart';

class homeState implements Cloneable<homeState> {

  List<InfoModel> infos = [];
  List<ArticleModel> todayThings = [];

  @override
  homeState clone() {
    return homeState()
      ..infos = infos
      ..todayThings = todayThings;
  }
}

homeState initState(Map<String, dynamic> args) {

  return homeState();
}
