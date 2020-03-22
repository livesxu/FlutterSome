import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

class registerState implements Cloneable<registerState> {

  TextEditingController accountVc;
  TextEditingController passwordVc;
  TextEditingController surePasswordVc;

  int focusIndex;

  @override
  registerState clone() {
    return registerState()
          ..accountVc = accountVc
          ..passwordVc = passwordVc
          ..surePasswordVc = surePasswordVc
          ..focusIndex = focusIndex;
  }
}

registerState initState(Map<String, dynamic> args) {
  return registerState()
    ..accountVc = TextEditingController(text: '')
    ..passwordVc = TextEditingController(text: '')
    ..surePasswordVc = TextEditingController(text: '')
    ..focusIndex = 0;
}
