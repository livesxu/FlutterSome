import 'package:flutter/material.dart';
import 'package:test_app/Home/Person.dart';
import 'package:test_app/Home/HomeSubViewController.dart';

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
//          SliverPadding//用来设置边距
          SliverSafeArea(minimum: EdgeInsets.all(10),//可设置边距
              sliver:
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

    return Stack(children: <Widget>[
      Padding(padding: EdgeInsets.only(bottom: 10),
    child: ClipRRect(//圆角
    borderRadius: BorderRadius.circular(20),
    child: Container(child: Image.network(Persons[index].body,fit: BoxFit.cover),),
    ),
    ),
      Positioned.fill(child: Material(
        color: Colors.transparent,
        child: InkWell(
//          splashColor: Colors.white,
//          highlightColor: Colors.white,
//          radius: 100,
          onTap: (){
//            Navigator.pushNamed(context, "/routerNameToNext");
            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => HomeSubHomeViewController(title: Persons[index].title,)));
          },
        ),
      ))
    ],);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,//在页面上不消失
//            floating: true,//跟随滚动出现（立刻）
//            title: Text("Sliver Title"),
            expandedHeight: 100,
            flexibleSpace:FlexibleSpaceBar(title: Text("ppLine Show".toUpperCase()),background: Image.network(Persons[1].body,fit: BoxFit.cover,),),
//          flexibleSpace: FlexibleSpaceBarSettings(maxExtent: 100,minExtent:0,currentExtent: 100,toolbarOpacity: .3,child: FlexibleSpaceBar(centerTitle: true,title: Text("ppLine Show".toUpperCase()),background: Image.network(Persons[0].body,fit: BoxFit.cover,),),),
          ),
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