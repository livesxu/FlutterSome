import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(contentComState state, Dispatch dispatch, ViewService viewService) {
  return Column(
    children: <Widget>[
      viewService.buildComponent("user"),
      viewService.buildComponent("texts"),
      viewService.buildComponent("images"),
      viewService.buildComponent("interactions"),
    ],
  );
}
