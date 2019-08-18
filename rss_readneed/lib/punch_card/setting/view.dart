import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

import 'package:rss_readneed/public.dart';

Widget buildView(punch_card_settingState state, Dispatch dispatch, ViewService viewService) {
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
            onTap: (){  },
          ),
        ),

      ],
    ),
  );
}
