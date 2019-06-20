import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

import 'package:rss_readneed/public.dart';

Widget buildView(some_image_showState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: AppbarCommon(titleString: "some_image_page",ctx: viewService.context,),
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
