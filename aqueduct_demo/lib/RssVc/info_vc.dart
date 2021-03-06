import '../aqueduct_demo.dart';
import '../tables/tables_rss.dart';

class InfoResourceVc extends ResourceController {

  InfoResourceVc(this.context);

  final ManagedContext context;

  //添加栏目
  /*
  *infoName:必传
  * infoUrl:必传
  * infoIntroduce:可传
  */
  @Operation.post()
  FutureOr<Response> addInfo (@Bind.body(require: ["infoName","infoUrl"]) RssInfo info) async {

    final query = Query<RssInfo>(context)
                  ..where((RssInfo one)=>one.infoUrl).equalTo(info.infoUrl)
                  ..where((RssInfo one)=>one.infoName).equalTo(info.infoName);
    final resultOne = await query.fetchOne();

    if (resultOne != null) {

      return Response.ok(resultOne);
    }

    info.infoState = "1";//默认有效
    info.infoUpdateTime = DateTime.now().add(Duration(hours: 8));
    if (info.infoIntroduce == null) {
      info.infoIntroduce = info.infoName;
    }

    final result = await context.insertObject<RssInfo>(info);

    return Response.ok(result);
  }

  //查询所有栏目
  @Operation.get()
  FutureOr<Response> allInfo () async {

    final query = Query<RssInfo>(context);
    List<RssInfo> infos = await query.fetch();

    return Response.ok(infos);
  }

  //查询某个栏目的所有文章 eg: /info/1
  @Operation.get("id")
  FutureOr<Response> infoAricles (@Bind.path("id") int id) async {

    final query = Query<RssInfo>(context)
        ..where((RssInfo info)=>info.infoId).equalTo(id)
        ..join(set:(RssInfo info)=> info.articles);

    final result = await query.fetchOne();

    return Response.ok(result);
  }
}


class ExpResourceVc extends ResourceController {

  ExpResourceVc(this.context);

  final ManagedContext context;

  //内容正则修改 eg: /exp/1
  @Operation.post("id")
  FutureOr<Response> infoAricles (@Bind.path("id") int id, @Bind.body(require: ['topExp']) RssInfo exp) async {

    final query = Query<RssInfo>(context)
      ..where((RssInfo info)=>info.infoId).equalTo(id);

    query.values.topExp = exp.topExp;
    query.values.titleExpStart = exp.titleExpStart;
    query.values.titleExpEnd = exp.titleExpEnd;
    query.values.contentExpStart = exp.contentExpStart;
    query.values.contentExpEnd = exp.contentExpEnd;
    query.values.imageExpStart = exp.imageExpStart;
    query.values.imageExpEnd = exp.imageExpEnd;
    query.values.linkExpStart = exp.linkExpStart;
    query.values.linkExpEnd = exp.linkExpEnd;

    final result = await query.updateOne();

    if (result != null) {

      return Response.ok(result);
    } else {
      return Response.badRequest(body:"更新失败");
    }
  }
}

//在某个栏目下添加文章
class ArticleResourceVc extends ResourceController {

  ArticleResourceVc(this.context);

  final ManagedContext context;

  //根据内容批量插入文章
  /*数组批量添加[]
  * articleTitle 标题 必传
  * articleContent 内容 必传
  * articleUrl 链接 必传
  *
   */
  @Operation.post("infoId")
  FutureOr<Response> addArticles (@Bind.path("infoId") int infoId,@Bind.body() List<RssArticle> articles) async {

    List<RssArticle> newArt = articles.map((RssArticle mArt) {

      RssArticle newOne = RssArticle();
      newOne.articleTitle = mArt.articleTitle;
      newOne.articleContent = mArt.articleContent;
      newOne.articleUrl = mArt.articleUrl;
      newOne.articleTime = DateTime.now().add(Duration(hours: 8));
      newOne.state = 1;
      newOne.info = RssInfo()
        ..infoId = infoId;
      return newOne;

     }).toList();

    final result = await context.insertObjects<RssArticle>(newArt);

    return Response.ok(result);
  }

  //查询一篇文章 eg: /article?id=123
  @Operation.get()
  FutureOr<Response> getArticleById(@Bind.query('id') int id) async {

    final query = Query<RssArticle>(context)
      ..where((RssArticle article)=>article.articleId).equalTo(id);

    final result = await query.fetchOne();

    return Response.ok(result);
  }

}