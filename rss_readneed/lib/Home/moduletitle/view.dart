import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

Widget buildView(Map state, Dispatch dispatch, ViewService viewService) {

  bool isMore = state['more'];

  return ListTile(
    leading: Text(state['title'],style: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),),
    trailing: isMore ? Icon(Icons.navigate_next) : Container(width: 0,height: 0,),
    onTap: (){
      if (isMore) {
        //todo 如果可以展示更多，将根据module跳转到指定页面
        String module = state['module'];

      }
    },
  );
}
