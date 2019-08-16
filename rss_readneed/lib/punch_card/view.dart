import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';
import 'package:rss_readneed/public.dart';
import 'package:flutter/services.dart';

Widget buildView(punch_cardState state, Dispatch dispatch, ViewService viewService) {

  return Scaffold(
    appBar: AppbarCommon(ctx: viewService.context,titleString: "工作记忆",isNeedBack: true,),
    body: ListView(
      controller: state.scrollController,
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              child: Column(
                children: state.model.todayThings.map((string){
                  //over|
                  String newTitleString = string;
                  if (string.contains("over|")) {
                    newTitleString = string.substring(5);
                  }
                  return ListTile(
                    title: Text(newTitleString),
                    trailing: Checkbox(
                        value: string.contains("over|"),
                        onChanged: (bool isSure){
                          //是否完成 - 选择
                        dispatch(punch_cardActionCreator.doTodayThing(string));
                        }),
                  );
                }).toList(),
              ),
            ),//今日执行
            Container(
              child: Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //日期选择
                    InkWell(
                      child: Container(
                        child: Text(state.model.dateTime,
                          style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w900),
                        ),
                        decoration: BoxDecoration(color: Colors.red,borderRadius: BorderRadius.all(Radius.circular(4))),
                        padding: EdgeInsets.only(top: 3,bottom: 3,left: 6,right: 6),
                        margin: EdgeInsets.all(10),
                      ),
                      onTap: (){ dispatch(punch_cardActionCreator.showDatePickerAction()); },
                    ),
                    //时间选择
                    InkWell(
                      child: Container(
                        child: Text(state.model.finishTime.contains(state.model.dateTime) ? state.model.finishTime.substring(state.model.dateTime.length) : state.model.finishTime,
                          style: TextStyle(fontSize:state.model.finishTime.contains(state.model.dateTime) ? 32 : 16,fontWeight: FontWeight.w600),
                        ),
                        margin: EdgeInsets.only(top: 40,bottom: 20),
                      ),
                      onTap: (){dispatch(punch_cardActionCreator.showTimePickerAction());},
                    ),
                    Container(
                      child: state.isToday ? IconButton(icon: Icon(Icons.refresh,color: Colors.blue,), onPressed: (){ dispatch(punch_cardActionCreator.retimeTodayAction());}) : Container(),
                      margin: EdgeInsets.only(top: 30,bottom: 20),
                    )
                  ],
                ),
              ),
            ),//当前下班时间
            Container(
              child: TextField(
                controller: state.controller,
//            autofocus: true,
//            focusNode: state.focusNode,
                maxLength: 300,
                maxLines: 10,
                decoration: InputDecoration(
                  hintText: " 随笔记录",
                  hintStyle: TextStyle(fontSize: 14),
                  border: OutlineInputBorder(),//全边框样式
                ),
              ),
              height: 140,
              padding: EdgeInsets.all(4),
            ),//随笔记录,
            Container(
              child: ListTile(
                leading: Text("明日之星",
                  style: TextStyle(color: Colors.lightBlue,fontSize: 20,fontWeight: FontWeight.w700),
                ),),
            ),
            Container(
                child: Card(
                  child: Column(
                    children: TomorrowThingsItems(state.tomorrowControllers,state.isToday,dispatch),
                  ),
                )
            ),//明日之星
            Container(
              child: Row(
                children: <Widget>[
                  FlatButton(
                      onPressed: null,
                      child: Row(
                        children: <Widget>[
                          Checkbox(
                              value: state.model.inCount,
                              onChanged: (bool inCount){
                                //是否统计
                                dispatch(punch_cardActionCreator.changeInCountAction(inCount));
                              }),
                          Text("统计下班")
                        ],
                      )
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                      child: RaisedButton(
                        color: Theme.of(viewService.context).primaryColor,
                        onPressed: (){ dispatch(punch_cardActionCreator.punchCardAction()); },
                        child: Text(state.isChange ? "更新下班" : "下班",
                          style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w700),
                        ),
                      )
                  )
                ],
              ),
              padding: EdgeInsets.all(4),
            ),//下班
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  RaisedButton(
                    onPressed: null,
                    child: Text("月度规划"),
                  ),
                  SizedBox(width: 10,),
                  RaisedButton(
                    onPressed: null,
                    child: Text("传送门"),
                  )
                ],
              ),
              padding: EdgeInsets.all(4),
            ),//月度规划,传送门
          ],
        ),
      ],
    )
  );
}

List<Widget> TomorrowThingsItems(List<TextEditingController> controllers,bool isToday,Dispatch dispatch) {

  List<Widget> list = [];

  for (int i = 0;i < controllers.length;i++) {

    Widget widget = Row(
      children: <Widget>[
        SizedBox(width: 10,),
        Expanded(child: TextField(
          enabled: isToday,//非当天的不能编辑
          controller: controllers[i],
//          autofocus: true,
//          focusNode: focusNode,
//        maxLength: 50,//此限制输入长度方式会在右下角有长度的提示
          inputFormatters: [LengthLimitingTextInputFormatter(50)],//限制输入长度50
          decoration: InputDecoration(
            hintText: " 明天要做点什么...",
            hintStyle: TextStyle(fontSize: 12),
          ),
        )),
        Container(
          //只有当天的最后一项才有添加按钮
          child: (i == controllers.length - 1 && i != 4 && isToday == true) ? IconButton(icon: Icon(Icons.add), onPressed:(){ dispatch(punch_cardActionCreator.addTomorrowThingsAction()); }) : Container(),
          width: 50,
          height: 50,
        )
      ],
    );
    list.add(widget);
  }
  if (list.length == 0) {

    list.add(Container());
  }

  return list;
}
