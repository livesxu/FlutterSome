import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import '../../rss_channel/rss_web.dart';
import '../../public.dart';

Widget buildView(Map<String,String> state, Dispatch dispatch, ViewService viewService) {

  return ListTile(
    leading: SizedBox(height: 40,width: 40,child: ClipRRect(
      child: ImageCommon.withUrl(state['image'] , "images_assets/icon.png", null),
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),),
    title: Text(state['name'],style: TextStyle(color: Colors.black87),),
    onTap: ()=> AppNavigator.push(viewService.context, CommonWebView(urlString: state['link'],urlTitle: state['name'],)),
  );
}
