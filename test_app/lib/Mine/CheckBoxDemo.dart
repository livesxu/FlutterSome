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
    return SliderDemoExample();
  }
}

class SliderDemoExample extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SliderDemoExampleState();
  }
}

class SliderDemoExampleState extends State<SliderDemoExample> {

  double sliderNumber = 0.0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("SliderDemo"),),
      body: Slider(
          value: sliderNumber,
          label: "$sliderNumber",//弹出label显示值
          divisions: 10, //分割份数
          onChanged: (value){

            setState(() {
              sliderNumber = value;
            }
        );
      }),
    );
  }
}

//Switch
class SwitchDemoExample extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SwitchDemoExampleState();
  }
}

class SwitchDemoExampleState extends State<SwitchDemoExample> {

  bool isSwitch = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("SwitchDemo"),),
//      body: Switch(value: isSwitch, onChanged: (value){
//
//        setState(() {
//          isSwitch = value;
//        });
//      }),
      body: SwitchListTile(value: isSwitch, onChanged: (value){
        
        setState(() {
          isSwitch = value;
        });
      }),
    );
  }
}



//单选框 - 互斥
class RadioDemoExample extends StatefulWidget {

  @override

  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RadioDemoExampleState();
  }
}

class RadioDemoExampleState extends State<RadioDemoExample> {

  int groupValue;//选定的那个值，当与value值相同时选中效果

  void _changeAction (value){

    setState(() {
      groupValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("RadioDemo"),),
      body: Column(
        children: <Widget>[
//          Radio(value: 1, groupValue: groupValue, onChanged:_changeAction),
//          Radio(value: 2, groupValue: groupValue, onChanged:_changeAction),
//          Radio(value: 3, groupValue: groupValue, onChanged:_changeAction),

          RadioListTile(value: 1, groupValue: groupValue, onChanged: _changeAction,title: Text("1"),subtitle: Text("01"),selected: groupValue==1,),
          RadioListTile(value: 2, groupValue: groupValue, onChanged: _changeAction,title: Text("2"),subtitle: Text("02"),),
          RadioListTile(value: 3, groupValue: groupValue, onChanged: _changeAction,title: Text("3"),subtitle: Text("03"),),
        ],
      )
    );
  }
}


//复选框
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
