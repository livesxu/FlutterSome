import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

import 'package:rss_readneed/public.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';

Widget buildView(image_listState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
//    appBar: AppbarCommon(ctx: viewService.context,titleString: "image_list_page",),
    body:EasyRefresh(
      refreshFooter: MaterialFooter(key: null),//更换样式
      child: CustomScrollView(
          slivers: <Widget>[

            SliverAppbarCommon(
              ctx: viewService.context,
              titleString: "图片",
//              floating: true,//跟随滑动展示头视图
//          expandedHeight: 100,//扩展高度
//          flexibleSpace:FlexibleSpaceBar(//扩展bar
////            title: Text("SubTitle Show".toUpperCase()),
//            background: Image.network(state.datas[0]["url"],fit: BoxFit.cover,),
//          ),
//          bottom: PreferredSize(child: Text("TT"), preferredSize: Size(40, 40)),//扩展底部按钮
            ),
            SliverSafeArea(
              top: false,//头部非安全
              minimum: EdgeInsets.all(4),
              sliver: SliverList(
                  delegate: SliverChildListDelegate(
                      state.datas.map((info){

                        return Card(
                          child: Stack(
                            children: <Widget>[
                              ClipRRect(borderRadius: BorderRadius.all(Radius.circular(4)),child: Image.network(info["url"]),),

                            ],
                          ),
                          elevation: 4,
                        );
                      }).toList(),
                      semanticIndexCallback: (_,int) {//将出现index

                        print(int);
                        if (int == (state.datas.length - 2)) {

                          dispatch(image_listActionCreator.fetchAction());
                        }
                      }
                  )
              ),
            ),
          ],
        ),
//        onRefresh: () async{
//          print("onrefresh");
//        },
        loadMore: () async {

          dispatch(image_listActionCreator.fetchAction());
        }
    )
//    list展示方式
//    ListView(
//      children: state.datas.map((info){
//
//        return Container(
//            padding: EdgeInsets.only(left: 8,top: 8,right: 8),
//            child: InkWell(
//              child: Card(
//                child: Stack(
//                  children: <Widget>[
//                    ClipRRect(borderRadius: BorderRadius.all(Radius.circular(4)),child: Image.network(info["url"]),),
//
//                  ],
//                ),
//                elevation: 4,
//              ),
//            )
//        );
//      }).toList(),
//    )
  );
}
