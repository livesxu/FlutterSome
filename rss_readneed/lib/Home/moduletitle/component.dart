import 'package:fish_redux/fish_redux.dart';

import 'view.dart';

class moduletitleComponent extends Component<Map> {
  moduletitleComponent()
      : super(
            view: buildView,
            dependencies: Dependencies<Map>(
                adapter: null,
                slots: <String, Dependent<Map>>{
                }),);

}
