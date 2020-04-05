import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import '../model.dart';

import '../../public.dart';
import '../../Info/page.dart';

Widget buildView(InfoModel infoModel, Dispatch dispatch, ViewService viewService) {

  return InkWell(
    onTap: (){
      AppNavigator.push(viewService.context, infoPage().buildPage({}));
    },
    child: Container(child: Text(infoModel.infoName),),
  );
}
