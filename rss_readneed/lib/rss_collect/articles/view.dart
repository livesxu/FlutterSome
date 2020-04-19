import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import '../../public.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

//作为ListView中的模块需要限定高度
Widget buildView(List<ArticleModel> state, Dispatch dispatch, ViewService viewService) {

  ListAdapter adapter = viewService.buildAdapter();

  return Container(
    height: 300,
    padding: EdgeInsets.all(4),
    child: StaggeredGridView.countBuilder(
      scrollDirection: Axis.horizontal,
      crossAxisCount: 2,
      itemBuilder: adapter.itemBuilder,
      itemCount: adapter.itemCount,
      staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
      mainAxisSpacing: 2.0,
      crossAxisSpacing: 2.0,
    ),
  );
}