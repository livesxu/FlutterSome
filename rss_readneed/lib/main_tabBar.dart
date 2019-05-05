import 'package:flutter/material.dart';
import 'package:rss_readneed/appbar_gradient.dart';

class MainTabBar extends StatefulWidget {
  @override
  MainTabBarState createState() => new MainTabBarState();
}

class MainTabBarState extends State<MainTabBar> {

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new GradientAppBar(
        title: new Text('ReadNeed'),
        shadowColor: Theme.of(context).primaryColor,
        gradient: RadialGradient(//更改为圆扩散
            colors: [Theme.of(context).primaryColorLight,Theme.of(context).primaryColorDark],
            center: Alignment.topLeft,
            radius: 4),
      ),
      bottomNavigationBar: _bottomTabBar(_currentIndex),
      floatingActionButton: _bottomBook(_currentIndex == 1),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  //底部栏
  BottomNavigationBar _bottomTabBar (int selectedIndex) {

    return BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (int index){
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: SizedBox.fromSize(
                size: Size(30, 30),
                child: Image.asset("images_assets/zhifeiji.png",
                  color: _currentIndex == 0 ? Theme.of(context).primaryColor : Colors.grey[400],
                  colorBlendMode: BlendMode.srcIn,
                ),
              ),
              title: Text("推荐")
          ),
          BottomNavigationBarItem(icon: SizedBox(width: 30,height: 30,), title: Text("阅必读")),
          BottomNavigationBarItem(
              icon: SizedBox.fromSize(
                size: Size(30, 30),
                child: Image.asset("images_assets/ren.png",
                  color: _currentIndex == 2 ? Theme.of(context).primaryColor : Colors.grey[400],
                  colorBlendMode: BlendMode.srcIn,
                ),
              ),
              title: Text("我的")),
        ]
    );
  }

  //底部居中icon
  FloatingActionButton _bottomBook (bool isCurrentShow){

    return FloatingActionButton(
      backgroundColor: Colors.white,
      elevation: 4.0,
      onPressed: (){
        setState(() {
          _currentIndex = 1;
        });
      },
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