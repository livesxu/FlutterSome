import 'package:fish_redux/fish_redux.dart';

import '../model.dart';
import './todayItem/component.dart';

class todayAdapter extends DynamicFlowAdapter<List<ArticleModel>> {
  todayAdapter()
      : super(
          pool: <String, Component<Object>>{
            'today':todayItemComponent()
          },
          connector: _todayConnector(),
          );
}

class _todayConnector extends ConnOp<List<ArticleModel>, List<ItemBean>> {
  @override
  List<ItemBean> get(List<ArticleModel> state) {

    List<ItemBean> models = state.map((ArticleModel model)=>ItemBean('today', model)).toList();

    return models;
  }

  @override
  void set(List<ArticleModel> state, List<ItemBean> items) {
  }

  @override
  subReducer(reducer) {
    // TODO: implement subReducer
    return super.subReducer(reducer);
  }
}
