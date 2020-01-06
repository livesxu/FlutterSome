import '../aqueduct_demo.dart';
import '../tables/table_user.dart';

//https://aqueduct.io/docs/http/controller/
//https://aqueduct.io/docs/http/routing/

//登录相关接口定义
//login  注册 post
//login  登录 get 账号密码
//logout 退出 get 账号
class LoginResourceVc extends ResourceController {

  LoginResourceVc(this.context);

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

  //使用id和password 查询指定用户信息 - 登录
  @Operation.get()
  FutureOr<Response> loginUser(@Bind.query("id") int id,@Bind.query("password") String password) async {

    final query = Query<User>(context)
        ..where((User user) => user.id).equalTo(id)
        ..where((User user) => user.password).equalTo(password);

    User user = await query.fetchOne();

    if (user != null) {

      return Response.ok(user);
    } else {

      return Response.ok("账号或密码错误，登录失败");
    }
  }

  //退出登录 - 清空auth...

}