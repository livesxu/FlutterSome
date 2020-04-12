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

//各网站feed页面链接
const FeedGroupInfoLinks = [
  'http://www.baidu.com/search/rss.html',//百度新闻
  'http://rss.people.com.cn/',//人民网
  'http://rss.huanqiu.com',//环球网
  'http://www.sciencenet.cn/RSS.aspx',//科学网
  'http://www.163.com/rss',//网易
  'http://rss.sina.com.cn',//新浪
  'http://rss.news.sohu.com',//搜狐
  'http://news.hexun.com/rss/',//和讯网
  'http://news.ifeng.com/rss/',//凤凰网
  'http://www.chinanews.com/rss/',//中国新闻网
  'http://rss.zol.com.cn',//中关村
  'http://rss.yesky.com',//天极网
  'http://www.nfcmag.com/rss/index.html',//南风窗
  'http://www.fjsen.com/rss/rss.htm',//东南网
  'http://other.caixin.com/rss/',//财新网
  'http://www.stats.gov.cn/wzgl/rss/',//国家统计局
  'http://edition.cnn.com/services/rss/',//CNN
  'http://www.pc841.com/rss/',//科技pc841
  'http://www.ebrun.com/rss/',//亿邦动力网
  'http://www.mtime.com/rss/',//时光网
  'https://www.meiwen.com.cn/rssmap.html',//美文阅读
  'http://www.chexun.com/about/rss.html',//车讯网
  'http://www.yoka.com/about/2012/rss.shtml',//YOKA时尚网
  'http://www.daimg.com/rssmap.html',//大图网
  'http://www.lanrentuku.com/about/rssmap.html',//懒人图库
];