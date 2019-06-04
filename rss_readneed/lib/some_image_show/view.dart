import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

import 'package:rss_readneed/appbar_gradient.dart';

Widget buildView(some_image_showState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: GradientAppBar(
      title: Text("some_image_page"),
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
                  Positioned(
                      left: 4,
                      top: 4,
                      child: Row(
                        children: <Widget>[
                          Text(info["addtime"] ?? "",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(width: 5,),
                          Icon(Icons.arrow_forward,color:Colors.white,)
                        ],
                      )
                  ),

                ],
              ),
              elevation: 4,
            ),
            onTap: (){
              dispatch(some_image_showActionCreator.jumpListAction(info["id"]));
            },
          )
        );
      }).toList(),
    ),
  );
}
