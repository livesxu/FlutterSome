import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class textsComComponent extends Component<textsComState> {
  textsComComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<textsComState>(
                adapter: null,
                slots: <String, Dependent<textsComState>>{
                }),);

}
