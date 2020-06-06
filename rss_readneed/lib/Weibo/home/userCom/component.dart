import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class userComComponent extends Component<userComState> {
  userComComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<userComState>(
                adapter: null,
                slots: <String, Dependent<userComState>>{
                }),);

}
