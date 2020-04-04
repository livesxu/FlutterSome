import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import '../model.dart';

import 'package:flutter_swiper/flutter_swiper.dart';

Widget buildView(List<ArticleModel> state, Dispatch dispatch, ViewService viewService) {

  ListAdapter adapter = viewService.buildAdapter();
  return Container(
    child: new Swiper(
      itemBuilder: adapter.itemBuilder,
      itemCount: adapter.itemCount,
      itemWidth: 300,
      itemHeight: 200,
      autoplay: true,
      layout: SwiperLayout.STACK,
    ),
  );
}
