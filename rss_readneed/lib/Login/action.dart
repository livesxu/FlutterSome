import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum LoginAction {
  action,
  focusAction,//命中操作
  submitAction,//登录操作
  jumpRegister,//跳转注册
}

class LoginActionCreator {
  static Action onAction() {
    return const Action(LoginAction.action);
  }
  static Action focusAction(index) {
    return Action(LoginAction.focusAction,payload: index);
  }
  static Action submitAction() {
    return const Action(LoginAction.submitAction);
  }
  static Action jumpRegister() {
    return const Action(LoginAction.jumpRegister);
  }
}
