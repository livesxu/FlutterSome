import 'package:fish_redux/fish_redux.dart';
import '../Home/model.dart';

class infoState implements Cloneable<infoState> {

  InfoModel infoModel;

  List<ArticleModel> articles = [];

  @override
  infoState clone() {
    return infoState()
      ..infoModel = infoModel
      ..articles = articles;
  }
}

infoState initState(Map<String, dynamic> args) {

  infoState state = infoState()
                        ..infoModel = args["info"];

  return state;
}
