import 'package:fish_redux/fish_redux.dart';

enum rss_addAction {

  sureAction,//确定
  expChangeAction,//正则改变事件
  appendGreedyAction,//追加非贪婪匹配符
  refreshAction,//刷新页面
  goNextAction,//确认进入下一页
}
//定义事件和事件关系，以及传递值
class rss_addActionCreator {

  static Action sureAction () {

    return Action(rss_addAction.sureAction);
  }

  static Action expChangeAction () {

    return Action(rss_addAction.expChangeAction);
  }
  static Action appendGreedyAction () {

    return Action(rss_addAction.appendGreedyAction);
  }
  static Action refreshAction () {

    return Action(rss_addAction.refreshAction);
  }
  static Action goNextAction () {

    return Action(rss_addAction.goNextAction);
  }

}
