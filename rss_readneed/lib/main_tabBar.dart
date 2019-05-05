import 'package:flutter/material.dart';
import 'package:rss_readneed/main_tabBar.dart';

class MainTabBar extends StatefulWidget {
  @override
  MainTabBarState createState() => new MainTabBarState();
}

class MainTabBarState extends State<MainTabBar> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('ReadNeed'),
        elevation: 2.0,
      ),
      bottomNavigationBar: _bottomTabBar(0),
      floatingActionButton: _bottomBook(false),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  //底部栏
  BottomNavigationBar _bottomTabBar (int selectedIndex) {

    return BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (int index){

        },
        items: [
          BottomNavigationBarItem(
              icon: SizedBox.fromSize(
                size: Size(30, 30),
                child: Image.asset("images_assets/zhifeiji.png",
                  color: Theme.of(context).primaryColor,
                  colorBlendMode: BlendMode.srcIn,
                ),
              ),
              title: Text("推荐")
          ),
          BottomNavigationBarItem(icon: SizedBox(width: 30,height: 30,), title: Text("阅必读")),
          BottomNavigationBarItem(icon: SizedBox.fromSize(size: Size(30, 30),child: Image.asset("images_assets/ren.png"),),title: Text("我的")),
        ]
    );
  }

  //底部居中icon
  FloatingActionButton _bottomBook (bool isCurrentShow){

    return FloatingActionButton(
      backgroundColor: Colors.white,
      elevation: 4.0,
      onPressed: (){},
      child: Center(
        child: SizedBox(
          width: 36,
          height: 36,
          child: Image.asset(
            isCurrentShow ? "images_assets/book104.png" : "images_assets/book116.png",
            color: Theme.of(context).primaryColor,
            colorBlendMode: BlendMode.srcIn,//混合模式，color覆盖着色
          ),
        ),
      ),
    );
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(MainTabBar oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}