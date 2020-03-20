import 'package:fish_redux/fish_redux.dart';

import 'view.dart';

class PicItemComponent extends Component<Map<String,dynamic>> {
  PicItemComponent()
      : super(
//            effect: buildEffect(),
            view: buildView,
            );

}
