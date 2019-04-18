import 'package:flutter/material.dart';

class StateDemo extends StatefulWidget {

  @override
  StateDemoState createState() => StateDemoState();
}

class StateDemoState extends State<StateDemo> {

  int _count = 0;

  void _pressedAction (){

    setState(() {
      _count ++;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("StateDemo"),),
      body: Center(
        child: CustomChipItem(_count, _pressedAction),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pressedAction,
        child: Icon(Icons.add),
      ),
    );
  }
}

class CustomChipItem extends StatelessWidget {

  int _count;

  VoidCallback _callback;

  CustomChipItem(this._count,this._callback);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ActionChip(
      label: Text("$_count"),
      onPressed: _callback,
    );
  }
}