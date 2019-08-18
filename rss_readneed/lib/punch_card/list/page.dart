import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class punch_card_listPage extends Page<punch_card_listState, Map<String, dynamic>> {
  punch_card_listPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<punch_card_listState>(
                adapter: null,
                slots: <String, Dependent<punch_card_listState>>{
                }),
            middleware: <Middleware<punch_card_listState>>[
            ],);

}
