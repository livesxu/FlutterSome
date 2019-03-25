import 'package:flutter/material.dart';
import 'package:test_app/Home/Person.dart';
import 'package:test_app/Home/DrawerDemo.dart';
import 'package:test_app/Home/TabBarDemo.dart';
import 'package:test_app/Home/AppBarDemo.dart';
import 'package:test_app/Home/BottomNaviBarDemo.dart';

class HomeViewController extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeViewControllerState();
  }
}

class HomeViewControllerState extends State<HomeViewController> {

  int _bottomNaviIndex = 0;
  @override

  Widget build(BuildContext context) {

    // TODO: implement build
    return DefaultTabController(length: 3, child: Scaffold(
      appBar: HomeAppBar(),
      body: HomeTabContents(),
      drawer: HomeDrawer(),

      endDrawer: HomeEndDrawer(),

      bottomNavigationBar: BottomBar(_bottomNaviIndex,(int index){

        setState(() {

          _bottomNaviIndex = index;
        });
      }),
    ));
  }
}






