import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class interactionsComComponent extends Component<interactionsComState> {
  interactionsComComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<interactionsComState>(
                adapter: null,
                slots: <String, Dependent<interactionsComState>>{
                }),);

}
