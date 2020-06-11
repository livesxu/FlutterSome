import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:rss_readneed/common/consts.dart';
import 'package:rss_readneed/common/image_common.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(imagesComState state, Dispatch dispatch, ViewService viewService) {

  int more = state.imageUrls.length%3;
  int line = ((state.imageUrls.length - more)/3 + (more > 0 ? 1 : 0)).toInt();

  double containHeight = ((Consts.screenWidth -40)/3 + 10) * line + 10;

  return Container(
    height: containHeight,
    child: GridView.count(crossAxisCount: 3,
      physics: NeverScrollableScrollPhysics(),//禁止内部滚动
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      padding: EdgeInsets.all(10),
      children: state.imageUrls.map((imageUrl)=>ImageCommon.withUrl(imageUrl, null, null)).toList(),
    ),
  );
}
