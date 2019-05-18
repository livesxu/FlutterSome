import 'package:fish_redux/fish_redux.dart';

enum rss_addAction {
  urlAction,
  testAction,
  sureAction,
}
//定义事件和事件关系，以及传递值
class rss_addActionCreator {

  static Action urlAction (String url) {

    return Action(rss_addAction.urlAction,payload:{"url":url});
  }

  static Action testAction (String test) {

    return Action(rss_addAction.testAction,payload:{"test":test});
  }

  static Action sureAction () {

    return Action(rss_addAction.sureAction);
  }

}
