import 'package:fish_redux/fish_redux.dart';

import 'view.dart';
import 'adapter.dart';

import '../model.dart';

class todayComponent extends Component<List<ArticleModel>> {
  todayComponent()
      : super(
            view: buildView,
            dependencies: Dependencies<List<ArticleModel>>(
                adapter: NoneConn<List<ArticleModel>>() + todayAdapter(),
                ),);

}
