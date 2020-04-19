import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';
import '../public.dart';
import '../rss_add/page.dart';

Widget buildView(collectState state, Dispatch dispatch, ViewService viewService) {
  ListAdapter adapter = viewService.buildAdapter();

  return Scaffold(
    appBar: AppbarCommon(ctx: viewService.context,titleString: 'ReadNeed',actions: <Widget>[
      IconButton(icon: Icon(Icons.create), onPressed: (){
        Navigator.of(viewService.context).push(MaterialPageRoute(builder: (_) => rss_addPage().buildPage({})))
            .then((_){
        });
      })
    ],),
    body: ListView.builder(itemBuilder: adapter.itemBuilder,itemCount: adapter.itemCount,),
  );
}
