import 'package:fish_redux/fish_redux.dart';

import 'view.dart';

import '../model.dart';

class infoComponentComponent extends Component<InfoModel> {
  infoComponentComponent()
      : super(
            view: buildView,
            );

}
