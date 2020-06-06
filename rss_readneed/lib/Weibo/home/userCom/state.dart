import 'package:fish_redux/fish_redux.dart';
import 'package:rss_readneed/Weibo/home/contentCom/model.dart';

class userComState implements Cloneable<userComState> {

  UserEntity accountModel;

  userComState({UserEntity accountModel}) {
    this.accountModel = accountModel;
  }

  @override
  userComState clone() {
    return userComState()
      ..accountModel = accountModel;
  }
}

userComState initState(Map<String, dynamic> args) {
  return userComState();
}
