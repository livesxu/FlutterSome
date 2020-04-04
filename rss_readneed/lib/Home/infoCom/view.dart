import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import '../model.dart';

Widget buildView(InfoModel infoModel, Dispatch dispatch, ViewService viewService) {

  return Container(child: Text(infoModel.infoName),);
}
