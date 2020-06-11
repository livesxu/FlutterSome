import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:rss_readneed/common/image_common.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(userComState state, Dispatch dispatch, ViewService viewService) {
  
  Widget child;
  if (state.accountModel == null) {
    
    child = FlatButton(
      child: Text("未登录",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
      onPressed: (){
        dispatch(userComActionCreator.loginAction());
      }
    );
    
  } else {
    
    child = Row(
      children: <Widget>[
        SizedBox(height: 40,width: 40,child: ClipRRect(
          child: ImageCommon.withUrl(state.accountModel.profile_image_url , null, null),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),),
        SizedBox(width: 10,),
        Text(state.accountModel.screen_name == null ? "" : state.accountModel.screen_name),
      ],
    );
  }

  if (state.isPageHeader) {

    return Card(
      child: Container(
          height: 60,
          child: Padding(
              child: child,
              padding: EdgeInsets.all(10)
          )
      ),
    );
  } else {

    return Container(
        height: 60,
        child: Padding(
            child: child,
            padding: EdgeInsets.all(10)
        )
    );
  }
}
