import 'package:flutter/material.dart';
import '../public.dart';
import 'dart:io';


class Setting extends StatefulWidget {

  ScrollController controller = new ScrollController();

  @override
  SettingState createState() => new SettingState();
}

class SettingState extends State<Setting> with AutomaticKeepAliveClientMixin {

  PreferredSize _topBottom (){

    return PreferredSize(
        child:Row(
          children: <Widget>[
            Text('112233'),
            Text('223344'),
          ],
        ),
        preferredSize: Size(double.infinity, 100)
    );
  }

  Widget _headerImg (String link,File file) {

    Widget img_w = Image.asset("images_assets/ren.png");
    if (link != null) {

      img_w = Image.network(link);
    } else if (file != null) {

      img_w = Image.file(file);
    }

    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      child: Container(
        width: 40,
        height: 40,
        color: Colors.white,
        child: img_w,
      ),
    );
  }

  FlexibleSpaceBar _topSpace() {

    return FlexibleSpaceBar(
      background: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          Positioned(
            bottom: 80,
            child: Text('个人中心',textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600),),

          )
        ],
      ),
      titlePadding: EdgeInsets.only(left: 100,bottom: 10),
      title:Container(
        child: Row(
          children: <Widget>[
            _headerImg(null,null),
            SizedBox(width: 10,),
            Text('我的名字'),
          ],
        ),
      ),
    );
  }

  Widget _sliverItem (BuildContext ctx,int index) {

    return Text(index.toString());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomScrollView(
      controller:widget.controller,
      slivers: <Widget>[
        GradientSliverAppBar(
          shadowColor: Theme.of(context).primaryColor,
          gradient: RadialGradient(//更改为圆扩散
              colors: [Theme.of(context).primaryColorLight,Theme.of(context).primaryColorDark],
              center: Alignment.topLeft,
              radius: 4),
          floating:true,//跟随滑动展示头视图
          pinned: true,//在页面上不消失
          expandedHeight: 120,//扩展高度
          flexibleSpace: _topSpace(),
        ),
        SliverSafeArea(
            sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext ctx,int index) => _sliverItem(ctx, index),
                  childCount: 100
                )
            )
        ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widget.controller.addListener((){

    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(Setting oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}