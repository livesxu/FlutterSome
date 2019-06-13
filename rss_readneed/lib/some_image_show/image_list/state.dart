import 'package:fish_redux/fish_redux.dart';

class image_listState implements Cloneable<image_listState> {

  String id;
  List datas = [];

  @override
  image_listState clone() {
    return image_listState()
            ..id = id
            ..datas = datas;
  }
}

image_listState initState(Map<String, dynamic> args) {

  final newState = image_listState();

  newState.id = args["id"];

  return newState;
}
