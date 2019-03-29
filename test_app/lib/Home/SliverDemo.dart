import 'package:flutter/material.dart';
import 'package:test_app/Home/Person.dart';

class SliverDemo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SliverTwo();
  }
}


//grid  网格
class SliverOne extends StatelessWidget {

  Widget SliverOneBuilder (BuildContext context,int index) {

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Image.network(Persons[index].body,fit: BoxFit.cover),

      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverSafeArea(minimum: EdgeInsets.all(10),sliver:
          SliverGrid(
              delegate: SliverChildBuilderDelegate(
                SliverOneBuilder,
                childCount: Persons.length,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ))
          ),
        ],
      ),
    );
  }
}

//list 列表
class SliverTwo extends StatelessWidget {

  Widget SliverTwoBuilder (BuildContext context,int index) {

    return Padding(padding: EdgeInsets.only(bottom: 10),
      child: Material(
        borderRadius: BorderRadius.circular(20),
        elevation: 6,
        shadowColor: Colors.cyan,
        child: Container(child: Image.network(Persons[index].body,fit: BoxFit.cover),),//为何非圆角？？
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverSafeArea(minimum: EdgeInsets.all(10),sliver:
          SliverList(
              delegate: SliverChildBuilderDelegate(
                SliverTwoBuilder,
                childCount: Persons.length,
              ),
          )),
        ],
      ),
    );
  }
}