import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';
import 'package:rss_readneed/public.dart';

Widget buildView(weibo_homeState state, Dispatch dispatch, ViewService viewService) {

  ListAdapter listAdapter = viewService.buildAdapter();
  return Scaffold(
    appBar: AppbarCommon(titleString: "微博首页",ctx: viewService.context),
    body: ListView.builder(itemBuilder: listAdapter.itemBuilder,itemCount: listAdapter.itemCount,),
  );
}
