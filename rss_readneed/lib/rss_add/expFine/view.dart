import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

import '../../public.dart';

Widget buildView(expFineState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: AppbarCommon(
      titleString: '内容完善',
      ctx: viewService.context,
    ),
    floatingActionButton:Container(
      width: 100,
      height: 100,
      child: Stack(
        children: <Widget>[
          Positioned(child: FlatButton(
            color: Theme.of(viewService.context).primaryColor,
            textColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(20))),
            child: Text("\"",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
            onPressed: () => dispatch(expFineActionCreator.appendDPointAction()),
          ),
          ),
          Positioned(top: 50, child: FlatButton(
            color: Theme.of(viewService.context).primaryColor,
            textColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(20))),
            child: Text("(.*?)",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
            onPressed: () => dispatch(expFineActionCreator.appendGreedyAction()),
          )),
        ],
      ),
    ),
    body: ListView(
      padding: EdgeInsets.only(left: 10,right: 10,bottom: 20),
      children: <Widget>[
        ListTile(
          leading: RichText(text: TextSpan(text:'栏目名称',style: TextStyle(color: Colors.black),children: [
            TextSpan(text:'*',style: TextStyle(color: Colors.red,fontSize: 16))
          ])),
          title: TextField(
            controller: state.nameEditingController,
            decoration: InputDecoration(
              hintText: "请输入栏目名称",
            ),
            onTap: (){ dispatch(expFineActionCreator.focusAction(0)); },
          ),
        ),
        Text('以下为筛选细节，需要填写指定内容的边缘信息，将指定内容用(.*?)代替，请保证边缘信息具有唯一性'),
        Card(
          child: Text(state.examples.first),
          elevation: 2,
        ),
        Card(
          child: Column(
            children: <Widget>[
              ListTile(
                leading: Text('内容标题'),
                title: TextField(
                  controller: state.titleEditingController,
                  decoration: InputDecoration(
                    hintText: "请输入内容标题",
                  ),
                  onTap: (){ dispatch(expFineActionCreator.focusAction(1)); },
                  onSubmitted: (string){ dispatch(expFineActionCreator.focusAction(-1)); dispatch(expFineActionCreator.syncAction(1)); },
                ),
                trailing: IconButton(icon: Icon(Icons.sync), onPressed: (){
                  dispatch(expFineActionCreator.syncAction(1));
                }),
              ),
              Text(state.syncTitle??"",style: TextStyle(color: Theme.of(viewService.context).primaryColor),)
            ],
          ),
        ),

        Card(
          child: Column(
            children: <Widget>[
              ListTile(
                leading: Text('内容主体'),
                title: TextField(
                  controller: state.contentEditingController,
                  decoration: InputDecoration(
                    hintText: "请输入内容主体",
                  ),
                  onTap: (){ dispatch(expFineActionCreator.focusAction(2)); },
                  onSubmitted: (string){ dispatch(expFineActionCreator.focusAction(-1)); dispatch(expFineActionCreator.syncAction(2)); },
                ),
                trailing: IconButton(icon: Icon(Icons.sync), onPressed: (){
                  dispatch(expFineActionCreator.syncAction(2));
                }),
              ),
              Text(state.syncContent??"",style: TextStyle(color: Theme.of(viewService.context).primaryColor),)
            ],
          ),
        ),

        Card(
          child: Column(
            children: <Widget>[
              ListTile(
                leading: Text('内容图片'),
                title: TextField(
                  controller: state.imageEditingController,
                  decoration: InputDecoration(
                    hintText: "请输入内容图片",
                  ),
                  onTap: (){ dispatch(expFineActionCreator.focusAction(3)); },
                  onSubmitted: (string){ dispatch(expFineActionCreator.focusAction(-1)); dispatch(expFineActionCreator.syncAction(3)); },
                ),
                trailing: IconButton(icon: Icon(Icons.sync), onPressed: (){
                  dispatch(expFineActionCreator.syncAction(3));
                }),
              ),
              Text(state.syncImage??"",style: TextStyle(color: Theme.of(viewService.context).primaryColor),)
            ],
          ),
        ),

        Card(
          child: Column(
            children: <Widget>[
              ListTile(
                leading: Text('内容链接'),
                title: TextField(
                  controller: state.linkEditingController,
                  decoration: InputDecoration(
                    hintText: "请输入内容链接",
                  ),
                  onTap: (){ dispatch(expFineActionCreator.focusAction(4)); },
                  onSubmitted: (string){ dispatch(expFineActionCreator.focusAction(-1)); dispatch(expFineActionCreator.syncAction(4)); },
                ),
                trailing: IconButton(icon: Icon(Icons.sync), onPressed: (){
                  dispatch(expFineActionCreator.syncAction(4));
                }),
              ),
              Text(state.syncLink??"",style: TextStyle(color: Theme.of(viewService.context).primaryColor),)
            ],
          ),
        ),

        //确定
        RaisedButton(
            padding: EdgeInsets.only(left: 50,right: 50),
            color: Theme.of(viewService.context).primaryColor,
            child: Text('完整解析',style: TextStyle(color: Colors.white,fontSize: 16),),
            shape: RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(15))),
            onPressed: (){
              dispatch(expFineActionCreator.analysisAction());
            }
        ),

      ],
    ),
  );
}
