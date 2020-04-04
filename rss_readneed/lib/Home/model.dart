class InfoModel {

  int infoId;
  String infoName;
  String infoUrl;
  String infoIntroduce;//介绍

  InfoModel.fromJson(Map json)
      : infoId = json['infoId'],
        infoName = json['infoName'],
        infoUrl = json['infoUrl'],
        infoIntroduce = json['infoIntroduce'];

  Map toJson() =>
      {
        'infoId':infoId,
        'infoName':infoName,
        'infoUrl':infoUrl,
        'infoIntroduce':infoIntroduce,
      };
}

class ArticleModel {

  int articleId;
  String articleTitle;
  String articleContent;
  String articleTime;
  String articleUrl;

  ArticleModel.fromJson(Map json)
    :   articleId = json['articleId'],
        articleTitle = json['articleTitle'],
        articleContent = json['articleContent'],
        articleTime = json['articleTime'],
        articleUrl = json['articleUrl'];


  Map toJson() =>
      {
        'articleId':articleId,
        'articleTitle':articleTitle,
        'articleContent':articleContent,
        'articleTime':articleTime,
        'articleUrl':articleUrl,
      };
}