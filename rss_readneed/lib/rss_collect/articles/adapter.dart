import 'package:fish_redux/fish_redux.dart';

import '../../public.dart';
import './articleItem/component.dart';

class articlesAdapter extends DynamicFlowAdapter<List<ArticleModel>> {
  articlesAdapter()
      : super(
          pool: <String, Component<Object>>{
            'article':articleItemComponent()
          },
          connector: _articlesConnector(),
          );
}

class _articlesConnector extends ConnOp<List<ArticleModel>, List<ItemBean>> {
  @override
  List<ItemBean> get(List<ArticleModel> state) {

    return state.map((ArticleModel model)=>ItemBean('article', model)).toList();
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
