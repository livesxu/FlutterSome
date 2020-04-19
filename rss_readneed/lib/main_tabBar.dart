import 'package:flutter/material.dart';
import 'package:rss_readneed/public.dart';

import 'package:rss_readneed/rss_collect/rss_collect.dart';
import 'package:rss_readneed/rss_setting/rss_person.dart';

class MainTabBar extends StatefulWidget {
  @override
  MainTabBarState createState() => new MainTabBarState();
}

class MainTabBarState extends State<MainTabBar> {

  static int _currentIndex = 0;

  static PageController pageController = PageController(initialPage: _currentIndex);

  static TabController tabController = TabController(length: 3, vsync: ScrollableState());

  PageView _pageView;

  TabBarView _tabBarView;

  //命中
  void selectedIndex (int index) {

    setState(() {

      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    Consts.screenWidth = MediaQuery.of(context).size.width;
    Consts.screenHeight = MediaQuery.of(context).size.height;
    Consts.tabBar = context;

    return new Scaffold(
      bottomNavigationBar: _bottomTabBar(_currentIndex),
      floatingActionButton: _bottomBook(_currentIndex == 1),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body:_pageView,
    );
  }


  //底部栏
  BottomNavigationBar _bottomTabBar (int selectedIndex) {

    return BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (int index){

          setState(() {
            _currentIndex = index;

            if (_pageView != null) {

              pageController.jumpToPage(_currentIndex);
            }

            if (_tabBarView != null) {

              tabController.animateTo(_currentIndex);
            }

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
          if (_pageView != null) {

            pageController.jumpToPage(_currentIndex);
          }
          if (_tabBarView != null) {

            tabController.animateTo(_currentIndex);
          }
        });
      },
      child: Center(
        child: SizedBox(
          width: 36,
          height: 36,
          child: Image.asset(
            isCurrentShow ? "images_assets/book104.png" : "images_assets/book116.png",
            color:isCurrentShow ? Theme.of(context).primaryColor : Colors.grey[400],
            colorBlendMode: BlendMode.srcIn,//混合模式，color覆盖着色
          ),
        ),
      ),
    );
  }
  
  @override
  void initState() {
    super.initState();

    //使用pageView实现
    _pageView = PageView(
      children: <Widget>[
        AppNavigator.routePage('home'),
        Collect(),
        Person(),
      ],
      controller: pageController,
      onPageChanged: selectedIndex,
      physics: NeverScrollableScrollPhysics(),//禁止滑动
    );

//    //使用tabBarView实现
//    _tabBarView = TabBarView(
//        children: <Widget>[
//          AppNavigator.routePage('home'),
//          Collect(),
//          Person(),
//        ],
//        controller: tabController,
//    );
//    tabController.addListener((){
//
//      setState(() {
//
//        _currentIndex = tabController.index;
//
//      });
//    });
  }

  @override
  void dispose() {
    super.dispose();

    //销毁
    pageController.dispose();
    tabController.dispose();
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