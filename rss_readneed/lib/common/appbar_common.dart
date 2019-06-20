import 'package:flutter/material.dart';
import 'package:rss_readneed/common/appbar_gradient.dart';
/*统一appbar展示*/
class AppbarCommon extends GradientAppBar {

  String titleString;
  BuildContext ctx;
  List<Widget> actions;

  AppbarCommon({
    @required this.ctx,
    this.titleString,
    this.actions,
  }):
        super (title:Text(titleString),
        actions:actions,
        shadowColor: Theme.of(ctx).primaryColor,
        gradient: RadialGradient(//更改为圆扩散
            colors: [Theme.of(ctx).primaryColorLight,Theme.of(ctx).primaryColorDark],
            center: Alignment.topLeft,
            radius: 4),
      ){assert(ctx != null);}
}