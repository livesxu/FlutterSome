import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import '../public.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(rss_addState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: AppbarCommon(
      titleString: 'Add', ctx: viewService.context
    ),
    body: Container(
      padding: EdgeInsets.only(left: 20,top: 20,right: 20),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(//扩充区域部件 good
                child: TextField(
                  controller: state.urlInputEditingController,
                  decoration: InputDecoration(
                    labelText: "Url",
                    helperText: 'eg:Http://www.uisdc.com/feed',
                    hintText: "Input Rss Link",
                  ),
                ),
              ),
              SizedBox(width: 20,),
              Container(
                width:100,
                height: 30,
                child: RaisedButton(
                  child: Text("确定"),
                  onPressed: () => dispatch(rss_addActionCreator.sureAction()),
                ),
              ),
            ],
          ),
          TextField(
            controller: state.testEditingController,
            decoration: InputDecoration(
              labelText: "Test".toUpperCase(),
              hintText: "Test Rss Link Info Something...",
            ),
          ),
        ],
      )
    ),
  );
}
