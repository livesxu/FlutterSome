import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../public.dart';
//收藏栏目与文章管理类
class CollectCommon {

  List<InfoModel> _infos = [];
  List<ArticleModel> _articles = [];

  static List<InfoModel> get infos {

    return CollectCommon.share._infos;
  }

  static List<ArticleModel> get articles {

    return CollectCommon.share._articles;
  }

  static CollectCommon _share;
  static CollectCommon get share {

    if (_share == null)  {

      _share = CollectCommon();

    }
    return _share;
  }

  //读取数据
  static readInfo (SharedPreferences prefs) async {

    String info_collect = prefs.get('info_collect');

    if (info_collect != null && info_collect.length > 0) {

      List the = jsonDecode(info_collect);
      CollectCommon.share._infos = the.map((theOne)=>InfoModel.fromJson(theOne)).toList();
    }

    String article_collect = prefs.get('article_collect');

    if (article_collect != null && article_collect.length > 0) {

      List the = jsonDecode(article_collect);
      CollectCommon.share._articles = the.map((theOne)=>ArticleModel.fromJson(theOne)).toList();
    }
  }

  //collect info
  static Future<bool> collectInfo(InfoModel infoModel) async {

    if (judgeInfoContain(infoModel) != -1) {

      return true;
    }

    List<InfoModel> temp = CollectCommon.share._infos;

    temp.insert(0, infoModel);

    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool success = await prefs.setString('info_collect', jsonEncode(temp));

    if (success) {
      CollectCommon.share._infos = temp;
    }

    return success;
  }
  //判断存储是否已经包含有info ***infoName和infoUrl确定一个InfoModel***
  static int judgeInfoContain (InfoModel infoModel) {

    List<String> infoSignList = CollectCommon.share._infos.map((infoOne)=> infoOne.infoName + infoOne.infoUrl).toList();
    
    return infoSignList.indexOf(infoModel.infoName + infoModel.infoUrl);
  }
  //取消收藏 info
  static Future<bool> removeCollectInfo(InfoModel infoModel) async {

    int index = judgeInfoContain(infoModel);
    if (index == -1) {

      return true;
    }

    List<InfoModel> temp = CollectCommon.share._infos;

    temp.removeAt(index);

    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool success = await prefs.setString('info_collect', jsonEncode(temp));

    if (success) {
      CollectCommon.share._infos = temp;
    }

    return success;
  }

  //collect article
  static Future<bool> collectArticle(ArticleModel articleModel) async {

    if (judgeArticleContain(articleModel) != -1) {

      return true;
    }

    List<ArticleModel> temp = CollectCommon.share._articles;

    temp.insert(0, articleModel);

    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool success = await prefs.setString('article_collect', jsonEncode(temp));

    if (success) {
      CollectCommon.share._articles = temp;
    }

    return success;
  }
  //判断存储是否已经包含有article
  static int judgeArticleContain (ArticleModel articleModel) {

    List<String> articleSignList = CollectCommon.share._articles.map((articleOne)=>articleOne.articleUrl).toList();
    
    return articleSignList.indexOf(articleModel.articleUrl);
  }
  //取消收藏 article
  static Future<bool> removeCollectArticle(ArticleModel articleModel) async {

    int index = judgeArticleContain(articleModel);
    if (index == -1) {

      return true;
    }

    List<ArticleModel> temp = CollectCommon.share._articles;

    temp.removeAt(index);

    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool success = await prefs.setString('article_collect', jsonEncode(temp));

    if (success) {
      CollectCommon.share._articles = temp;
    }

    return success;
  }
}