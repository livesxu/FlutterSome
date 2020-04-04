import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class infoPage extends Page<infoState, Map<String, dynamic>> {
  infoPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<infoState>(
                adapter: null,
                slots: <String, Dependent<infoState>>{
                }),
            middleware: <Middleware<infoState>>[
            ],);

}
