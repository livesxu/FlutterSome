import 'package:fish_redux/fish_redux.dart';
import 'package:rss_readneed/Weibo/home/contentCom/model.dart';

class contentComState implements Cloneable<contentComState> {

  StatusesEntity contentModel;

  contentComState({StatusesEntity model, contentModel}) {

    this.contentModel = contentModel;
  }

  @override
  contentComState clone() {
    return contentComState()
      ..contentModel = contentModel;
  }
}

contentComState initState(Map<String, dynamic> args) {
  return contentComState();
}
