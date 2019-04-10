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
      body: Checkbox(
          value: ischeck,
          checkColor: Colors.blue,
          activeColor: Colors.red,
          onChanged: (value){

            setState(() {

              ischeck = value;
            });
          }
      ),
    );;
  }
}
