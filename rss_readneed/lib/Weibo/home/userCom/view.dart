import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(userComState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    height: 100,
    child: Text((state.accountModel == null || state.accountModel.screen_name == null) ? "" : state.accountModel.screen_name),
  );
}
