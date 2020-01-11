import '../aqueduct_demo.dart';
import '../tables/tables_rss.dart';

class InfoResourceVc extends ResourceController {

  InfoResourceVc(this.context);

  final ManagedContext context;

  //添加内容
  @Operation.post()
  FutureOr<Response> addInfo (@Bind.body(require: ["infoName","infoUrl"]) RssInfo info) async {

    info.infoState = "1";//默认有效
    info.infoUpdateTime = DateTime.now();

    final result = await context.insertObject<RssInfo>(info);

    return Response.ok(result);
  }

  //查询所有内容
  @Operation.get()
  FutureOr<Response> allInfo () async {

    final query = Query<RssInfo>(context);
    List<RssInfo> infos = await query.fetch();

    return Response.ok(infos);
  }

  //查询某个内容的所有文章
  @Operation.get("id")
  FutureOr<Response> infoAricles (@Bind.path("id") int id) async {

    final query = Query<RssInfo>(context)
        ..where((RssInfo info)=>info.infoId).equalTo(id)
        ..join(set:(RssInfo info)=> info.articles);

    final result = await query.fetch();

    return Response.ok(result);
  }
}

class ArticleResourceVc extends ResourceController {

  ArticleResourceVc(this.context);

  final ManagedContext context;

  //根据内容批量插入文章
  @Operation.post("infoId")
  FutureOr<Response> addArticles (@Bind.path("infoId") int infoId,@Bind.body() List<RssArticle> articles) async {

    List<RssArticle> newArt = articles.map((RssArticle mArt) {

      RssArticle newOne = RssArticle();
      newOne.articleTitle = mArt.articleTitle;
      newOne.articleContent = mArt.articleContent;
      newOne.articleUrl = mArt.articleUrl;
      newOne.articleTime = DateTime.now();
      newOne.state = 1;
      newOne.info = RssInfo()
        ..infoId = infoId;
      return newOne;

     }).toList();

    final result = await context.insertObjects<RssArticle>(newArt);

    print(result);

    return Response.ok(result);
  }



}