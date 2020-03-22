import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class registerPage extends Page<registerState, Map<String, dynamic>> {
  registerPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<registerState>(
                adapter: null,
                slots: <String, Dependent<registerState>>{
                }),
            middleware: <Middleware<registerState>>[
            ],);

}
