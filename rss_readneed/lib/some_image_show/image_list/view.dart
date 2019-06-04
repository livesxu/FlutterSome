import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

import 'package:rss_readneed/appbar_gradient.dart';

Widget buildView(image_listState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: GradientAppBar(
      title: Text("image_list_page"),
      shadowColor: Theme.of(viewService.context).primaryColor,
      gradient: RadialGradient(//更改为圆扩散
          colors: [Theme.of(viewService.context).primaryColorLight,Theme.of(viewService.context).primaryColorDark],
          center: Alignment.topLeft,
          radius: 4),
    ),
    body: ListView(
      children: state.datas.map((info){

        return Container(
            padding: EdgeInsets.only(left: 8,top: 8,right: 8),
            child: InkWell(
              child: Card(
                child: Stack(
                  children: <Widget>[
                    ClipRRect(borderRadius: BorderRadius.all(Radius.circular(4)),child: Image.network(info["url"]),),

                  ],
                ),
                elevation: 4,
              ),
            )
        );
      }).toList(),
    )
  );
}
