import 'package:fish_redux/fish_redux.dart' hide Store;
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:rss_readneed/mainAppFlutterRedux/state.dart';

import 'action.dart';
import 'state.dart';
import '../public.dart';

Widget buildView(homeState state, Dispatch dispatch, ViewService viewService) {
  ListAdapter adapter = viewService.buildAdapter();

  return StoreBuilder<AppState>(builder: (_,Store store){
    return Scaffold(
        appBar: GradientAppBar(
          title:Text('ReadNeed',style: TextStyle(color: Colors.white,),),
//          actions:actions,
          shadowColor: store.state.themeData.primaryColor,
          gradient: RadialGradient(//更改为圆扩散
              colors: [store.state.themeData.primaryColorLight,store.state.themeData.primaryColorDark],
              center: Alignment.topLeft,
              radius: 4),
        ),
        body: KeepAliveWidget(child: ListView.builder(itemBuilder: adapter.itemBuilder,itemCount: adapter.itemCount,),)
    );
  });

  //使用 Theme.of(viewService.context) 获取的第一次显示有问题，可能是bug
  return Scaffold(
    appBar: AppbarCommon(ctx: viewService.context,titleString: 'ReadNeed',actions: <Widget>[
      IconButton(icon: Icon(Icons.search), onPressed: (){
        //todo 联网推荐、搜索
      })
    ],),
    body: KeepAliveWidget(child: ListView.builder(itemBuilder: adapter.itemBuilder,itemCount: adapter.itemCount,),)
  );
}
