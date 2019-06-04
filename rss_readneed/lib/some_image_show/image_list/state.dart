import 'package:fish_redux/fish_redux.dart';

class image_listState implements Cloneable<image_listState> {

  String url;
  List datas = [];

  @override
  image_listState clone() {
    return image_listState()
            ..url = url
            ..datas = datas;
  }
}

image_listState initState(Map<String, dynamic> args) {

  final newState = image_listState();

  newState.url = "http://dili.bdatu.com/jiekou/albums/a${args["id"]}.html";

  return newState;
}
