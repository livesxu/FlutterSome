import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class expFinePage extends Page<expFineState, Map<String, dynamic>> {
  expFinePage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<expFineState>(
                adapter: null,
                slots: <String, Dependent<expFineState>>{
                }),
            middleware: <Middleware<expFineState>>[
            ],);

}
