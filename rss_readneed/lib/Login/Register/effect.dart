import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

import '../../public.dart';

import 'package:crypto/crypto.dart';
import 'dart:convert';

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
  var digest = md5.convert(utf8.encode(ctx.state.passwordVc.text));
  ResuestResult result = await RequestCommon.Post('/login', {"phone":ctx.state.accountVc.text,
    "password":digest.toString()});

  if(result.success) {

    Toast.show(ctx.context, '注册成功');
  } else {

    Toast.show(ctx.context, '注册失败');
  }

}
