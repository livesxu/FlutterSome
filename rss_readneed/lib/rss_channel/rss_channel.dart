import 'package:flutter/material.dart';
import 'package:rss_readneed/rss_recommend/recommendModel.dart';

import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'dart:convert';

import 'package:rss_readneed/rss_channel/rss_web.dart';

import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';

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

  bool _isLoading = true;

  //布局数据
  Future<bool> layoutDatas () async {

    http.Response response = await http.get(widget.model.rssUrl);

    //将xml转换成json
    Xml2Json xmlTransformer = Xml2Json();

    String xmlString = response.body;

    xmlTransformer.parse(xmlString);

    String jsonString = xmlTransformer.toBadgerfish();

    Map mapDatas = json.decode(jsonString);

    Iterable mapKeys = mapDatas.keys;
    //当只有一个元素时假定xml2json时将最外层包了一层
    if (mapKeys.length == 1) {

      mapDatas = mapDatas[mapKeys.first];
    }
    //如果没有则取默认channel.item
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

    //channel 没有内容集合
    if (datasArray.length == 0) {

      //弹出底部操作提示栏 -使用方式Scaffold.of(context).showSnackBar
      Scaffold.of(context).showSnackBar(

          SnackBar(content: Text("无内容数据集合,请核查"),action: SnackBarAction(label: "OK", onPressed: (){}),)
      );

      return false;
    }

    //channel 没有映射关系 return
    if (widget.model.rssChannelDicData == null) {

      //弹出底部操作提示栏 -使用方式Scaffold.of(context).showSnackBar
      Scaffold.of(context).showSnackBar(

          SnackBar(content: Text("内容数据映射错误,请核查"),action: SnackBarAction(label: "OK", onPressed: (){}),)
      );

      return false;
    }
    //取映射关系
    String channelDicString = json.encode(widget.model.rssChannelDicData);

    Map channelDic = json.decode(channelDicString);

    String descriptionMapValue = channelDic["descriptionMap"];
    List<String> descriptionMapList = descriptionMapValue.contains(".") ? descriptionMapValue.split(".") : null;

    String imageValue = channelDic["image"];
    List<String> imageList = imageValue.contains(".") ? imageValue.split(".") : null;

    String linkValue = channelDic["link"];
    List<String> linkList = linkValue.contains(".") ? linkValue.split(".") : null;

    String pubDateValue = channelDic["pubDate"];
    List<String> pubDateList = pubDateValue.contains(".") ? pubDateValue.split(".") : null;

    String titleValue = channelDic["title"];
    List<String> titleList = titleValue.contains(".") ? titleValue.split(".") : null;


    List<ShowChannelModel> datas = datasArray.map((value){

      print(value);

      String imageShowTemp = imageList != null ? value[imageList[0]][imageList[1]].toString() : value[imageValue].toString();

      //如果没有图片,去内容中的第一张图示例展示
      if (imageShowTemp == null || imageShowTemp.length == 0 || imageShowTemp == "null") {

        RegExp exp = RegExp(r'http([^;\">]*?(jpg|jpeg|gif|png))');
        Iterable<Match> matches = exp.allMatches(value.toString());

        if (matches.length > 0) {

          Match m = matches.first;
          String match = m.group(0);

          imageShowTemp = match;

        } else {

          imageShowTemp = null;
        }
      }

      return ShowChannelModel(
        descriptionMap: descriptionMapList != null ? value[descriptionMapList[0]][descriptionMapList[1]].toString() : value[descriptionMapValue].toString(),
        image: imageShowTemp,
        link: linkList != null ? value[linkList[0]][linkList[1]].toString() : value[linkValue].toString(),
        pubDate: pubDateList != null ? value[pubDateList[0]][pubDateList[1]].toString() : value[pubDateValue].toString(),
        title: titleList != null ? value[titleList[0]][titleList[1]].toString() : value[titleValue].toString(),
      );

    }).toList();

    _data = datas;

    return true;
  }

  Widget _loadingView () {

    return Center(child: Loading(indicator: BallSpinFadeLoaderIndicator()),);
  }

  Widget _layoutViews () {

    return ListView(children: _data.map((ShowChannelModel model){
      return Container(
        padding: EdgeInsets.all(8),
        child: InkWell(
          child: Card(
            child: Column(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(4),topRight: Radius.circular(4)),
                  child: (model.image != null) ? Image.network(model.image,) : Container(),
                ),
                ListTile(
                  title: Text(model.title),
                  subtitle: Text(model.pubDate),
                )
              ],
            ),
          ),
          onTap: (){

            print(model.link);
            //跳转web
            Navigator.of(context).push(MaterialPageRoute(builder: (_){

              return WebView(urlString: model.link,urlTitle: model.title,);
            }));
          },
        )
      );
    }).toList(),);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.model.rsstitle),
      ),
      body: _isLoading ? _loadingView() : _layoutViews(),
    );
  }
  @override
  void initState() {
    super.initState();

    Future<bool> isFutureDatas = layoutDatas();

    if (isFutureDatas != null) {

      isFutureDatas.then((bool isGetDatas){

        setState(() {
          _isLoading = false;
        });

      });
    }
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