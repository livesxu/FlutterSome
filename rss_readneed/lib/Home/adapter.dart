import 'package:fish_redux/fish_redux.dart';
import 'state.dart';
import 'model.dart';
import './infoCom/component.dart';
import './todayCom/component.dart';
import './groupInfosCom/component.dart';
import './moduletitle/component.dart';

import 'model.dart';

class homeAdapter extends DynamicFlowAdapter<homeState> {
  homeAdapter()
      : super(
          pool: <String, Component<Object>>{
            'moduletitle':moduletitleComponent(),
            'todays':todayComponent(),
            'info':infoComponentComponent(),
            'groupInfo':groupInfosComponent(),
          },
          connector: _homeConnector(),
          );
}

class _homeConnector extends ConnOp<homeState, List<ItemBean>> {
  @override
  List<ItemBean> get(homeState state) {

    List<ItemBean> itemAll = [];

    if(state.todayThings.length > 0) {

      itemAll.add(ItemBean('todays', state.todayThings));
    }

    if (state.infos.length > 0) {

      itemAll.add(ItemBean('moduletitle', {'title':'订阅推荐','module':'info','more':false}));

      List<ItemBean> items = state.infos.map((InfoModel model) => ItemBean('info', model)).toList();
      itemAll.addAll(items);
    } else {
      //如果网络数据没有加载本地数据展示
      List<InfoModel> localDatas = someFeedInfos.map((obj) => InfoModel.fromJson(obj)).toList();
      List<ItemBean> items = localDatas.map((InfoModel model) => ItemBean('info', model)).toList();
      itemAll.addAll(items);
    }

    //todo 网络来源同步更新处理
    if (FeedGroupInfoLinks.length > 0) {

      itemAll.add(ItemBean('moduletitle', {'title':'RSS站点推荐','module':'groupInfo','more':false}));

      List<ItemBean> items = FeedGroupInfoLinks.map((Map<String,String> groupOne) => ItemBean('groupInfo', groupOne)).toList();
      itemAll.addAll(items);
    }

    return itemAll;
  }

  @override
  void set(homeState state, List<ItemBean> items) {
  }

  @override
  subReducer(reducer) {
    // TODO: implement subReducer
    return super.subReducer(reducer);
  }
}
