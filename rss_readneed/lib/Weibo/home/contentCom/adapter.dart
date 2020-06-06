import 'package:fish_redux/fish_redux.dart';
import 'package:rss_readneed/Weibo/home/contentCom/model.dart';
import 'package:rss_readneed/Weibo/home/userCom/component.dart';
import 'package:rss_readneed/Weibo/home/userCom/state.dart';
import 'state.dart';

class contentComAdapter extends StaticFlowAdapter<contentComState> {
  contentComAdapter()
      : super(
          slots:<Dependent<contentComState>>[
              UserConnector() + userComComponent(),
          ],
          );
}

class UserConnector extends ConnOp<contentComState,userComState> {

  @override
  userComState get(contentComState state) {

    UserEntity userEntity = state.contentModel.user;

    userComState userState = userComState(accountModel:userEntity);

    return userState;
  }
}
