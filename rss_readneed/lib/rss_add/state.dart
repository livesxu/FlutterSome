import 'package:fish_redux/fish_redux.dart';

import 'package:flutter/material.dart';

//初始state - 属性，初始数据==
class rss_addState implements Cloneable<rss_addState> {

  String urlString;
  String testString;
  TextEditingController urlInputEditingController;
  TextEditingController testEditingController;

  @override
  rss_addState clone() {
    return rss_addState()
        ..urlString = urlString
        ..testString = testString
        ..urlInputEditingController = urlInputEditingController
        ..testEditingController = testEditingController;
  }
}

rss_addState initState(Map<String, dynamic> args) {

  final rss_addState state = rss_addState();

  state.urlString = "";
  state.testString = "";
  state.urlInputEditingController = TextEditingController(text: state.urlString);
  state.testEditingController = TextEditingController(text: state.testString);

  return state;
}
