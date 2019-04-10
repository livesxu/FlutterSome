import 'package:flutter/material.dart';

class CheckBoxDemo extends StatefulWidget {

  @override

  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CheckBoxDemoState();
  }
}

class CheckBoxDemoState extends State<CheckBoxDemo> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CheckDemoExample();
  }
}

class CheckDemoExample extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CheckDemoExampleState();
  }
}

class CheckDemoExampleState extends State<CheckDemoExample> {

  bool ischeck = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("checkBoxDemo"),),
//      body: Checkbox(
//          value: ischeck,
//          checkColor: Colors.blue,
//          activeColor: Colors.red,
//          onChanged: (value){
//
//            setState(() {
//
//              ischeck = value;
//            });
//          }
//      ),
      body: CheckboxListTile(
          value: ischeck,
          title: Text("I am title"),
          subtitle: Text("i am subtitle"),
          controlAffinity: ListTileControlAffinity.leading,//排布样式
          secondary: Icon(Icons.fiber_smart_record),//可以添加一个小图标
          selected: ischeck,//title,subtitle和小图标是否使用激活状态的颜色
          onChanged: (value){
          setState(() {
            ischeck = value;
        });
      }),
    );;
  }
}
