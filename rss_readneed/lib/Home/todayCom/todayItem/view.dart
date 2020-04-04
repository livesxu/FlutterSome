import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import '../../model.dart';

Widget buildView(ArticleModel model, Dispatch dispatch, ViewService viewService) {

  return Container(child: Text(model.articleTitle),color: Color.fromARGB(100, 100, 100, 100),);
}
