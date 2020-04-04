import 'package:fish_redux/fish_redux.dart';

import 'view.dart';

import '../../model.dart';

class todayItemComponent extends Component<ArticleModel> {
  todayItemComponent()
      : super(
            view: buildView,
            );

}
