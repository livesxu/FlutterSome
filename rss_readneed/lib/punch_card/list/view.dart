import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

import 'package:rss_readneed/public.dart';

Widget buildView(punch_card_listState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: AppbarCommon(ctx: viewService.context,titleString: "传送门",isNeedBack: true,),
    body: Container(),
  );
}
