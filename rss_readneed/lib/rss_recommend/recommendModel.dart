import 'dart:convert';

class RecommendModel {

  final ChannelModel rssChannelDicData;
  final String rssDatasPath;
  final String rssDesc;
  final String rssImg;
  final String rssStatus;
  final String rsstitle;
  final String rssUrl;

  RecommendModel({

    this.rssChannelDicData,
    this.rssDatasPath,
    this.rssDesc,
    this.rssImg,
    this.rssStatus,
    this.rsstitle,
    this.rssUrl,
  });

  //实例对象属性赋值
  RecommendModel.fromJson(Map json)
    :   rssChannelDicData = ChannelModel.fromJson(json["rssChannelDicData"]),
        rssDatasPath = json["rssDatasPath"],
        rssDesc = json["rssDesc"],
        rssImg = json["rssImg"],
        rssStatus = json["rssStatus"],
        rsstitle = json["rsstitle"],
        rssUrl = json["rssUrl"];

//encode会自动执行model 里面的toJson
  Map toJson() => {

    "rssChannelDicData":json.encode(rssChannelDicData),
    "rssDatasPath":rssDatasPath,
    "rssDesc":rssDesc,
    "rssImg":rssImg,
    "rssStatus":rssStatus,
    "rsstitle":rsstitle,
    "rssUrl":rssUrl,
  };


}

class ChannelModel {

  final String descriptionMap;
  final String image;
  final String link;
  final String pubDate;
  final String title;

  ChannelModel({
    this.descriptionMap,
    this.image,
    this.link,
    this.pubDate,
    this.title,

  });

  ChannelModel.fromJson(Map json)
    :   descriptionMap = json["descriptionMap"],
        image = json["image"],
        link = json["link"],
        pubDate = json["pubDate"],
        title = json["title"];


  Map toJson() => {

    "descriptionMap":descriptionMap,
    "image":image,
    "link":link,
    "pubDate":pubDate,
    "title":title,
  };
}

//{
//"rssChannelDicData" :     {
//"descriptionMap" : "description",
//"image" : "",
//"link" : "link",
//"pubDate" : "pubDate",
//"title" : "title"
//},
//"rssDatasPath" : "channel.item",
//"rssDesc" : "",
//"rssImg" : "",
//"rssStatus" : "",
//"rsstitle" : "知乎每日精选",
//"rssUrl" : "Http://www.zhihu.com/rss"
//}