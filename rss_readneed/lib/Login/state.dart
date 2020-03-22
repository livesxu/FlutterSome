import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

class LoginState implements Cloneable<LoginState> {

  TextEditingController accountVc;
  TextEditingController passwordVc;

  int focusIndex;

  @override
  LoginState clone() {
    return LoginState()
        ..accountVc = accountVc
        ..passwordVc = passwordVc
        ..focusIndex = focusIndex;
  }
}

LoginState initState(Map<String, dynamic> args) {

  LoginState state = LoginState()
                        ..accountVc = TextEditingController(text: '')
                        ..passwordVc = TextEditingController(text: '')
                        ..focusIndex = 0;

  return state;
}
