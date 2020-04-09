import 'package:fish_redux/fish_redux.dart';

import 'package:flutter/material.dart';

//初始state - 属性，初始数据==
class rss_addState implements Cloneable<rss_addState> {

  String urlString;
  String expString;
  TextEditingController urlInputEditingController;
  TextEditingController expEditingController;

  String htmlBody = '';
  List<String> items = [];

  var sKey = GlobalKey<ScaffoldState>();

  @override
  rss_addState clone() {
    return rss_addState()
        ..urlString = urlString
        ..expString = expString
        ..urlInputEditingController = urlInputEditingController
        ..expEditingController = expEditingController
        ..htmlBody = htmlBody
        ..items = items
        ..sKey = sKey;
  }
}

rss_addState initState(Map<String, dynamic> args) {

  final rss_addState state = rss_addState();

  state.urlString = "";
  state.expString = "";
  state.urlInputEditingController = TextEditingController(text: state.urlString);
  state.expEditingController = TextEditingController(text: state.expString);

  return state;
}
