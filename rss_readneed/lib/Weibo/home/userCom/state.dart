import 'package:fish_redux/fish_redux.dart';
import 'package:rss_readneed/Weibo/home/contentCom/model.dart';
import 'package:rss_readneed/Weibo/login/weibo_account.dart';

class userComState with WeiboLoginAction implements Cloneable<userComState>  {

  UserEntity accountModel;

  bool isPageHeader;//是否顶部头展示

  userComState({UserEntity accountModel,bool isPageHeader = false}) {
    this.accountModel = accountModel;
    this.isPageHeader = isPageHeader;
  }

  @override
  userComState clone() {
    return userComState()
      ..accountModel = accountModel
      ..isPageHeader = isPageHeader;
  }
}

userComState initState(Map<String, dynamic> args) {
  return userComState();
}
