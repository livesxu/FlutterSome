import 'package:flutter/material.dart';
import 'package:test_app/Home/TabBarDemo.dart';

PreferredSizeWidget HomeAppBar () {

  return AppBar(
    title: Text("Home",style: TextStyle(fontSize: 20),textAlign: TextAlign.center,),
    centerTitle: true,
    leading: Icon(Icons.menu,size: 36,),

    actions: <Widget>[

      Icon(Icons.search,size: 30,),
      SizedBox(width: 20,),
      Icon(Icons.refresh,size: 30,color: Colors.white,)
    ],
    bottom: TabBarTitles(),
  );
}