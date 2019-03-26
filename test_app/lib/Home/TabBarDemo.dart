import 'package:flutter/material.dart';
import 'package:test_app/Home/BasicTextDemo.dart';

Widget HomeTabContents (){

  return TabBarView(children: <Widget>[
//    Center(child: Text("New"),),
    BasicTextDemo(),
    Center(child: Text("Dvr"),),
    Center(child: Text("Pin"),),
  ]);
}

PreferredSizeWidget TabBarTitles (){

  return TabBar(indicatorWeight: 2,indicatorSize: TabBarIndicatorSize.label,indicatorColor: Colors.red,unselectedLabelColor: Colors.green,labelColor: Colors.red,tabs: <Widget>[
    Row(children: <Widget>[Text("New"),IconButton(icon: Icon(Icons.fiber_new), onPressed: null)],),
    Row(children: <Widget>[Text("Dvr",),IconButton(icon: Icon(Icons.fiber_dvr), onPressed: null)],),
    Row(children: <Widget>[Text("Pin"),IconButton(icon: Icon(Icons.fiber_pin), onPressed: null),],),

  ]);
}