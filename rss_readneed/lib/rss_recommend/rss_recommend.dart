import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';//包含json.dart

import '../public.dart';
import '../Home/model.dart';
import '../Info/page.dart';

class Recommend extends StatefulWidget {
  @override
  RecommendState createState() => new RecommendState();
}

class RecommendState extends State<Recommend> {

  List<InfoModel> _datas = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppbarCommon(
        ctx: context,
        titleString: 'ReadNeed',
        actions: <Widget>[
          FlatButton(
            onPressed: (){
              AppNavigator.pushRoute(context, "rssAdd");
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 32,
            ),
            padding: EdgeInsets.only(left: 20),
            splashColor: Color.fromARGB(0, 0, 0, 0),//将透明度为0，无点击效果
            highlightColor: Color.fromARGB(0, 0, 0, 0),
          )
        ],
      ),
      body: Container(
        child: ListView(
          children: _datas.map((infoModel) => ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: Container(
                width: 40,
                height: 40,
                color: Colors.white,
                child: ImageCommon.withUrl(infoModel.infoImage, "images_assets/icon.png", null),
              ),
            ),
            title: Text(infoModel.infoName),
            subtitle: Text(infoModel.infoIntroduce),
            onTap: (){
              AppNavigator.push(context, infoPage().buildPage({"info":infoModel}));
            }
          )
          ).toList(),
        ),
      ),
    );
  }
  @override
  void initState() {
    super.initState();

    _datas = someFeedInfos.map((obj) => InfoModel.fromJson(obj)).toList();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(Recommend oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}