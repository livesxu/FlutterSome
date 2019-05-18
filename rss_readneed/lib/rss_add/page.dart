import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class rss_addPage extends Page<rss_addState, Map<String, dynamic>> {
  rss_addPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<rss_addState>(
                adapter: null,
                slots: <String, Dependent<rss_addState>>{
                }),
            middleware: <Middleware<rss_addState>>[
            ],);

}
