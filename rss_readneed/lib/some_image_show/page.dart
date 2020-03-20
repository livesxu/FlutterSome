import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';
import 'adapter.dart';

class some_image_showPage extends Page<some_image_showState, Map<String, dynamic>> {
  some_image_showPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<some_image_showState>(
                adapter: NoneConn<some_image_showState>() + some_image_showAdapter(),
                slots: <String, Dependent<some_image_showState>>{
                }),
            middleware: <Middleware<some_image_showState>>[
            ],
  );

}
