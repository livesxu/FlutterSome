import 'package:flutter/material.dart';
import '../public.dart';
import 'dart:io';

import '../common/photo_common.dart';

import './setting.dart';


class Person extends StatefulWidget {

  ScrollController controller = new ScrollController();
  File headImgFile = null;

  @override
  PersonState createState() => new PersonState();
}

class PersonState extends State<Person> with AutomaticKeepAliveClientMixin,Login {

  Widget _headerImg (String link,File file) {

    Widget childWidget;
    if (file != null) {

      childWidget = ImageCommon.withFile(file,"images_assets/icon.png", () => this.judgeLogin(context, ()=> _headerTouchAction()));
    } else {

      childWidget = ImageCommon.withUrl(Account.share.headImg,"images_assets/icon.png", () => this.judgeLogin(context, ()=> _headerTouchAction()));
    }

    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      child: Container(
        width: 40,
        height: 40,
        color: Colors.white,
        child: childWidget,
      ),
    );
  }
  //点击头像
  _headerTouchAction () async {

    final option = await showModalBottomSheet(
      context: context,
      builder: (BuildContext ctx) => _bottomPhotoChoose(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight:Radius.circular(20))
      )
    );

    if (option == 'camera') {

      _showPhoto(PhotoSource.camera);
    } else if (option == 'gallery') {

      _showPhoto(PhotoSource.gallery);
    } else {

    }
  }

  //展示选择器
  Widget _bottomPhotoChoose(){
    return Container(
      height: 200,
      child: Column(children: <Widget>[
        InkWell(
          child: Container(
            height: 50,
            child: Text('相册',style: TextStyle(fontSize: 24,fontWeight: FontWeight.w600),),
          ),
          onTap: (){Navigator.of(context).pop("gallery");},
        ),
        InkWell(
          child: Container(
            height: 50,
            child: Text('相机',style: TextStyle(fontSize: 24,fontWeight: FontWeight.w600),),
          ),
          onTap: (){Navigator.of(context).pop("camera");},
        ),
        InkWell(
          child: Text('取消',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400,color: Colors.black38),),
          onTap: (){Navigator.of(context).pop("cancel");},
        )],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }

  //弹出选择图片or相机
  void _showPhoto(PhotoSource source){

    Photo.noti.stream.listen((info){
      if (info['rss_setting'] is File) {
        widget.headImgFile = info['rss_setting'];
        print(info);
        setState(() {

        });
      }
    });
    Photo.choose(source, "rss_setting");
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
            _headerImg(Account.share.headImg,widget.headImgFile),
            SizedBox(width: 10,),
            Text(Account.share.nick??"昵称",style: TextStyle(fontSize: 16),),
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
          actions: <Widget>[
            IconButton(icon: Icon(Icons.settings,color: Colors.white,), onPressed: () {
              //必要时刷新页面
               Navigator.push(context, MaterialPageRoute(builder: (_)=>Setting())).then((needRefresh){

                 if (needRefresh != null && needRefresh == true) {

                   setState(() {

                   });
                 }
               });
            })
          ],
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
  void didUpdateWidget(Person oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}