import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

import '../public.dart';
import '../Home/model.dart';
import '../rss_channel/rss_web.dart';

Widget buildView(infoState state, Dispatch dispatch, ViewService viewService) {

  _itemBuild(int index){

    ArticleModel model = state.articles[index];

    List<Widget> children = [ListTile(
      title: Text(model.articleTitle),
      subtitle: Text(model.articleContent),
    )];

    if (model.articleImage != null) {

      children.insert(0,
        AspectRatio(aspectRatio: 16.0/9.0, child: ClipRRect(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(4),topRight: Radius.circular(4)),
          child: Image.network(model.articleImage,fit: BoxFit.cover,),
        ),),
      );
    }

    return InkWell(
      child: Card(
        child: Column(
          children: children,
        ),
      ),
      onTap: (){
        AppNavigator.push(viewService.context, WebView(urlString: model.articleUrl,urlTitle: model.articleTitle,));
      },
    );
  }

  List<Widget> listActions = [
    IconButton(icon: Icon(Icons.link), onPressed: (){
      AppNavigator.push(viewService.context, WebView(urlString: state.infoModel.infoUrl,urlTitle: state.infoModel.infoName,));
    })
  ];

  String titleString = state.infoModel.infoName;
  if (state.flag == 'check') {//检查栏目

    listActions.insert(0,
        IconButton(icon: Icon(Icons.check_box), onPressed: (){

          dispatch(infoActionCreator.checkSureInfo());
        })
    );

    titleString = '验证通过点击右侧✅';
  }

  return Scaffold(
      appBar: AppbarCommon(ctx: viewService.context,titleString: titleString,actions: listActions,),
      body: KeepAliveWidget(
          child:ListView.builder(
            itemBuilder: (BuildContext context,int index)=>_itemBuild(index),
            itemCount: state.articles.length,
          )
      )
  );
}
