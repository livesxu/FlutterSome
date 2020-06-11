import 'package:fish_redux/fish_redux.dart';
import 'package:rss_readneed/Weibo/home/contentCom/adapter.dart';
import 'package:rss_readneed/Weibo/home/imagesCom/component.dart';
import 'package:rss_readneed/Weibo/home/imagesCom/state.dart';
import 'package:rss_readneed/Weibo/home/textsCom/component.dart';
import 'package:rss_readneed/Weibo/home/textsCom/state.dart';
import 'package:rss_readneed/Weibo/home/userCom/component.dart';
import 'package:rss_readneed/Weibo/home/userCom/state.dart';
import 'package:rss_readneed/Weibo/interactionsCom/component.dart';
import 'package:rss_readneed/Weibo/interactionsCom/state.dart';

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
                  "texts":ConnOp(get: (contentComState state) => textsComState(text:state.contentModel.text)) + textsComComponent(),
                  "images":ConnOp(get: (contentComState state) => imagesComState(imageUrls: state.contentModel.pic_urls.map((Pic_urlsEntity entity)=>entity.thumbnail_pic).toList())) + imagesComComponent(),
                  "interactions":ConnOp(get: (contentComState state) => interactionsComState(weiboId:state.contentModel.id.toInt(),reposts_count: state.contentModel.reposts_count.toInt(),comments_count: state.contentModel.comments_count.toInt(),attitudes_count: state.contentModel.attitudes_count.toInt())) + interactionsComComponent(),
                }),);

}

//类型转换：一种方式：继承ConnOp  2.见上方,直接写类实现get/set
class UserConnector extends ConnOp<contentComState,userComState> {

  @override
  userComState get(contentComState state) {

    UserEntity userEntity = state.contentModel.user;

    userComState userState = userComState(accountModel:userEntity);

    return userState;
  }
}