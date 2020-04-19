import 'package:fish_redux/fish_redux.dart';

import 'view.dart';

import '../../public.dart';
import 'adapter.dart';

class articlesComponent extends Component<List<ArticleModel>> {
  articlesComponent()
      : super(
            view: buildView,
            dependencies: Dependencies<List<ArticleModel>>(
                adapter: NoneConn<List<ArticleModel>>() + articlesAdapter(),
                slots: <String, Dependent<List<ArticleModel>>>{
                }),);

}
