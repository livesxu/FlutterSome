import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';//包含json.dart

import 'package:rss_readneed/rss_recommend/recommendModel.dart';
import 'package:rss_readneed/rss_channel/rss_channel.dart';

class Recommend extends StatefulWidget {
  @override
  RecommendState createState() => new RecommendState();
}

class RecommendState extends State<Recommend> {

  List<RecommendModel> _datas = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: _datas.map((model) => ListTile(
          title:Text(
            model.rsstitle,
            style: TextStyle(fontSize: 14),
          ),
          leading: Icon(Icons.rss_feed),
          onTap: (){

            //跳转channel
            Navigator.of(context).push(MaterialPageRoute(builder: (_){

              return Channel(model: model,);
            }));
          },
        )
        ).toList(),
      ),
    );
  }
  @override
  void initState() {
    super.initState();

    Future<String> jsonString = DefaultAssetBundle.of(context).loadString("lib/rss_recommend/rss_recommend.json");

    jsonString.then((String value){

      List recommend = json.decode(value);

      setState(() {

        _datas = recommend.map((item) => RecommendModel.fromJson(item)).toList();
      });

    });
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