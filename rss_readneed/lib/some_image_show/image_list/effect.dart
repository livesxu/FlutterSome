import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

Effect<image_listState> buildEffect() {
  return combineEffects(<Object, Effect<image_listState>>{
    Lifecycle.initState:_init,
    image_listAction.fetchAction:_fetchAction
  });
}

void _init(Action action, Context<image_listState> ctx) async {

  http.Response response = await http.get("http://dili.bdatu.com/jiekou/albums/a${ctx.state.id}.html");

  Map map = jsonDecode(response.body);

  ctx.dispatch(image_listActionCreator.datasAction(map["picture"]));

}

//拉取数据
void _fetchAction(Action action, Context<image_listState> ctx) async {

  //字符串转数字减1
  ctx.state.id = "${int.parse(ctx.state.id) - 1}";

  http.Response response = await http.get("http://dili.bdatu.com/jiekou/albums/a${ctx.state.id}.html");

  Map map = jsonDecode(response.body);

  print(map);

  ctx.dispatch(image_listActionCreator.appendAction(map["picture"]));

}
