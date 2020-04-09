import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

import 'package:flutter/material.dart' hide Action;
import 'package:http/http.dart' as http;

import '../public.dart';
import './expFine/page.dart';

//一些副作用 作为
Effect<rss_addState> buildEffect() {
  return combineEffects(<Object, Effect<rss_addState>>{
    Lifecycle.dispose:_dispose,
    rss_addAction.expChangeAction:_expChangeAction,
    rss_addAction.appendGreedyAction:_appendGreedyAction,
    rss_addAction.sureAction:_sureAction,
    rss_addAction.goNextAction:_goNextAction,
  });
}

void _dispose(Action action, Context<rss_addState> ctx) {

  ctx.state.urlInputEditingController.dispose();
  ctx.state.expEditingController.dispose();
}

void _expChangeAction(Action action, Context<rss_addState> ctx) {
  //test
//  ctx.state.expEditingController.text = 'rank-item(.*?)href="(.*?)"(.*?)title(.*?)pts';

  if (ctx.state.urlInputEditingController.text.length <= 0) {

    Toast.show(ctx.context, '请输入需要跟踪的网站或者链接');
    return ;
  }

  if (ctx.state.htmlBody.length <= 0) {

    Toast.show(ctx.context, '未获取到链接内容,请重试');
    return ;
  }

  if (ctx.state.expEditingController.text.endsWith("(.*?)")) {

    Toast.show(ctx.context, '非贪婪匹配不能用于起始或者结束');

    return ;
  }

  //当正则改变时，匹配内容刷新
  //2.顶部正则
  RegExp exp = RegExp(ctx.state.expEditingController.text);
  Iterable<Match> matches = exp.allMatches(ctx.state.htmlBody);

  //提取每一个item的字符串，即使仅匹配到正则结果也捞出来
  List<String> items = [];
  for (Match m in matches) {

      String match = m.group(0);
      items.add(match);
  }
  ctx.state.items = items;

  ctx.dispatch(rss_addActionCreator.refreshAction());
}

void _appendGreedyAction(Action action, Context<rss_addState> ctx){

  if (ctx.state.expEditingController.text.length > 0) {

    ctx.state.expEditingController.text = ctx.state.expEditingController.text + "(.*?)";

    ctx.dispatch(rss_addActionCreator.refreshAction());
  } else {

    Toast.show(ctx.context, '非贪婪匹配不能用于起始或者结束');
  }
}

void _sureAction(Action action, Context<rss_addState> ctx) async {

  //test
//  ctx.state.urlInputEditingController.text = 'https://www.bilibili.com/ranking';

  if (ctx.state.urlInputEditingController.text.length <= 0) {

    Toast.show(ctx.context, '请输入需要跟踪的网站或者链接');
    return ;
  }

  //1.获取内容
  http.Response response = await http.get(ctx.state.urlInputEditingController.text,
      headers: {'User-Agent':'Mozilla/5.0 (Windows NT 6.1; WOW64)AppleWebKit/535.1 (KHTML, like Gecko) Chrome/14.0.835.163 Safari/535.1'});

  ctx.state.htmlBody = response.body;

  ctx.state.expEditingController.text = '';
  ctx.state.items = [];

  ctx.dispatch(rss_addActionCreator.refreshAction());

}

void _goNextAction(Action action, Context<rss_addState> ctx) async {

  int t = 0;
  List<String> examples = [];
  for (String item in ctx.state.items) {

    if (t < 3) {
      examples.add(item);
      t ++ ;
    } else {
      break;
    }
  }

  //todo 展示结果不明确，展示框待优化
  Alert.addAlert(Alert(
    title: Alert.commonTitle('栏目订阅'),
    message: Alert.commonMessage('链接：'+ ctx.state.urlInputEditingController.text + "\n" +
        '正则：'+ ctx.state.expEditingController.text),
    customView: Container(
      height: 300,
      child: ListView(
        children: <Widget>[
          Text(ctx.state.items.first,style: TextStyle(fontSize: 12,color: Colors.black54,decoration: TextDecoration.none,))
        ],
      ),
    ),
    actions: [Alert.commonCancelBtn('取消'),Alert.commonSureBtn('确定', (){
      Alert.dismiss();

      AppNavigator.push(ctx.context, expFinePage().buildPage({
        'url':ctx.state.urlInputEditingController.text,
        'exp':ctx.state.expEditingController.text,
        'examples':examples
      }));
    })],
  ));

  Alert.show(ctx.context);
}

