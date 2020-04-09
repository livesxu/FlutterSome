import 'package:flutter/material.dart';
import '../public.dart';
import 'dart:io';

import '../common/photo_common.dart';

import './setting.dart';


class Person extends StatefulWidget {

  ScrollController controller = new ScrollController();

  @override
  PersonState createState() => new PersonState();
}

class PersonState extends State<Person> with AutomaticKeepAliveClientMixin,Login {

  Widget _headerImg (String link) {

    Widget childWidget = ImageCommon.withUrl(Account.share.headImg,"images_assets/icon.png", () => this.judgeLogin(context, ()=> _headerTouchAction()));
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

    String img_url = await Photo.chooseAndUploadImage(context,'header_img');

    if (img_url == null) {

      return ;
    }

    ResuestResult result = await RequestCommon.Put('/login', {'phone':Account.share.phone,"headImg":img_url});

    if (result.success) {

      Account.share.headImg = img_url;
      Account.writeInfo();
      setState(() {

      });
    } else {

      Toast.show(context, '更新失败');
    }
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
            _headerImg(Account.share.headImg),
            SizedBox(width: 10,),
            Text(Account.share.nick??"昵称",style: TextStyle(fontSize: 16),),
          ],
        ),
      ),
    );
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
        SliverList(
            delegate: SliverChildListDelegate(
                <Widget>[
                  ListTile(
                    leading: Icon(Icons.create),
                    title: Text('创建栏目',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                    subtitle: Text('拥有自己的栏目并从中获取奖励'),
                    onTap: (){ AppNavigator.push(context, AppNavigator.routePage('rssAdd')); },
                  ),
                  ListTile(
                    leading: Icon(Icons.touch_app),
                    title: Text('我的栏目',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                    subtitle: Text('管理栏目,让内容更加丰富'),
                    onTap: (){  },
                  ),
                  ListTile(
                    leading: Icon(Icons.show_chart),
                    title: Text('栏目奖励',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                    subtitle: Text('收益一目了然'),
                  ),
                  ListTile(
                    leading: Icon(Icons.assistant_photo),
                    title: Text('发布需求',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                    subtitle: Text('需要订阅某项内容却未提供'),
                  ),
                  ListTile(
                    leading: Icon(Icons.settings_input_antenna),
                    title: Text('处理需求',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                    subtitle: Text('帮助别人订阅内容获取奖励'),
                  ),
                ]
            )
        )
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