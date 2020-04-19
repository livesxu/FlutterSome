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
  'http://rss.people.com.cn/',//人民网
  'http://rss.huanqiu.com',//环球网
  'http://www.sciencenet.cn/RSS.aspx',//科学网 ?
  'http://rss.sina.com.cn',//新浪
  'http://rss.news.sohu.com',//搜狐
  'http://news.hexun.com/rss/',//和讯网
  'http://www.chinanews.com/rss/',//中国新闻网
  'http://rss.zol.com.cn',//中关村
  'http://rss.yesky.com',//天极网
//  'http://www.nfcmag.com/rss/index.html',//南风窗 仅一个已创建
  'http://www.fjsen.com/rss/rss.htm',//东南网
  'http://other.caixin.com/rss/',//财新网
  'http://www.stats.gov.cn/wzgl/rss/',//国家统计局
  'http://www.pc841.com/rss/',//科技pc841
  'http://www.ebrun.com/rss/',//亿邦动力网
  'http://www.mtime.com/rss/',//时光网
  'https://www.meiwen.com.cn/rssmap.html',//美文阅读
  'http://www.chexun.com/about/rss.html',//车讯网
  'http://www.daimg.com/rssmap.html',//大图网
  'http://www.lanrentuku.com/about/rssmap.html',//懒人图库
];

const someFeedInfo = '[{"infoId":8,"infoName":"360 beauty","infoUrl":"https://image.so.com/zjl?ch=beauty&sn=30&listtype=new&temp=1","abInfoUrl":null,"infoIntroduce":"360 beauty","infoImage":null,"infoState":"1","infoUpdateTime":"2020-04-09T18:25:19.837892Z","topExp":"id:(.*?)pic_desc","titleExpStart":"title:","titleExpEnd":",","contentExpStart":null,"contentExpEnd":null,"imageExpStart":"qhimg_url:","imageExpEnd":",","linkExpStart":"","linkExpEnd":""},{"infoId":1006,"infoName":"爱…稀奇~新鲜:科技:创意:有趣","infoUrl":"http://www.ixiqi.com/feed","abInfoUrl":"http://www.ixiqi.com","infoIntroduce":"分享全球新鲜玩意儿","infoImage":null,"infoState":"1","infoUpdateTime":"2020-04-11T15:22:10.089085Z","topExp":"<item>(.*?)</item>","titleExpStart":"<title>","titleExpEnd":"</title>","contentExpStart":"<description><!\\[CDATA\\[","contentExpEnd":"\\]\\]></description>","imageExpStart":"img src=\"","imageExpEnd":"\"","linkExpStart":"<link>","linkExpEnd":"</link>"},{"infoId":1005,"infoName":"豆瓣最受欢迎的乐评","infoUrl":"https://www.douban.com/feed/review/music","abInfoUrl":"https://music.douban.com/","infoIntroduce":"豆瓣成员投票选出的最佳乐评","infoImage":null,"infoState":"1","infoUpdateTime":"2020-04-10T23:40:27.000Z","topExp":"<item>(.*?)</item>","titleExpStart":"title>","titleExpEnd":"</title","contentExpStart":null,"contentExpEnd":null,"imageExpStart":"img src=\"","imageExpEnd":"\"","linkExpStart":"link>","linkExpEnd":"</link"},{"infoId":1010,"infoName":"什么值得买","infoUrl":"http://feed.smzdm.com/","abInfoUrl":"http://www.smzdm.com","infoIntroduce":"高性价比产品网购推荐，值得您每天来看看","infoImage":"https://res.smzdm.com/images/smzdm_178.jpg","infoState":"1","infoUpdateTime":"2020-04-11T14:22:29.000Z","topExp":"<item>(.*?)</item>","titleExpStart":"title><!\\[CDATA\\[","titleExpEnd":"\\]\\]></title","contentExpStart":"<description><!\\[CDATA\\[","contentExpEnd":"\\]\\]></description>","imageExpStart":"<focus_pic><!\\[CDATA\\[","imageExpEnd":"\\]\\]></focus_pic>","linkExpStart":"<link><!\\[CDATA\\[","linkExpEnd":"\\]\\]></link>"},{"infoId":20,"infoName":"优设网-UISDC","infoUrl":"http://www.uisdc.com/feed","abInfoUrl":"https://www.uisdc.com","infoIntroduce":"优秀设计联盟-优设网-设计师交流学习平台-看设计文章，学软件教程，找灵感素材，尽在优设网！","infoImage":"","infoState":"1","infoUpdateTime":"2020-04-12T12:18:51.330214Z","topExp":"<item>(.*?)</item>","titleExpStart":"<title([^<]*?)>","titleExpEnd":"</title>","contentExpStart":"<description([^<]*?)><!\\[CDATA\\[","contentExpEnd":"\\]\\]></description>","imageExpStart":"<img([^>]*?)src=\"","imageExpEnd":"\"","linkExpStart":"<link([^<]*?)>","linkExpEnd":"</link>"},{"infoId":21,"infoName":"知乎每日精选","infoUrl":"https://www.zhihu.com/rss","abInfoUrl":"http://www.zhihu.com","infoIntroduce":"中文互联网最大的知识平台，帮助人们便捷地分享彼此的知识、经验和见解。","infoImage":"","infoState":"1","infoUpdateTime":"2020-04-12T21:34:09.916288Z","topExp":"<item>(.*?)</item>","titleExpStart":"<title([^<]*?)>","titleExpEnd":"</title>","contentExpStart":"<description([^<]*?)>","contentExpEnd":"</description>","imageExpStart":"<img([^>]*?)src=\"","imageExpEnd":"\"","linkExpStart":"<link([^<]*?)>","linkExpEnd":"</link>"},{"infoId":22,"infoName":"http://www.4sbooks.com/feed","infoUrl":"http://www.4sbooks.com/feed","abInfoUrl":"http://www.4sbooks.com","infoIntroduce":"四季书评","infoImage":"","infoState":"1","infoUpdateTime":"2020-04-12T21:49:40.968148Z","topExp":"<item>(.*?)</item>","titleExpStart":"<title([^<]*?)>","titleExpEnd":"</title>","contentExpStart":"<description([^<]*?)><!\\[CDATA\\[","contentExpEnd":"\\]\\]></description>","imageExpStart":"<img([^>]*?)src=\"","imageExpEnd":"\"","linkExpStart":"<link([^<]*?)>","linkExpEnd":"</link>"},{"infoId":1008,"infoName":"摄影之友","infoUrl":"https://www.fotomen.cn/feed","abInfoUrl":"https://fotomen.cn","infoIntroduce":"Photo your life！","infoImage":null,"infoState":"1","infoUpdateTime":"2020-04-09T15:52:42.156249Z","topExp":"<item>(.*?)</item>","titleExpStart":"title>","titleExpEnd":"</title","contentExpStart":"<description><!\\[CDATA\\[","contentExpEnd":"\\]\\]></description>","imageExpStart":"img src=\"","imageExpEnd":"\"","linkExpStart":"link>","linkExpEnd":"</link"},{"infoId":23,"infoName":"中英文双语新闻 热词翻译- 中国日报21世纪英文报","infoUrl":"http://www.i21st.cn/rss/story.xml","abInfoUrl":"http://www.i21st.cn/","infoIntroduce":"中英文双语热点新闻，配以地道音频及词汇解析, 经典美剧赏析, 热门词汇翻译，分享最地道的英语表达, 国内外新鲜英语趣闻及时事热点- 21英语","infoImage":"http://www.i21st.cn/images/home/logo.png","infoState":"1","infoUpdateTime":"2020-04-12T22:04:53.064852Z","topExp":"<item>(.*?)</item>","titleExpStart":"<title([^<]*?)><!\\[CDATA\\[","titleExpEnd":"\\]\\]></title>","contentExpStart":"<description([^<]*?)><!\\[CDATA\\[","contentExpEnd":"\\]\\]></description>","imageExpStart":"<img([^>]*?)src=\"","imageExpEnd":"\"","linkExpStart":"<link([^<]*?)><!\\[CDATA\\[","linkExpEnd":"\\]\\]></link>"},{"infoId":1007,"infoName":"科学松鼠会","infoUrl":"http://songshuhui.net/feed","abInfoUrl":"https://songshuhui.net","infoIntroduce":"剥开科学的坚果，让科学流行起来","infoImage":"https://songshuhui.net/wp-content/uploads/cropped-songshuhui-32x32.jpg","infoState":"1","infoUpdateTime":"2020-04-09T23:03:37.000Z","topExp":"<item>(.*?)</item>","titleExpStart":"title>","titleExpEnd":"</title","contentExpStart":"<description><!\\[CDATA\\[","contentExpEnd":"\\]\\]></description>","imageExpStart":"img src=\"","imageExpEnd":"\"","linkExpStart":"link>","linkExpEnd":"</link"},{"infoId":1009,"infoName":"PanSci 泛科學","infoUrl":"https://pansci.asia/feed","abInfoUrl":"https://pansci.asia","infoIntroduce":"全台最大科學知識社群","infoImage":null,"infoState":"1","infoUpdateTime":"2020-04-09T23:43:01.000Z","topExp":"<item>(.*?)</item>","titleExpStart":"title>","titleExpEnd":"</title","contentExpStart":"<description><!\\[CDATA\\[","contentExpEnd":"\\]\\]></description>","imageExpStart":"img src=\"","imageExpEnd":"\"","linkExpStart":"link>","linkExpEnd":"</link"},{"infoId":1002,"infoName":"cnBeta.COM RSS订阅","infoUrl":"http://www.cnbeta.com/backend.php","abInfoUrl":"https://www.cnbeta.com","infoIntroduce":"简明IT新闻,网友媒体与言论平台","infoImage":"https://static.cnbetacdn.com/logo.png","infoState":"1","infoUpdateTime":"2020-04-11T16:15:27.000Z","topExp":"<item>(.*?)</item>","titleExpStart":"title>","titleExpEnd":"</title","contentExpStart":"<description><!\\[CDATA\\[","contentExpEnd":"\\]\\]></description>","imageExpStart":"img src=\"","imageExpEnd":"\"","linkExpStart":"link>","linkExpEnd":"</link"},{"infoId":1001,"infoName":"36氪","infoUrl":"http://www.36kr.com/feed","abInfoUrl":"https://36kr.com","infoIntroduce":"让创业更简单,让一部分人先看到未来","infoImage":"","infoState":"1","infoUpdateTime":"2020-04-11T15:44:18.000Z","topExp":"<item>(.*?)</item>","titleExpStart":"title><!\\[CDATA\\[","titleExpEnd":"\\]\\]></title","contentExpStart":"<description><!\\[CDATA\\[","contentExpEnd":"\\]\\]></description>","imageExpStart":"<img([^>*?])src=\"","imageExpEnd":"\"","linkExpStart":"link>","linkExpEnd":"</link"},{"infoId":16,"infoName":"数字尾巴","infoUrl":"http://www.dgtle.com/rss/dgtle.xml","abInfoUrl":"http://www.dgtle.com","infoIntroduce":"分享美好数字生活","infoImage":"http://www.dgtle.com/img/common/dgtlerss.jpeg","infoState":"1","infoUpdateTime":"2020-04-12T11:28:39.759254Z","topExp":"<item>(.*?)</item>","titleExpStart":"<title>","titleExpEnd":"</title>","contentExpStart":"<description><!\\[CDATA\\[","contentExpEnd":"\\]\\]></description>","imageExpStart":"<img([^>*?])src=\"","imageExpEnd":"\"","linkExpStart":"<link>","linkExpEnd":"</link>"},{"infoId":17,"infoName":"Engadget Simplified Chinese Summary RSS","infoUrl":"http://cn.engadget.com/rss.xml","abInfoUrl":"http://cn.engadget.com","infoIntroduce":"Engadget Simplified Chinese Summary RSS","infoImage":"","infoState":"1","infoUpdateTime":"2020-04-12T11:55:03.291410Z","topExp":"<item>(.*?)</item>","titleExpStart":"<title([^<]*?)><!\\[CDATA\\[","titleExpEnd":"\\]\\]></title>","contentExpStart":"<description([^<]*?)><!\\[CDATA\\[","contentExpEnd":"\\]\\]></description>","imageExpStart":"<img([^>]*?)src=\"","imageExpEnd":"\"","linkExpStart":"<link([^<]*?)>","linkExpEnd":"</link>"},{"infoId":18,"infoName":"《意林》杂志的BLOG","infoUrl":"http://blog.sina.com.cn/rss/yilinzazhi.xml","abInfoUrl":"http://blog.sina.com.cn/yilinzazhi","infoIntroduce":"","infoImage":"","infoState":"1","infoUpdateTime":"2020-04-12T12:01:50.810790Z","topExp":"<item>(.*?)</item>","titleExpStart":"<title([^<]*?)>","titleExpEnd":"</title>","contentExpStart":"<description([^<]*?)><!\\[CDATA\\[","contentExpEnd":"\\]\\]></description>","imageExpStart":"<img([^>]*?)src=\"","imageExpEnd":"\"","linkExpStart":"<link([^<]*?)>","linkExpEnd":"</link>"},{"infoId":1003,"infoName":"豆瓣最受欢迎的书评","infoUrl":"https://www.douban.com/feed/review/book","abInfoUrl":"https://book.douban.com/","infoIntroduce":"豆瓣成员投票选出的最佳书评","infoImage":null,"infoState":"1","infoUpdateTime":"2020-04-10T23:29:09.000Z","topExp":"<item>(.*?)</item>","titleExpStart":"title>","titleExpEnd":"</title","contentExpStart":null,"contentExpEnd":null,"imageExpStart":"img src=\"","imageExpEnd":"\"","linkExpStart":"link>","linkExpEnd":"</link"},{"infoId":1004,"infoName":"豆瓣最受欢迎的影评","infoUrl":"https://www.douban.com/feed/review/movie","abInfoUrl":"https://movie.douban.com/","infoIntroduce":"豆瓣成员投票选出的最佳影评","infoImage":null,"infoState":"1","infoUpdateTime":"2020-04-10T23:37:04.000Z","topExp":"<item>(.*?)</item>","titleExpStart":"title>","titleExpEnd":"</title","contentExpStart":null,"contentExpEnd":null,"imageExpStart":"img src=\"","imageExpEnd":"\"","linkExpStart":"link>","linkExpEnd":"</link"},{"infoId":19,"infoName":"《读者·原创版》","infoUrl":"http://blog.sina.com.cn/rss/1196045711.xml","abInfoUrl":"http://blog.sina.com.cn/dzycb","infoIntroduce":"","infoImage":"","infoState":"1","infoUpdateTime":"2020-04-12T12:08:27.554813Z","topExp":"<item>(.*?)</item>","titleExpStart":"<title([^<]*?)>","titleExpEnd":"</title>","contentExpStart":"<description([^<]*?)><!\\[CDATA\\[","contentExpEnd":"\\]\\]></description>","imageExpStart":"<img([^>]*?)src=\"","imageExpEnd":"\"","linkExpStart":"<link([^<]*?)>","linkExpEnd":"</link>"}]';