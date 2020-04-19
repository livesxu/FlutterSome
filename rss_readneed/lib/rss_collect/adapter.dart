import 'package:fish_redux/fish_redux.dart';
import 'state.dart';

import '../Home/moduletitle/component.dart';
import '../Home/infoCom/component.dart';
import './articles/component.dart';

import '../public.dart';

class collectAdapter extends DynamicFlowAdapter<collectState> {
  collectAdapter()
      : super(
          pool: <String, Component<Object>>{
            'moduletitle':moduletitleComponent(),
            'info':infoComponentComponent(),
            'articles':articlesComponent(),
          },
          connector: _collectConnector(),
          );
}

class _collectConnector extends ConnOp<collectState, List<ItemBean>> {
  @override
  List<ItemBean> get(collectState state) {

    List<ItemBean> itemAll = [];

    if (CollectCommon.infos.length > 0) {

      itemAll.add(ItemBean('moduletitle', {'title':'栏目','module':'info','more':false}));

      List<ItemBean> items = CollectCommon.infos.map((InfoModel model) => ItemBean('info', model)).toList();
      itemAll.addAll(items);
    }

    if (CollectCommon.articles.length > 0) {

      itemAll.add(ItemBean('moduletitle', {'title':'内容','module':'info','more':false}));
      itemAll.add(ItemBean('articles', CollectCommon.articles));
    }

    return itemAll;
  }

  @override
  void set(collectState state, List<ItemBean> items) {
  }

  @override
  subReducer(reducer) {
    // TODO: implement subReducer
    return super.subReducer(reducer);
  }
}
