import 'package:fish_redux/fish_redux.dart';
import '../Home/model.dart';

class infoState implements Cloneable<infoState> {

  InfoModel infoModel;

  List<ArticleModel> articles = [];

  String flag;//标记 check:检查内容

  @override
  infoState clone() {
    return infoState()
      ..infoModel = infoModel
      ..articles = articles
      ..flag = flag;
  }
}

infoState initState(Map<String, dynamic> args) {

  infoState state = infoState()
                        ..infoModel = args["info"]
                        ..flag = args['from'];

  return state;
}
