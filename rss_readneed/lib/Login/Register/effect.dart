import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

import '../../public.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

Effect<registerState> buildEffect() {
  return combineEffects(<Object, Effect<registerState>>{
    Lifecycle.dispose: _dispose,
    registerAction.submitAction:_submitAction,
  });
}

void _dispose(Action action, Context<registerState> ctx) {

  ctx.state.accountVc.dispose();
  ctx.state.passwordVc.dispose();
  ctx.state.surePasswordVc.dispose();

}

void _submitAction(Action action, Context<registerState> ctx) async {

  if (ctx.state.accountVc.text.length <= 0) {

    Toast.show(ctx.context, '请输入账号');
    return ;
  }
  if (ctx.state.passwordVc.text.length <= 0) {

    Toast.show(ctx.context, '请输入密码');
    return ;
  }
  if (ctx.state.surePasswordVc.text != ctx.state.passwordVc.text) {

    Toast.show(ctx.context, '请再次确认密码');
    return ;
  }
  //注册
  http.Response response = await http.post('http://localhost:8080/login',
                                      body: {"phone":ctx.state.accountVc.text,
                                             "password":ctx.state.passwordVc.text});

  if(response.statusCode == 200) {

    Toast.show(ctx.context, '注册成功');
  }

}
