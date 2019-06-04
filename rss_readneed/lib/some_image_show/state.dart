import 'package:fish_redux/fish_redux.dart';

class some_image_showState implements Cloneable<some_image_showState> {
  
  List datas = [];

  @override
  some_image_showState clone() {
    return some_image_showState()
            ..datas = datas;
  }
}

some_image_showState initState(Map<String, dynamic> args) {
  
  final newState = some_image_showState();

  return newState;
}


