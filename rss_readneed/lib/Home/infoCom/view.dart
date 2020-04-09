import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import '../model.dart';

import '../../public.dart';
import '../../Info/page.dart';

Widget buildView(InfoModel infoModel, Dispatch dispatch, ViewService viewService) {

  return InkWell(
    onTap: (){
      AppNavigator.push(viewService.context, infoPage().buildPage({"info":infoModel}));
    },
    child: ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: Container(
          width: 40,
          height: 40,
          color: Colors.white,
          child: ImageCommon.withUrl(infoModel.infoImage, "images_assets/icon.png", null),
        ),
      ),
      title: Text(infoModel.infoName),
      subtitle: Text(infoModel.infoIntroduce),
    )
  );
}
