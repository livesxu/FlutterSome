import 'package:fish_redux/fish_redux.dart';
import 'package:rss_readneed/Weibo/home/contentCom/component.dart';
import 'package:rss_readneed/Weibo/home/contentCom/model.dart';
import 'package:rss_readneed/Weibo/home/contentCom/state.dart';
import 'package:rss_readneed/Weibo/home/userCom/component.dart';
import 'package:rss_readneed/Weibo/home/userCom/state.dart';
import 'package:rss_readneed/Weibo/login/weibo_account.dart';
import 'state.dart';

class weibo_homeAdapter extends DynamicFlowAdapter<weibo_homeState> {
  weibo_homeAdapter()
      : super(
          pool: <String, Component<Object>>{
            "user":userComComponent(),
            "content":contentComComponent()
          },
          connector: _weibo_homeConnector(),
          );
}

class _weibo_homeConnector extends ConnOp<weibo_homeState, List<ItemBean>> {
  @override
  List<ItemBean> get(weibo_homeState state) {

    List<ItemBean> list = <ItemBean>[];

    list.add(ItemBean("user",userComState(accountModel: WeiboAccount.share.userInfo,isPageHeader: true)));

    if(state.contents != null) {

      list.addAll(state.contents.map((statusesEntity) => ItemBean("content", contentComState(contentModel:statusesEntity))).toList());
    }

    return list;
  }

  @override
  void set(weibo_homeState state, List<ItemBean> items) {
  }

  @override
  subReducer(reducer) {
    // TODO: implement subReducer
    return super.subReducer(reducer);
  }
}
