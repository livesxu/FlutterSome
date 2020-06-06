import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(contentComState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    height: 200,
    child: Column(
      children: <Widget>[
        viewService.buildComponent("user"),
        Text(state.contentModel.text),
      ],
    )
  );
}
