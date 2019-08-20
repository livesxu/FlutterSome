import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

import 'package:rss_readneed/public.dart';
import 'package:rss_readneed/punch_card/punchCardModel.dart';

Widget buildView(punch_card_listState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: AppbarCommon(ctx: viewService.context,titleString: "月度列表",isNeedBack: true,),
    body: ListView.builder(
        itemCount: state.monthList.length,
        itemBuilder: (ctx,i){
          
          PunchCardModel model = state.monthList[i];

          int difHour = DateTime.parse(model.finishTime).difference(DateTime.parse(model.dateTime + state.model.finishTime.substring(10))).inHours;

          Color timeColor = Colors.black45;
          if (difHour <= 0) {//准点下班

            timeColor = Colors.black45;
          } else if (difHour <= 2) {//两小时，还可以

            timeColor = Colors.green;
          } else if (difHour <= 4) {//四小时，黄线

            timeColor = Colors.yellow;
          } else if (difHour <= 6) {//6小时，红线

            timeColor = Colors.red;
          } else {//超过6小时，死亡芭比粉~

            timeColor = Colors.pink;
          }

          return CheckboxListTile(
            value: model.inCount,
            onChanged: (incount){ /*更改是否统计*/},
            title: RichText(text: TextSpan(
              text: model.dateTime.substring(8,10) + "  ",//加上间隔
              style: TextStyle(color: Colors.black,fontSize: 24,fontWeight: FontWeight.w600),
              children: [
                  TextSpan(text:(model.finishTime.contains(model.dateTime) ? model.finishTime.substring(11,16) : model.finishTime),
                    style: TextStyle(color: timeColor,fontSize: 20,fontWeight: FontWeight.w300)
                  )
              ]
            )),
            subtitle: Text(model.workingThings),
          );
        }),
  );
}
