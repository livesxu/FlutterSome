class InfoModel {

  InfoModel({this.infoId});

  int infoId;
  String infoName;//名称
  String infoUrl;//链接
  String abInfoUrl;//绝对栏目链接 - 相比infourl更加准确，因为rss或者json内容的infourl是无法链接正式网页的
  String infoImage;//图片
  String infoIntroduce;//介绍

  //内容本地响应正则解析链路
  String topExp;//分栏一级正则解析式 - 获取内容集合
  String titleExpStart;//标题解析前标志字段
  String titleExpEnd;//标题解析后标志字段
  String contentExpStart;//内容解析前标志字段
  String contentExpEnd;//内容解析后标志字段
  String imageExpStart;//图片解析前标志字段
  String imageExpEnd;//图片解析后标志字段
  String linkExpStart;//链接解析前标志字段
  String linkExpEnd;//链接解析后标志字段

  InfoModel.fromJson(Map json)
      : infoId = json['infoId'],
        infoName = json['infoName'],
        infoUrl = json['infoUrl'],
        abInfoUrl = json['abInfoUrl'],
        infoImage = json['infoImage'],
        infoIntroduce = json['infoIntroduce'],
        topExp = json['topExp'],
        titleExpStart = json['titleExpStart'],
        titleExpEnd = json['titleExpEnd'],
        contentExpStart = json['contentExpStart'],
        contentExpEnd = json['contentExpEnd'],
        imageExpStart = json['imageExpStart'],
        imageExpEnd = json['imageExpEnd'],
        linkExpStart = json['linkExpStart'],
        linkExpEnd = json['linkExpEnd'];


  Map toJson() =>
      {
//        'infoId':infoId,//包装报文时由服务器生成infoId
        'infoName':infoName,
        'infoUrl':infoUrl,
        'abInfoUrl':abInfoUrl,
        'infoImage':infoImage,
        'infoIntroduce':infoIntroduce,
        'topExp':topExp,
        'titleExpStart':titleExpStart,
        'titleExpEnd':titleExpEnd,
        'contentExpStart':contentExpStart,
        'contentExpEnd':contentExpEnd,
        'imageExpStart':imageExpStart,
        'imageExpEnd':imageExpEnd,
        'linkExpStart':linkExpStart,
        'linkExpEnd':linkExpEnd,
      };
}

class ArticleModel {

  ArticleModel({this.articleId});

  int articleId;
  String articleTitle;
  String articleContent;
  String articleTime;
  String articleUrl;
  String articleImage;

  ArticleModel.fromJson(Map json)
    :   articleId = json['articleId'],
        articleTitle = json['articleTitle'],
        articleContent = json['articleContent'],
        articleTime = json['articleTime'],
        articleUrl = json['articleUrl'],
        articleImage = json['articleImage'];


  Map toJson() =>
      {
        'articleId':articleId,
        'articleTitle':articleTitle,
        'articleContent':articleContent,
        'articleTime':articleTime,
        'articleUrl':articleUrl,
        'articleImage':articleImage,
      };
}