import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';
import 'adapter.dart';

class collectPage extends Page<collectState, Map<String, dynamic>> {
  collectPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<collectState>(
                adapter: NoneConn<collectState>() + collectAdapter(),
                slots: <String, Dependent<collectState>>{
                }),
            middleware: <Middleware<collectState>>[
            ],);

}
