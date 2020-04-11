import 'package:fish_redux/fish_redux.dart';
import 'state.dart';
import 'model.dart';
import './infoCom/component.dart';
import './todayCom/component.dart';

class homeAdapter extends DynamicFlowAdapter<homeState> {
  homeAdapter()
      : super(
          pool: <String, Component<Object>>{
            'todays':todayComponent(),
            'info':infoComponentComponent(),

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

      List<ItemBean> items = state.infos.map((InfoModel model) => ItemBean('info', model)).toList();
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