import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';
import '../public.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

Effect<LoginState> buildEffect() {
  return combineEffects(<Object, Effect<LoginState>>{
    Lifecycle.dispose:_dispose,
    LoginAction.action: _onAction,
    LoginAction.submitAction:_submitAction,
    LoginAction.jumpRegister:_jumpRegisterAction,
  });
}

void _dispose(Action action, Context<LoginState> ctx) {

  ctx.state.accountVc.dispose();
  ctx.state.passwordVc.dispose();
}

void _onAction(Action action, Context<LoginState> ctx) {
}

void _submitAction(Action action, Context<LoginState> ctx) async {

  if (ctx.state.accountVc.text.length <= 0) {

    Toast.show(ctx.context, '请输入账号');
    return ;
  }
  if (ctx.state.passwordVc.text.length <= 0) {

    Toast.show(ctx.context, '请输入密码');
    return ;
  }
  //请求登录 todo
  http.Response response = await http.get("http://localhost:8080/login?phone="+ctx.state.accountVc.text + "&password=" + ctx.state.passwordVc.text);

  if (response.statusCode == 200) {

    Toast.show(ctx.context, '登录成功');
  }
}

void _jumpRegisterAction(Action action, Context<LoginState> ctx) {
  //跳转注册
  AppNavigator.pushRoute(ctx.context, 'register');
}

