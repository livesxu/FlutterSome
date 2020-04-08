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

    return ListTile(
      title: Text(model.articleTitle),
      onTap: (){
        AppNavigator.push(viewService.context, WebView(urlString: model.articleUrl,urlTitle: model.articleTitle,));
      },
    );
  }

  return Scaffold(
      appBar: AppbarCommon(ctx: viewService.context,titleString: state.infoModel.infoName,actions: <Widget>[
        IconButton(icon: Icon(Icons.link), onPressed: (){
          AppNavigator.push(viewService.context, WebView(urlString: state.infoModel.infoUrl,urlTitle: state.infoModel.infoName,));
        })
      ],),
      body: KeepAliveWidget(
          child:ListView.builder(
            itemBuilder: (BuildContext context,int index)=>_itemBuild(index),
            itemCount: state.articles.length,
          )
      )
  );
}
