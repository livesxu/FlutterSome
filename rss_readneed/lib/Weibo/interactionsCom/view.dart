import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(interactionsComState state, Dispatch dispatch, ViewService viewService) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      IconButton(icon: Icon(Icons.share), onPressed: null),
      IconButton(icon: Icon(Icons.comment), onPressed: null),
      IconButton(icon: Icon(Icons.bubble_chart), onPressed: null),
    ],
  );
}
