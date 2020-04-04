import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';
import '../public.dart';

Widget buildView(homeState state, Dispatch dispatch, ViewService viewService) {
  ListAdapter adapter = viewService.buildAdapter();
  return Scaffold(
    appBar: AppbarCommon(ctx: viewService.context,titleString: 'ReadNeed',actions: <Widget>[
      IconButton(icon: Icon(Icons.search), onPressed: null)
    ],),
    body: KeepAliveWidget(child: ListView.builder(itemBuilder: adapter.itemBuilder,itemCount: adapter.itemCount,),)
  );
}
