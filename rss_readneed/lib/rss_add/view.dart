import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import '../public.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(rss_addState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    key: state.sKey,
    appBar: AppbarCommon(
      titleString: '创建栏目',
      ctx: viewService.context,
      actions: <Widget>[
        IconButton(icon: Icon(Icons.info_outline), onPressed:(){
          state.sKey.currentState.openEndDrawer();
        })
      ],
    ),
    endDrawer: Image.asset('images_assets/exp.png'),//todo 不够详细，可以找一个更好的示例
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
            onPressed: () => dispatch(rss_addActionCreator.appendDPointAction()),
          ),
          ),
          Positioned(top: 50, child: FlatButton(
            color: Theme.of(viewService.context).primaryColor,
            textColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(20))),
            child: Text("(.*?)",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
            onPressed: () => dispatch(rss_addActionCreator.appendGreedyAction()),
          )),
        ],
      ),
    ),
    body: ListView(
      padding: EdgeInsets.only(left: 10,right: 10,bottom: 20),
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Expanded(//扩充区域部件 good
              child: TextField(
                controller: state.urlInputEditingController,
                decoration: InputDecoration(
                  labelText: "网站/链接",
                  helperText: 'eg: https://www.baidu.com',
                  hintText: "请输入需要跟踪的网站或者链接",
                ),
                onSubmitted: (string){dispatch(rss_addActionCreator.sureAction());},
              ),
            ),
            Container(
              width:80,
              height: 30,
              child: FlatButton(
                child: Icon(Icons.near_me,color: Colors.blue,),
                onPressed: () => dispatch(rss_addActionCreator.sureAction()),)
            ),
          ],
        ),
        TextField(
          controller: state.expEditingController,
          decoration: InputDecoration(
            labelText: "正则",
            hintText: "请输入顶级正则(内容/列表匹配正则)",
          ),
          onSubmitted: (string){ dispatch(rss_addActionCreator.expChangeAction());},
        ),
        Container(
          child: state.items.length > 0 ?
              Row(children: <Widget>[
                RichText(
                    text: TextSpan(text:'匹配',style: TextStyle(color: Colors.blue),children:[
                      TextSpan(text: state.items.length.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.red)),
                      TextSpan(text: '项',style: TextStyle(color: Colors.blue)),
                      TextSpan(text: ' 🔎 ',style: TextStyle(color: Colors.black,fontSize: 20)),
                      TextSpan(text: '有效项：' + state.validItems.length.toString() + ' ',style: TextStyle(color: (state.validItems.length > 0) ? Colors.blue : Colors.red)),
                    ])
                ),
                state.validItems.length > 0 ? IconButton(icon: Icon(Icons.send,size: 30,color: Theme.of(viewService.context).primaryColor,), onPressed: ()=>dispatch(rss_addActionCreator.goNextAction())) : Container()
              ],)
              :Text('未匹配',style: TextStyle(color: Colors.grey))
        ),
        Text(state.items.length > 0 ? state.items.join('\n------\n') : state.htmlBody),
      ],
    ),
  );
}
