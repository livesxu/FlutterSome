import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:rss_readneed/some_image_show/image_list/page.dart' as image_list;

Effect<some_image_showState> buildEffect() {
  return combineEffects(<Object, Effect<some_image_showState>>{
    Lifecycle.initState: _datasAction,
    some_image_showAction.jumpListAction:_jumpListAction
  });
}

void _datasAction(Action action, Context<some_image_showState> ctx) async {

  http.Response response = await http.get("http://dili.bdatu.com/jiekou/mains/p1.html");

  Map map = jsonDecode(response.body);

  List infos = [];

  //过滤非规范形式的广告数据
  RegExp exp = RegExp(r'\d{4}-\d{2}-\d{2}');

  for (Map mapItem in map["album"]) {

    Iterable<Match> matches = exp.allMatches(mapItem["title"]);

    if (matches.length > 0) {

      Match m = matches.first;
      String match = m.group(0);

      //将时间改为年月日展示
      mapItem["addtime"] = match;

      infos.add(mapItem);
    }
  }

  ctx.dispatch(some_image_showActionCreator.datasAction(infos));
}

void _jumpListAction(Action action, Context<some_image_showState> ctx) {

  if (action.payload != null) {

    Navigator.push(ctx.context, MaterialPageRoute(builder: (_) => image_list.image_listPage().buildPage({"id":action.payload})));
  }
}
