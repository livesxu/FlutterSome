import 'package:fish_redux/fish_redux.dart';

import 'package:flutter/material.dart';

class expFineState implements Cloneable<expFineState> {

  String url;
  String exp;
  List<String> examples;

  TextEditingController nameEditingController;
  TextEditingController titleEditingController;
  TextEditingController contentEditingController;
  TextEditingController imageEditingController;
  TextEditingController linkEditingController;

  int focusIndex;

  String syncTitle = '';
  String syncContent = '';
  String syncImage = '';
  String syncLink = '';

  @override
  expFineState clone() {
    return expFineState()
      ..url = url
      ..exp = exp
      ..examples = examples
      ..nameEditingController = nameEditingController
      ..titleEditingController = titleEditingController
      ..contentEditingController = contentEditingController
      ..imageEditingController = imageEditingController
      ..linkEditingController = linkEditingController
      ..focusIndex = focusIndex
      ..syncTitle = syncTitle
      ..syncContent = syncContent
      ..syncImage = syncImage
      ..syncLink = syncLink
    ;
  }
}

expFineState initState(Map<String, dynamic> args) {

  return expFineState()
    ..url = args['url']
    ..exp = args['exp']
    ..examples = args['examples']
    ..nameEditingController = TextEditingController()
    ..titleEditingController = TextEditingController()
    ..contentEditingController = TextEditingController()
    ..imageEditingController = TextEditingController()
    ..linkEditingController = TextEditingController()
  ;
}
