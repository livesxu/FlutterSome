import 'package:fish_redux/fish_redux.dart';

import 'view.dart';

import '../../../public.dart';

class articleItemComponent extends Component<ArticleModel> {
  articleItemComponent()
      : super(
            view: buildView,
            );

}
