import 'package:fish_redux/fish_redux.dart';
import 'state.dart';
import './PicComponent/component.dart';

class some_image_showAdapter extends DynamicFlowAdapter<some_image_showState> {
  some_image_showAdapter()
      : super(
          pool: <String, Component<Object>>{

            'info':PicItemComponent()
          },
          connector: _some_image_showConnector(),
          );
}

class _some_image_showConnector extends ConnOp<some_image_showState, List<ItemBean>> {
  @override
  List<ItemBean> get(some_image_showState state) {

    if (state.datas.length == 0) {

      return [];
    }

    List<ItemBean> items = state.datas.map((data) => ItemBean('info',data)).toList();

    return items;
  }

  @override
  void set(some_image_showState state, List<ItemBean> subState) {
    // TODO: implement set
    super.set(state, subState);
  }

  @override
  subReducer(reducer) {
    // TODO: implement subReducer
    return super.subReducer(reducer);
  }
}
