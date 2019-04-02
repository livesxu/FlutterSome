import 'package:flutter/material.dart';
import 'package:test_app/Mine/TextFieldDemo.dart';

class MineViewController extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Mine"),
      ),
//      body: Theme(data: Theme.of(context).copyWith(primaryColor: Colors.blue), child: TextFieldDemo()),
      body: Theme(data: ThemeData(primaryColor: Colors.blue), child: TextFieldDemo()),
    );
  }
}