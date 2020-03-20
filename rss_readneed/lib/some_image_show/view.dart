import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

import 'package:rss_readneed/public.dart';

Widget buildView(some_image_showState state, Dispatch dispatch, ViewService viewService) {
  final ListAdapter listAdapter = viewService.buildAdapter();
  return Scaffold(
    appBar: AppbarCommon(titleString: "地理图片集",ctx: viewService.context,isNeedBack: true,),
    body: ListView.builder(itemBuilder: listAdapter.itemBuilder,itemCount: listAdapter.itemCount,)
  );
}
