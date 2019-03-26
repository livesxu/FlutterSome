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


class BottomBarClass extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BottomBarClassState();
  }
}

class BottomBarClassState extends State<BottomBarClass> {

  int barIndex = 0;

  @override

  Widget build(BuildContext context) {
    // TODO: implement build
    return BottomNavigationBar(items: [

      BottomNavigationBarItem(icon: Icon(Icons.gps_fixed),title: Text("Fix")),
      BottomNavigationBarItem(icon: Icon(Icons.gps_not_fixed),title: Text("NoFix")),
      BottomNavigationBarItem(icon: Icon(Icons.gps_off),title: Text("GpsOff")),
      BottomNavigationBarItem(icon: Icon(Icons.call_missed_outgoing),title: Text("Out")),
    ],
      type: BottomNavigationBarType.fixed,//当数量达到4时类型会变化，需设置
      currentIndex: barIndex,
      onTap: (int index){

      setState(() {
        barIndex = index;
      });
      },
    );
  }
}