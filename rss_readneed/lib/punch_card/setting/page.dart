import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class punch_card_settingPage extends Page<punch_card_settingState, Map<String, dynamic>> {
  punch_card_settingPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<punch_card_settingState>(
                adapter: null,
                slots: <String, Dependent<punch_card_settingState>>{
                }),
            middleware: <Middleware<punch_card_settingState>>[
            ],);

}
