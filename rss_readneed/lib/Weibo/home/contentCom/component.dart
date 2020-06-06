import 'package:fish_redux/fish_redux.dart';
import 'package:rss_readneed/Weibo/home/contentCom/adapter.dart';
import 'package:rss_readneed/Weibo/home/userCom/component.dart';
import 'package:rss_readneed/Weibo/home/userCom/state.dart';

import 'effect.dart';
import 'model.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';
import 'adapter.dart';

class contentComComponent extends Component<contentComState> {
  contentComComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<contentComState>(
                adapter: null,
                slots: <String, Dependent<contentComState>>{
                  "user":UserConnector() + userComComponent(),
                }),);

}

class UserConnector extends ConnOp<contentComState,userComState> {

  @override
  userComState get(contentComState state) {

    UserEntity userEntity = state.contentModel.user;

    userComState userState = userComState(accountModel:userEntity);

    return userState;
  }
}