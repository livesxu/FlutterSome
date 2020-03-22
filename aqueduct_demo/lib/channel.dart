import 'aqueduct_demo.dart';
import 'app_config.dart';

import 'tables/tables_rss.dart';
import 'package:aqueduct/aqueduct.dart';

import 'package:aqueduct_demo/RssVc/login_vc.dart';
import 'package:aqueduct_demo/RssVc/tag_vc.dart';
import 'package:aqueduct_demo/RssVc/info_vc.dart';

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

    router
        .route("/validate")
        .link(() =>  ValidateController())
        .linkFunction((request){
          return Response.ok({"validate":"Success"});
    });

    //登录
    router.route("/login").link(() => LoginResourceVc(context));

    //标签
    router.route("/tag").link(() => TagResourceVc(context));

    //内容 + 文章
    router.route("/info/[:id]").link(() => InfoResourceVc(context));
    router.route("/article/[:infoId]").link(() => ArticleResourceVc(context));

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