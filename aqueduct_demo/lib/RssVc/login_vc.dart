import '../aqueduct_demo.dart';

import '../tables/tables_rss.dart';

import 'package:crypto/crypto.dart';
import 'dart:convert';

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
  /*入参：
  * phone 必传
  * password 必传 MD5加密
  * nick 可选
  * headImg 可选
  */
//
  @Operation.post()
  FutureOr<Response> addUser(@Bind.body(require: ["phone","password"]) RssUser user) async {

    user.nick = (user.nick == null) ? user.phone : user.nick;
    user.introduce = '';
    user.headImg = 'http://localhost:8888' + '/image/' + 'icon_default.png';
    user.vip = 0;
    user.level = 0;
    user.state = "1";
    user.createDate = DateTime.now();
    user.loginTime = user.createDate;
    user.auth = md5.convert(utf8.encode(user.loginTime.toString() + user.phone)).toString();//auth 登录时间+账号md5加密

    final result = await context.insertObject<RssUser>(user);

    return Response.ok(result);
  }

  //使用phone和password 查询指定用户信息 - 登录
  @Operation.get()
  FutureOr<Response> loginUser(@Bind.query("phone") String phone,@Bind.query("password") String password) async {

    //更改为直接索引更新登录时间和auth
    DateTime nowTime = DateTime.now();
    final query = Query<RssUser>(context)
      ..where((RssUser user) => user.phone).equalTo(phone)
      ..where((RssUser user) => user.password).equalTo(password)
      ..values.loginTime = nowTime
      ..values.auth = md5.convert(utf8.encode(nowTime.toString() + phone)).toString();

    RssUser user = await query.updateOne();

    if (user != null) {

      return Response.ok(user);
    } else {
      return Response.badRequest(body:"账号或密码错误，登录失败");
    }
  }

  //退出登录 - 直接本地保存的登录数据清空即可

  //修改用户信息，应该使用auth或者id操作 todo
  @Operation.put()
  FutureOr<Response> changeInfo(@Bind.body(require: ["phone"]) RssUser user_new) async {

    final query = Query<RssUser>(context)
      ..where((RssUser user) => user.phone).equalTo(user_new.phone);

    if (user_new.nick != null) {

      query.values.nick = user_new.nick;
    }
    if (user_new.introduce != null) {

      query.values.introduce = user_new.introduce;
    }
    if (user_new.headImg != null) {

      query.values.headImg = user_new.headImg;
    }

    RssUser user = await query.updateOne();

    if (user != null) {

      return Response.ok(user);
    } else {
      return Response.badRequest(body:"更新失败");
    }
  }

}