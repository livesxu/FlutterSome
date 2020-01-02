import 'aqueduct_demo.dart';
import 'app_config.dart';

import 'tables/table_user.dart';
import 'tables/tables_rss.dart';
import 'package:aqueduct/aqueduct.dart';

import 'package:aqueduct_demo/RssVc/login_vc.dart';

/// This type initializes an application.
///
/// Override methods in this class to set up routes and initialize services like
/// database connections. See http://aqueduct.io/docs/http/channel/.
class AqueductDemoChannel extends ApplicationChannel {

  ManagedContext context;//可通过该实例操作数据库
  /// Initialize services in this method.
  ///
  /// Implement this method to initialize services, read values from [options]
  /// and any other initialization required before constructing [entryPoint].
  ///
  /// This method is invoked prior to [entryPoint] being accessed.
  @override
  Future prepare() async {
    logger.onRecord.listen((rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));

    //执行初始化任务的方法
    final AppConfig _config = AppConfig(options.configurationFilePath);
//new
    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();//描述应用程序的数据模型
    final psc = PostgreSQLPersistentStore.fromConnectionInfo(
        _config.database.username,
        _config.database.password,
        _config.database.host,
        _config.database.port,
        _config.database.databaseName);//管理与单个数据库的连接
    context=ManagedContext(dataModel, psc);
//new

  }

  /// Construct the request channel.
  ///
  /// Return an instance of some [Controller] that will be the initial receiver
  /// of all [Request]s.
  ///
  /// This method is invoked after [prepare].
  @override
  Controller get entryPoint {
    final router = Router();

    // Prefer to use `link` instead of `linkFunction`.
    // See: https://aqueduct.io/docs/http/request_controller/
    router
      .route("/example")
      .linkFunction((request) async {
        return Response.ok({"key": "value"});
      });

    router
        .route("/hello")
        .linkFunction((request) async {
      return Response.ok({"hello": "hello world"});
    });

    router.route('/queryAllArticle').linkFunction((request) async{
      final query = Query<Article>(context);//拿到表的查询实例
      final List<Article> articles=await query.fetch();//查询所有数据
      return Response.ok(articles);//数据以json形式返回给客户端
    });

    router
        .route("/validate")
        .link(() =>  ValidateController())
        .linkFunction((request){
          return Response.ok({"validate":"Success"});
    });

    router.route('/article/[:id([0-9]+)]').link(
    () => ArticleController(context),
    );

    router.route("/user/[:id([0-9]+)]").link(
        () => UsersController(context)
    );

    router.route("login/*").link(() => LoginVc(context));

    return router;
  }
}

class ValidateController extends Controller {

  @override
  FutureOr<RequestOrResponse> handle(Request request) async {
    final headers = request.raw.headers;
    final a = headers.value('a');
    if (a == 'a') {
      return request;
    }
    return Response.unauthorized();
  }
}

class ArticleController extends ResourceController {
  ArticleController(this.context);

  final ManagedContext context;

  @Operation.get() //获取文章列表
  FutureOr<Response> getArticle() async {
//查询文章，并根据createDate进行排序
    final query = Query<Article>(context)
      ..sortBy((Article e) => e.createData, QuerySortOrder.ascending);
    final List<Article> articles = await query.fetch();
    print(articles);
    return Response.ok(articles)
      ..contentType = ContentType.json;
  }

  @Operation.post()//添加一篇文章
  FutureOr<Response> insertArticle(
      @Bind.body(ignore: ["createData"]) Article article) async {
    article.createData = DateTime.now();
//插入一条数据
    final result = await context.insertObject<Article>(article);
    return Response.ok(result);
  }

  @Operation.get('id')//查询单个文章
  Future<Response> getArticleById(@Bind.path('id') int id) async {
//根据id查询一条数据
    final query = Query<Article>(context)..where((a) => a.id).equalTo(id);
    final article = await query.fetchOne();
    if (article != null) {
      return Response.ok(article);
    } else {
      return Response.ok("have no");
    }
  }

  @Operation.put()//修改一篇文章
  Future<Response> updateArticleById(
      @Bind.body(ignore: ["createData"]) Article article) async {

    final query = Query<Article>(context)
      ..values.content = article.content
      ..where((a) => a.id).equalTo(article.id);
//更新一条数据
    final result = await query.updateOne();
//    final article = await query.fetchOne();
    if (result != null) {
      return Response.ok(result);
    } else {
      return Response.ok("更新失败，数据不存在");
    }
  }

  @Operation.delete('id')//删除一篇文章
  Future<Response> deleteArticleById(@Bind.path('id') int id) async {
    final query = Query<Article>(context)..where((a) => a.id).equalTo(id);
//删除一条数据
    final result = await query.delete();
    if (result != null && result == 1) {
      return Response.ok("删除成功");
    } else {
      return Response.ok("删除失败，数据不存在");
    }
  }
}

class UsersController extends ResourceController {

  UsersController(this.context);

  final ManagedContext context;

  //添加一个用户
  @Operation.post()
  FutureOr<Response> addUser(@Bind.body(require: ["nick_name","password"]) User user) async {
    user.vip = false;
    user.user_name = (user.user_name == null) ? user.nick_name : user.user_name;
    user.rank = "0";

    final result = await context.insertObject(user);

    return Response.ok(result);
  }

  //查询所有用户
  @Operation.get()
  Future<Response> allUsers() async {

    final query = Query<User>(context)
        ..sortBy((User user) => user.id, QuerySortOrder.ascending);
    final List<User> users = await query.fetch();

    return Response.ok(users);
  }

  //查询某一个用户昵称
  @Operation.get("id")
  Future<Response> queryNameById(@Bind.path("id") int id) async {

    final query = Query<User>(context)
        ..where((User user) => user.id).equalTo(id);
    User user = await query.fetchOne();

    if (user != null) {

      return Response.ok({"nickName":user.nick_name});
    } else {
      return Response.ok("have no this user");
    }
  }

}