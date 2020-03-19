import 'package:fish_redux/fish_redux.dart';
import 'package:fish_redux/src/redux/basic.dart' as fish;
import 'action.dart';
import 'state.dart';

import 'package:flutter/material.dart';

//一些副作用 作为
Effect<rss_addState> buildEffect() {
  return combineEffects(<Object, Effect<rss_addState>>{
    Lifecycle.initState:_init,//初始
    Lifecycle.dispose:_dispose,
    rss_addAction.sureAction:_sureAction,
  });
}

void _init(fish.Action action, Context<rss_addState> ctx) {

  ctx.state.urlInputEditingController.addListener((){

    ctx.dispatch(
      rss_addActionCreator.urlAction(ctx.state.urlInputEditingController.text)
    );
  });

  ctx.state.testEditingController.addListener((){

    ctx.dispatch(
        rss_addActionCreator.testAction(ctx.state.testEditingController.text)
    );
  });
}

void _dispose(fish.Action action, Context<rss_addState> ctx) {

  ctx.state.urlInputEditingController.dispose();
  ctx.state.testEditingController.dispose();
}

void _sureAction(fish.Action action, Context<rss_addState> ctx) {

  Navigator.of(ctx.context).pop();
}

