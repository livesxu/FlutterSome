class InfoModel {

  InfoModel({this.infoId});

  int infoId;
  String infoName;//名称  ***infoName和infoUrl确定一个InfoModel***
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

  String webContent;//添加web - html的展示方式

  ArticleModel.fromJson(Map json)
    :   articleId = json['articleId'],
        articleTitle = json['articleTitle'],
        articleContent = json['articleContent'],
        articleTime = json['articleTime'],
        articleUrl = json['articleUrl'],
        articleImage = json['articleImage'],
        webContent = json['webContent'];

  Map toJson() =>
      {
        'articleId':articleId,
        'articleTitle':articleTitle,
        'articleContent':articleContent,
        'articleTime':articleTime,
        'articleUrl':articleUrl,
        'articleImage':articleImage,
        'webContent':webContent,
      };
}

//各网站feed页面链接 - RSS 订阅站点推荐 icon存放：https://imgchr.com
const FeedGroupInfoLinks = [
    {'name':'人民网','link':'http://rss.people.com.cn/','image':"http://rss.people.com.cn/img/2014peoplelogo/rss_logo.gif"},//
    {'name':'环球网','link':'http://rss.huanqiu.com','image':"https://rs2.huanqiucdn.cn/huanqiu/image/www/index/new_logo.png"},//
    {'name':'科学网','link':'http://www.sciencenet.cn/RSS.aspx','image':'https://s1.ax1x.com/2020/07/12/U8OvTI.jpg'},//
    {'name':'搜狐','link':'http://rss.news.sohu.com','image':'http://images.sohu.com/uiue/sohu_logo/2005/sohu_logo2.gif'},//
    {'name':'和讯网','link':'http://news.hexun.com/rss/','image':'http://img.hexun.com/2010/cphead/cplogo.gif'},//
    {'name':'中国新闻网','link':'http://www.chinanews.com/rss/','image':'http://i5.chinanews.com/logo.gif'},//
    {'name':'中关村','link':'http://rss.zol.com.cn','image':'https://icon.zol-img.com.cn/favicon/180.png'} ,//
    {'name':'天极网','link':'http://rss.yesky.com','image':'http://www.yesky.com/TLimages2009/yesky/images/index/faviconie9.ico'} ,//
    {'name':'东南网','link':'http://www.fjsen.com/rss/rss.htm','image':'http://www.fjsen.com/js/ipa/logo2.png'} ,//
    {'name':'财新网','link':'http://other.caixin.com/rss/','image':'http://file.caixin.com/webchannel/all/img/logo.png'},//
    {'name':'国家统计局','link':'http://www.stats.gov.cn/wzgl/rss/','image':'https://s1.ax1x.com/2020/07/12/U8vLXF.png'} ,//
    {'name':'科技pc841','link':'http://www.pc841.com/rss/','image':'https://www.pc841.com/statics/images/v9/logo.jpg'} ,//
    {'name':'亿邦动力网','link':'http://www.ebrun.com/rss/','image':'https://s1.ax1x.com/2020/07/12/U8OrF0.png'},//
    {'name':'时光网','link':'http://www.mtime.com/rss/','image':'http://static1.mtime.cn/favicon.ico'} ,//
    {'name':'美文阅读','link':'https://www.meiwen.com.cn/rssmap.html','image':'https://s1.ax1x.com/2020/07/12/U8L7rj.png'} ,//
    {'name':'车讯网','link':'http://www.chexun.com/about/rss.html','image':'https://s1.ax1x.com/2020/07/12/U8OKLd.jpg'} ,//
//    {'name':'大图网','link':'http://www.daimg.com/rssmap.html'} ,// 局限性高 - 隐藏
//    {'name':'懒人图库','link':'http://www.lanrentuku.com/about/rssmap.html'} ,// 局限性高 - 隐藏
];

const someFeedInfos = [
  {
    "infoId": 8,
    "infoName": "360 beauty one",
    "infoUrl": "https://image.so.com/zjl?ch=beauty&sn=30&listtype=new&temp=1",
    "abInfoUrl": null,
    "infoIntroduce": "360 beauty one",
    "infoImage": null,
    "infoState": "1",
    "infoUpdateTime": "2020-04-09T18:25:19.837892Z",
    "topExp": "id:(.*?)pic_desc",
    "titleExpStart": "title:",
    "titleExpEnd": ",",
    "contentExpStart": null,
    "contentExpEnd": null,
    "imageExpStart": "qhimg_url:",
    "imageExpEnd": ",",
    "linkExpStart": "",
    "linkExpEnd": ""
  },
  {
    "infoId": 1006,
    "infoName": "爱…稀奇~新鲜:科技:创意:有趣",
    "infoUrl": "http://www.ixiqi.com/feed",
    "abInfoUrl": "http://www.ixiqi.com",
    "infoIntroduce": "分享全球新鲜玩意儿",
    "infoImage": null,
    "infoState": "1",
    "infoUpdateTime": "2020-04-11T15:22:10.089085Z",
    "topExp": "<item>(.*?)</item>",
    "titleExpStart": "<title>",
    "titleExpEnd": "</title>",
    "contentExpStart": "<content:encoded><!\\[CDATA\\[",
    "contentExpEnd": "\\]\\]></content:encoded>",
    "imageExpStart": "img src=\"",
    "imageExpEnd": "\"",
    "linkExpStart": "<link>",
    "linkExpEnd": "</link>"
  },
  {
    "infoId": 1010,
    "infoName": "什么值得买",
    "infoUrl": "http://feed.smzdm.com/",
    "abInfoUrl": "http://www.smzdm.com",
    "infoIntroduce": "高性价比产品网购推荐，值得您每天来看看",
    "infoImage": "https://res.smzdm.com/images/smzdm_178.jpg",
    "infoState": "1",
    "infoUpdateTime": "2020-04-11T14:22:29.000Z",
    "topExp": "<item>(.*?)</item>",
    "titleExpStart": "title><!\\[CDATA\\[",
    "titleExpEnd": "\\]\\]></title",
    "contentExpStart": "<content:encoded><!\\[CDATA\\[",
    "contentExpEnd": "\\]\\]></content:encoded>",
    "imageExpStart": "<focus_pic><!\\[CDATA\\[",
    "imageExpEnd": "\\]\\]></focus_pic>",
    "linkExpStart": "<link><!\\[CDATA\\[",
    "linkExpEnd": "\\]\\]></link>"
  },
  {
    "infoId": 20,
    "infoName": "优设网-UISDC",
    "infoUrl": "http://www.uisdc.com/feed",
    "abInfoUrl": "https://www.uisdc.com",
    "infoIntroduce": "优秀设计联盟-优设网-设计师交流学习平台-看设计文章，学软件教程，找灵感素材，尽在优设网！",
    "infoImage": "",
    "infoState": "1",
    "infoUpdateTime": "2020-04-12T12:18:51.330214Z",
    "topExp": "<item>(.*?)</item>",
    "titleExpStart": "<title([^<]*?)>",
    "titleExpEnd": "</title>",
    "contentExpStart": "<content:encoded([^<]*?)><!\\[CDATA\\[",
    "contentExpEnd": "\\]\\]></content:encoded>",
    "imageExpStart": "<img([^>]*?)src=\"",
    "imageExpEnd": "\"",
    "linkExpStart": "<link([^<]*?)>",
    "linkExpEnd": "</link>"
  },
  {
    "infoId": 21,
    "infoName": "知乎每日精选",
    "infoUrl": "https://www.zhihu.com/rss",
    "abInfoUrl": "http://www.zhihu.com",
    "infoIntroduce": "中文互联网最大的知识平台，帮助人们便捷地分享彼此的知识、经验和见解。",
    "infoImage": "",
    "infoState": "1",
    "infoUpdateTime": "2020-04-12T21:34:09.916288Z",
    "topExp": "<item>(.*?)</item>",
    "titleExpStart": "<title([^<]*?)>",
    "titleExpEnd": "</title>",
    "contentExpStart": "<description([^<]*?)>",
    "contentExpEnd": "</description>",
    "imageExpStart": "img([^>]*?)src=\"",
    "imageExpEnd": "\"",
    "linkExpStart": "<link([^<]*?)>",
    "linkExpEnd": "</link>"
  },
  {
    "infoId": 22,
    "infoName": "http://www.4sbooks.com/feed",
    "infoUrl": "http://www.4sbooks.com/feed",
    "abInfoUrl": "http://www.4sbooks.com",
    "infoIntroduce": "四季书评",
    "infoImage": "",
    "infoState": "1",
    "infoUpdateTime": "2020-04-12T21:49:40.968148Z",
    "topExp": "<item>(.*?)</item>",
    "titleExpStart": "<title([^<]*?)>",
    "titleExpEnd": "</title>",
    "contentExpStart": "<description([^<]*?)><!\\[CDATA\\[",
    "contentExpEnd": "\\]\\]></description>",
    "imageExpStart": "<img([^>]*?)src=\"",
    "imageExpEnd": "\"",
    "linkExpStart": "<link([^<]*?)>",
    "linkExpEnd": "</link>"
  },
  {
    "infoId": 1008,
    "infoName": "摄影之友",
    "infoUrl": "https://www.fotomen.cn/feed",
    "abInfoUrl": "https://fotomen.cn",
    "infoIntroduce": "Photo your life！",
    "infoImage": null,
    "infoState": "1",
    "infoUpdateTime": "2020-04-09T15:52:42.156249Z",
    "topExp": "<item>(.*?)</item>",
    "titleExpStart": "title>",
    "titleExpEnd": "</title",
    "contentExpStart": "<content:encoded><!\\[CDATA\\[",
    "contentExpEnd": "\\]\\]></content:encoded>",
    "imageExpStart": "img src=\"",
    "imageExpEnd": "\"",
    "linkExpStart": "link>",
    "linkExpEnd": "</link"
  },
  {
    "infoId": 1009,
    "infoName": "PanSci 泛科學",
    "infoUrl": "https://pansci.asia/feed",
    "abInfoUrl": "https://pansci.asia",
    "infoIntroduce": "全台最大科學知識社群",
    "infoImage": null,
    "infoState": "1",
    "infoUpdateTime": "2020-04-09T23:43:01.000Z",
    "topExp": "<item>(.*?)</item>",
    "titleExpStart": "title>",
    "titleExpEnd": "</title",
    "contentExpStart": "<content:encoded><!\\[CDATA\\[",
    "contentExpEnd": "\\]\\]></content:encoded>",
    "imageExpStart": "img src=\"",
    "imageExpEnd": "\"",
    "linkExpStart": "link>",
    "linkExpEnd": "</link"
  },
  {
    "infoId": 1002,
    "infoName": "cnBeta.COM",
    "infoUrl": "http://www.cnbeta.com/backend.php",
    "abInfoUrl": "https://www.cnbeta.com",
    "infoIntroduce": "简明IT新闻,网友媒体与言论平台",
    "infoImage": "https://static.cnbetacdn.com/logo.png",
    "infoState": "1",
    "infoUpdateTime": "2020-04-11T16:15:27.000Z",
    "topExp": "<item>(.*?)</item>",
    "titleExpStart": "title>",
    "titleExpEnd": "</title",
    "contentExpStart": "<description><!\\[CDATA\\[",
    "contentExpEnd": "\\]\\]></description>",
    "imageExpStart": "img src=\"",
    "imageExpEnd": "\"",
    "linkExpStart": "link>",
    "linkExpEnd": "</link"
  },
  {
    "infoId": 1001,
    "infoName": "36氪",
    "infoUrl": "http://www.36kr.com/feed",
    "abInfoUrl": "https://36kr.com",
    "infoIntroduce": "让创业更简单,让一部分人先看到未来",
    "infoImage": "",
    "infoState": "1",
    "infoUpdateTime": "2020-04-11T15:44:18.000Z",
    "topExp": "<item>(.*?)</item>",
    "titleExpStart": "title><!\\[CDATA\\[",
    "titleExpEnd": "\\]\\]></title",
    "contentExpStart": "<description><!\\[CDATA\\[",
    "contentExpEnd": "\\]\\]></description>",
    "imageExpStart": "<img([^>*?])src=\"",
    "imageExpEnd": "\"",
    "linkExpStart": "link>",
    "linkExpEnd": "</link"
  },
  {
    "infoId": 16,
    "infoName": "数字尾巴",
    "infoUrl": "http://www.dgtle.com/rss/dgtle.xml",
    "abInfoUrl": "http://www.dgtle.com",
    "infoIntroduce": "分享美好数字生活",
    "infoImage": "http://www.dgtle.com/img/common/dgtlerss.jpeg",
    "infoState": "1",
    "infoUpdateTime": "2020-04-12T11:28:39.759254Z",
    "topExp": "<item>(.*?)</item>",
    "titleExpStart": "<title>",
    "titleExpEnd": "</title>",
    "contentExpStart": "<description><!\\[CDATA\\[",
    "contentExpEnd": "\\]\\]></description>",
    "imageExpStart": "<img([^>*?])src=\"",
    "imageExpEnd": "\"",
    "linkExpStart": "<link>",
    "linkExpEnd": "</link>"
  },
  {
    "infoId": 17,
    "infoName": "Engadget Simplified Chinese Summary RSS",
    "infoUrl": "http://cn.engadget.com/rss.xml",
    "abInfoUrl": "http://cn.engadget.com",
    "infoIntroduce": "Engadget Simplified Chinese Summary RSS",
    "infoImage": "",
    "infoState": "1",
    "infoUpdateTime": "2020-04-12T11:55:03.291410Z",
    "topExp": "<item>(.*?)</item>",
    "titleExpStart": "<title([^<]*?)><!\\[CDATA\\[",
    "titleExpEnd": "\\]\\]></title>",
    "contentExpStart": "<description([^<]*?)><!\\[CDATA\\[",
    "contentExpEnd": "\\]\\]></description>",
    "imageExpStart": "<img([^>]*?)src=\"",
    "imageExpEnd": "\"",
    "linkExpStart": "<link([^<]*?)>",
    "linkExpEnd": "</link>"
  },
  {
    "infoId": 18,
    "infoName": "《意林》杂志的BLOG",
    "infoUrl": "http://blog.sina.com.cn/rss/yilinzazhi.xml",
    "abInfoUrl": "http://blog.sina.com.cn/yilinzazhi",
    "infoIntroduce": "",
    "infoImage": "",
    "infoState": "1",
    "infoUpdateTime": "2020-04-12T12:01:50.810790Z",
    "topExp": "<item>(.*?)</item>",
    "titleExpStart": "<title([^<]*?)>",
    "titleExpEnd": "</title>",
    "contentExpStart": "<description([^<]*?)><!\\[CDATA\\[",
    "contentExpEnd": "\\]\\]></description>",
    "imageExpStart": "<img([^>]*?)src=\"",
    "imageExpEnd": "\"",
    "linkExpStart": "<link([^<]*?)>",
    "linkExpEnd": "</link>"
  },
  {
    "infoId": 1003,
    "infoName": "豆瓣最受欢迎的书评",
    "infoUrl": "https://www.douban.com/feed/review/book",
    "abInfoUrl": "https://book.douban.com/",
    "infoIntroduce": "豆瓣成员投票选出的最佳书评",
    "infoImage": null,
    "infoState": "1",
    "infoUpdateTime": "2020-04-10T23:29:09.000Z",
    "topExp": "<item>(.*?)</item>",
    "titleExpStart": "title>",
    "titleExpEnd": "</title",
    "contentExpStart": null,
    "contentExpEnd": null,
    "imageExpStart": "img src=\"",
    "imageExpEnd": "\"",
    "linkExpStart": "link>",
    "linkExpEnd": "</link"
  },
  {
    "infoId": 1004,
    "infoName": "豆瓣最受欢迎的影评",
    "infoUrl": "https://www.douban.com/feed/review/movie",
    "abInfoUrl": "https://movie.douban.com/",
    "infoIntroduce": "豆瓣成员投票选出的最佳影评",
    "infoImage": null,
    "infoState": "1",
    "infoUpdateTime": "2020-04-10T23:37:04.000Z",
    "topExp": "<item>(.*?)</item>",
    "titleExpStart": "title>",
    "titleExpEnd": "</title",
    "contentExpStart": null,
    "contentExpEnd": null,
    "imageExpStart": "img src=\"",
    "imageExpEnd": "\"",
    "linkExpStart": "link>",
    "linkExpEnd": "</link"
  },
  {
    "infoId": 19,
    "infoName": "《读者·原创版》",
    "infoUrl": "http://blog.sina.com.cn/rss/1196045711.xml",
    "abInfoUrl": "http://blog.sina.com.cn/dzycb",
    "infoIntroduce": "",
    "infoImage": "",
    "infoState": "1",
    "infoUpdateTime": "2020-04-12T12:08:27.554813Z",
    "topExp": "<item>(.*?)</item>",
    "titleExpStart": "<title([^<]*?)>",
    "titleExpEnd": "</title>",
    "contentExpStart": "<description([^<]*?)><!\\[CDATA\\[",
    "contentExpEnd": "\\]\\]></description>",
    "imageExpStart": "<img([^>]*?)src=\"",
    "imageExpEnd": "\"",
    "linkExpStart": "<link([^<]*?)>",
    "linkExpEnd": "</link>"
  }
];