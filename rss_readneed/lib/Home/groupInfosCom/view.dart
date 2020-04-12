import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import '../../rss_channel/rss_web.dart';
import '../../public.dart';

Widget buildView(String state, Dispatch dispatch, ViewService viewService) {

  return InkWell(
    child: Container(height: 30,child: Text(state),),
    onTap: ()=> AppNavigator.push(viewService.context, CommonWebView(urlString: state,urlTitle: state,)),
  );
}
