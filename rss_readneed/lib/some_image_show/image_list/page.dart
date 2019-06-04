import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class image_listPage extends Page<image_listState, Map<String, dynamic>> {
  image_listPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<image_listState>(
                adapter: null,
                slots: <String, Dependent<image_listState>>{
                }),
            middleware: <Middleware<image_listState>>[
            ],);

}
