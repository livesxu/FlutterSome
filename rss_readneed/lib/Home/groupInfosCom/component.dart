import 'package:fish_redux/fish_redux.dart';

import 'view.dart';

class groupInfosComponent extends Component<Map<String,String>> {
  groupInfosComponent()
      : super(
            view: buildView,
            );

}
