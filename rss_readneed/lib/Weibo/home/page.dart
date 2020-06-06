import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';
import 'adapter.dart';

class weibo_homePage extends Page<weibo_homeState, Map<String, dynamic>> {
  weibo_homePage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<weibo_homeState>(
                adapter: NoneConn<weibo_homeState>() + weibo_homeAdapter(),
                slots: <String, Dependent<weibo_homeState>>{
                }),
            middleware: <Middleware<weibo_homeState>>[
            ],);

}
