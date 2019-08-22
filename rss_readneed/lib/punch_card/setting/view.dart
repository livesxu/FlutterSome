import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

import 'package:rss_readneed/public.dart';

Widget buildView(punch_card_settingState state, Dispatch dispatch, ViewService viewService) {

  //左title右time视图
  Widget leftTitleRightTimeWidget(String title,String time,String key) {

    return InkWell(
      child: Container(
        padding: EdgeInsets.all(6),
        height: 32,
        child: Row(
          children: <Widget>[
            Text(title,
              style: TextStyle(color: Colors.black87,fontSize: 16,fontWeight: FontWeight.w700),
            ),
            SizedBox(width: 10,),
            Text(time,
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.combine([TextDecoration.underline])
              ),
            ),
          ],
        ),
      ),
      onTap: (){ dispatch(punch_card_settingActionCreator.changeSettingTime(key)); },
    );
  }

  return Scaffold(
    appBar: AppbarCommon(ctx: viewService.context,titleString: "月度规划",isNeedBack: true,),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        //月份展示
        Container(
          child: InkWell(
            child: Container(
              child: Text(state.monthTime,
                style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w900),
              ),
              decoration: BoxDecoration(color: Colors.red,borderRadius: BorderRadius.all(Radius.circular(4))),
              padding: EdgeInsets.only(top: 3,bottom: 3,left: 6,right: 6),
              margin: EdgeInsets.all(10),
            ),
            onTap: (){ dispatch(punch_card_settingActionCreator.chooseMonthAction()); },
          ),
        ),
        //基础设置信息
        Card(
          child: Column(
            children: <Widget>[
              SizedBox(height: 6,),
              leftTitleRightTimeWidget("上班时间", state.model.startTime.substring(10),"startTime"),
              leftTitleRightTimeWidget("下班时间", state.model.finishTime.substring(10),"finishTime"),
              leftTitleRightTimeWidget("通宵截止", state.model.finishNextDayTime.substring(10),"finishNextDayTime"),
              Container(
                padding: EdgeInsets.all(6),
                height: 32,
                child: Row(
                  children: <Widget>[
                    Text("周六统计",
                      style: TextStyle(color: Colors.black87,fontSize: 16,fontWeight: FontWeight.w700),
                    ),
                    SizedBox(width: 10,),
                    Checkbox(value: state.model.inCountSaturday, onChanged: (bool isCheck){ dispatch( punch_card_settingActionCreator.changeSettingCheck("inCountSaturday") ); }),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(6),
                height: 32,
                child: Row(
                  children: <Widget>[
                    Text("周日统计",
                      style: TextStyle(color: Colors.black87,fontSize: 16,fontWeight: FontWeight.w700),
                    ),
                    SizedBox(width: 10,),
                    Checkbox(value: state.model.inCountSunday, onChanged: (bool isCheck){ dispatch( punch_card_settingActionCreator.changeSettingCheck("inCountSunday") ); }),
                  ],
                ),
              ),
              SizedBox(height: 6,),
            ],
          ),
        ),
        //月度列表
        Container(
          child: Row(
            children: <Widget>[
              InkWell(
                child: Container(
                  child: Text("月度统计",
                    style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w700),
                  ),
                  decoration: BoxDecoration(color: Colors.red,borderRadius: BorderRadius.all(Radius.circular(4))),
                  padding: EdgeInsets.only(top: 3,bottom: 3,left: 6,right: 6),
                  margin: EdgeInsets.all(10),
                ),
                onTap: (){ dispatch(punch_card_settingActionCreator.jumpListAction());/*跳转列表*/ },
              ),
              IconButton(icon: Icon(Icons.refresh,color: Colors.blue,), onPressed: (){}),
            ],
          )
        ),
        Card(
          child: Column(
            children: <Widget>[
              SizedBox(height: 6,),
              Container(
                padding: EdgeInsets.all(6),
                height: 32,
                child: Row(
                  children: <Widget>[
                    Text("加班时长",
                      style: TextStyle(color: Colors.black87,fontSize: 16,fontWeight: FontWeight.w700),
                    ),
                    SizedBox(width: 10,),
                    Text(state.totalShowTime),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(6),
                height: 32,
                child: Row(
                  children: <Widget>[
                    Text("下班时间",
                      style: TextStyle(color: Colors.black87,fontSize: 16,fontWeight: FontWeight.w700),
                    ),
                    SizedBox(width: 10,),
                    Text(state.alreadyfinishTime),
                  ],
                ),
              ),
              SizedBox(height: 6,),
            ],
          ),
        ),
        Card(
          child: (DateTime.now().toString().contains(state.model.monthTime))/*当月*/ ?
          Container(
            child: Container(
              padding: EdgeInsets.all(6),
              child: Row(
                children: <Widget>[
                  Text("计划下班时间",
                    style: TextStyle(color: Colors.black87,fontSize: 16,fontWeight: FontWeight.w700),
                  ),
                  FlatButton.icon(
                      onPressed: (){ dispatch(punch_card_settingActionCreator.planLeftFinishTimeAction());},
                      icon: Icon(Icons.alarm,color: Colors.blue,),
                      label: Text(state.monthPlanTime == null ? "选择时间" : state.monthPlanTime,style: TextStyle(color: Colors.blue,fontSize: 18,fontWeight: FontWeight.w400),),
                  ),
                  SizedBox(width: 6,),
                  Container(
                    child: (state.leftDayPlanFinishTime == null) ? Container() :
                    RichText(
                      text: TextSpan(
                        text: "剩余计划下班  ",
                        style:TextStyle(color: Colors.black38,fontSize: 14,fontWeight: FontWeight.w600),
                        children: [TextSpan(
                          text: state.leftDayPlanFinishTime,
                          style: TextStyle(color: Colors.orange,fontSize: 24,fontWeight: FontWeight.w300),
                        )]
                      ),
                    ),
                  )
                ],
              ),
            ),
          ) :Container(),
        )
      ],
    ),
  );
}
