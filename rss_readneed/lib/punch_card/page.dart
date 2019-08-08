import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class punch_cardPage extends Page<punch_cardState, Map<String, dynamic>> {
  punch_cardPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<punch_cardState>(
                adapter: null,
                slots: <String, Dependent<punch_cardState>>{
                }),
            middleware: <Middleware<punch_cardState>>[
            ],);

}
