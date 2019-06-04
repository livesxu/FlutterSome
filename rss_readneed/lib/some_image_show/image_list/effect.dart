import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

Effect<image_listState> buildEffect() {
  return combineEffects(<Object, Effect<image_listState>>{
    Lifecycle.initState:_init,
  });
}

void _init(Action action, Context<image_listState> ctx) async {

  http.Response response = await http.get(ctx.state.url);

  Map map = jsonDecode(response.body);

  ctx.dispatch(image_listActionCreator.datasAction(map["picture"]));

}

void _onAction(Action action, Context<image_listState> ctx) {
}
