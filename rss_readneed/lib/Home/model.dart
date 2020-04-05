class InfoModel {

  int infoId;
  String infoName;//名称
  String infoUrl;//链接
  String infoImage;//图片
  String infoIntroduce;//介绍

  InfoModel.fromJson(Map json)
      : infoId = json['infoId'],
        infoName = json['infoName'],
        infoUrl = json['infoUrl'],
        infoImage = json['infoImage'],
        infoIntroduce = json['infoIntroduce'];

  Map toJson() =>
      {
        'infoId':infoId,
        'infoName':infoName,
        'infoUrl':infoUrl,
        'infoImage':infoImage,
        'infoIntroduce':infoIntroduce,
      };
}

class ArticleModel {

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