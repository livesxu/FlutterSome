import 'package:flutter/material.dart';

//typedef ValueChanged<T> = void Function(T value);//定义函数样式
Widget BottomBar (int changeIndex,ValueChanged<int> tapAction){

  return BottomNavigationBar(items: [

    BottomNavigationBarItem(icon: Icon(Icons.gps_fixed),title: Text("Fix")),
    BottomNavigationBarItem(icon: Icon(Icons.gps_not_fixed),title: Text("NoFix")),
    BottomNavigationBarItem(icon: Icon(Icons.gps_off),title: Text("GpsOff")),
    BottomNavigationBarItem(icon: Icon(Icons.call_missed_outgoing),title: Text("Out")),
  ],
    type: BottomNavigationBarType.fixed,//当数量达到4时类型会变化，需设置
    currentIndex: changeIndex,
    onTap: tapAction,
  );
}