import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class imagesComComponent extends Component<imagesComState> {
  imagesComComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<imagesComState>(
                adapter: null,
                slots: <String, Dependent<imagesComState>>{
                }),);

}
