import 'package:flutter/material.dart';
import 'package:rss_readneed/rss_recommend/recommendModel.dart';

import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'dart:convert';

class Channel extends StatefulWidget {

  final RecommendModel model;

  Channel({
    this.model,

  });

  @override
  ChannelState createState() => new ChannelState();
}

class ChannelState extends State<Channel> {

  List<ShowChannelModel> _data = [];

  //布局数据
  layoutDatas () async {

    http.Response response = await http.get(widget.model.rssUrl);

    //将xml转换成json
    Xml2Json xmlTransformer = Xml2Json();

    String xmlString = response.body;

    xmlTransformer.parse(xmlString);

    String jsonString = xmlTransformer.toBadgerfish();

    Map mapDatas = json.decode(jsonString);

    Iterable mapKeys = mapDatas.keys;

    if (mapKeys.length == 1) {

      mapDatas = mapDatas[mapKeys.first];
    }
    //
    String rssPath = widget.model.rssDatasPath ?? "channel.item";

    List<String> rssPathArray = rssPath.split(".");

    //目标数据集合
    List datasArray = [];

    for (int i = 0;i< rssPathArray.length;i ++) {

      String path = rssPathArray[i];

      if (i == rssPathArray.length - 1) {

        datasArray = mapDatas[path];

      } else {

        mapDatas = mapDatas[path];
      }
    }

    //channel 没有映射关系 return
    if (widget.model.rssChannelDicData == null) {

      //弹出底部操作提示栏 -使用方式Scaffold.of(context).showSnackBar
      Scaffold.of(context).showSnackBar(

          SnackBar(content: Text("内容数据映射错误,请核查"),action: SnackBarAction(label: "OK", onPressed: (){}),)
      );

      return ;
    }
    //取映射关系
    Map dic1;
    Map dic2;

    String channelDicString = json.encode(widget.model.rssChannelDicData);

    Map channelDic = json.decode(channelDicString);

    for (String keyString in channelDic.keys) {

      String valueString = channelDic[keyString];
      if (valueString.contains(".")) {

        List<String> valueArray = valueString.split(".");

        dic2.addAll({keyString:valueArray});
      } else {

        if (valueString != null && valueString.length != 0) {

          dic1.addAll({keyString:valueString});
        }
      }
    }

    _data = datasArray.map((value){

      dic2

      return ShowChannelModel(
        descriptionMap: dic2.keys.contains("descriptionMap") ? value[(dic2["descriptionMap"])] : value[dic1["descriptionMap"]],

      );

    }).toList();

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.model.rsstitle),
      ),
    );
  }
  @override
  void initState() {
    super.initState();

    layoutDatas();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(Channel oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}

class ShowChannelModel {

  final String descriptionMap;
  final String image;
  final String link;
  final String pubDate;
  final String title;

  ShowChannelModel({
    this.descriptionMap,
    this.image,
    this.link,
    this.pubDate,
    this.title,

  });

  ShowChannelModel.fromJson(Map json)
      :   descriptionMap = json["descriptionMap"],
          image = json["image"],
          link = json["link"],
          pubDate = json["pubDate"],
          title = json["title"];

}