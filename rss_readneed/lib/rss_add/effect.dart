import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

import 'package:flutter/material.dart' hide Action;
import 'package:http/http.dart' as http;

import '../public.dart';
import './expFine/page.dart';
import 'dart:convert';
import 'package:gbk2utf8/gbk2utf8.dart';

import '../Home/model.dart';
import '../Info/page.dart';

//一些副作用 作为
Effect<rss_addState> buildEffect() {
  return combineEffects(<Object, Effect<rss_addState>>{
    Lifecycle.initState:_initState,
    Lifecycle.dispose:_dispose,
    rss_addAction.expChangeAction:_expChangeAction,
    rss_addAction.appendDPointAction:_appendDPointAction,
    rss_addAction.appendGreedyAction:_appendGreedyAction,
    rss_addAction.sureAction:_sureAction,
    rss_addAction.goNextAction:_goNextAction,
  });
}

void _initState(Action action, Context<rss_addState> ctx) {

  //传递过来有值时直接触发确认
  if (ctx.state.urlInputEditingController.text.length > 0) {

    ctx.dispatch(rss_addActionCreator.sureAction());
  }
}

void _dispose(Action action, Context<rss_addState> ctx) {

  ctx.state.urlInputEditingController.dispose();
  ctx.state.expEditingController.dispose();
}

void _expChangeAction(Action action, Context<rss_addState> ctx) {
  //test
//  ctx.state.expEditingController.text = 'rank-item(.*?)href="(.*?)"(.*?)title(.*?)pts';
//  ctx.state.expEditingController.text = '<item>(.*?)</item>';

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
  List<String> validItems = [];
  for (Match m in matches) {

      String match = m.group(0);
      items.add(match);

      if (m.groupCount > 0) {//忽略仅匹配到正则的结果

        validItems.add(match);
      }
  }
  ctx.state.items = items;
  ctx.state.validItems = validItems;

  ctx.dispatch(rss_addActionCreator.refreshAction());

  //如果存在多个有效项，提示创建
  if (ctx.state.validItems.length > 1) {

    ctx.dispatch(rss_addActionCreator.goNextAction());
  }
}

void _appendDPointAction(Action action, Context<rss_addState> ctx){

  ctx.state.expEditingController.text += "\"";

  ctx.dispatch(rss_addActionCreator.refreshAction());
}

void _appendGreedyAction(Action action, Context<rss_addState> ctx){

  if (ctx.state.expEditingController.text.length > 0) {

    ctx.state.expEditingController.text += "(.*?)";

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
  LoadingCommon.show(ctx.context, true);
  //1.获取内容
  http.Response response = await http.get(ctx.state.urlInputEditingController.text,
      headers: {'User-Agent':RequestCommon.randomUserAgent()});
  LoadingCommon.dismiss();
  ErrorHandle.syncError((){

    //转码判断编码类型gbk or utf8
    String body_judge = response.body;
    RegExp exp_meta = RegExp('<meta(.*?)charset(.*?)>');
    Iterable<Match> matches_meta = exp_meta.allMatches(body_judge);
    RegExp exp_encoding = RegExp('encoding="(.*?)"');
    Iterable<Match> matches_encoding = exp_encoding.allMatches(body_judge);

    if ((matches_meta.length > 0 && matches_meta.first.group(0).toLowerCase().contains('gb')) ||
        (matches_encoding.length > 0 && matches_encoding.first.group(0).toLowerCase().contains('gb'))) {

      ctx.state.htmlBody = gbk.decode(response.bodyBytes);
    } else {
      ctx.state.htmlBody = utf8.decode(response.bodyBytes);
    }

  },(){
    Toast.show(ctx.context, '栏目内容转码错误');
    return;
  });

  if (!ctx.state.htmlBody.contains('<?xml') && !ctx.state.htmlBody.contains('<html') && !ctx.state.htmlBody.contains('<rss')) {
    //兼容json数据解析
    ctx.state.htmlBody = jsonDecode(response.body).toString();
  } else {
    ctx.state.htmlBody = ctx.state.htmlBody.replaceAll("\r", "");//将enter符清除
    ctx.state.htmlBody = ctx.state.htmlBody.replaceAll("\n", "");//将换行符清除
    ctx.state.htmlBody = ctx.state.htmlBody.replaceAll(RegExp(r'>(\s*?)<'), '><');//将标签之间的空格清除

    JudgeFeed.judgeRssFeed(ctx.state.urlInputEditingController.text, ctx.state.htmlBody, ctx.context,'checkFeedInAdd');
  }
  
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

//判断Feed
class JudgeFeed {

  //检验是否是rss或者feed订阅
  static void judgeRssFeed(String originalLink,String body,BuildContext ctx,String from) async {

    //顶部正则<item>(.*?)</item>检验
    String topExp = '<item>(.*?)</item>';
    RegExp exp = RegExp(topExp);
    Iterable<Match> matches = exp.allMatches(body);

    //提取每一个item的字符串，即使仅匹配到正则结果也捞出来
    List<String> items = [];
    for (Match m in matches) {

      String match = m.group(0);
      items.add(match);
    }

    //如果数据小于等于1个那就算了
    if (items.length <= 1) {
      //降配匹配到description
      topExp = '<item>(.*?)</description>';
      exp = RegExp(topExp);
      matches = exp.allMatches(body);

      //提取每一个item的字符串，即使仅匹配到正则结果也捞出来
      items = [];
      for (Match m in matches) {

        String match = m.group(0);
        items.add(match);
      }
      if (items.length <= 1) {

        return ;
      }
    }

    String feedInfo;
    if (body.contains('<channel>')) {//主通道

      feedInfo = body.replaceAll(RegExp(r'<item>(.*?)</item>'), '');
      //获取名称
      String feedTitle = '';
      Iterable<Match> titleMatches = RegExp(r'<title>(.*?)</title>').allMatches(feedInfo);
      if (titleMatches.length > 0) {

        feedTitle = titleMatches.first.group(0);
        feedTitle = handleOrCDATA(feedTitle,'<title>(.*?)</title>');
      }

      //获取绝对栏目链接 - 相比infourl更加准确,直接访问网页
      String feedLink = '';
      Iterable<Match> linkMatches = RegExp(r'<link>(.*?)</link>').allMatches(feedInfo);
      if (linkMatches.length > 0) {

        feedLink = linkMatches.first.group(0);
        feedLink = handleOrCDATA(feedLink,'<link>(.*?)</link>');
      }

      //获取图片or链接 - 转换
      String feedUrl = '';
      Iterable<Match> urlMatches = RegExp(r'<url>(.*?)</url>').allMatches(feedInfo);
      if (urlMatches.length > 0) {

        feedUrl = urlMatches.first.group(0);
        feedUrl = handleOrCDATA(feedUrl,'<url>(.*?)</url>');
      }
      String feedImg = '';
      if (feedUrl.endsWith('.jpg') || feedUrl.endsWith('.png') || feedUrl.endsWith('.jpeg')) {

        feedImg = feedUrl;
      } else if (feedLink.length <= 0 && feedUrl.length > 0) {

        feedLink = feedUrl;
      }

      //获取描述
      String feedDesc = '';
      Iterable<Match> descMatches = RegExp(r'<description>(.*?)</description>').allMatches(feedInfo);
      if (descMatches.length > 0) {

        feedDesc = descMatches.first.group(0);
        feedDesc = handleOrCDATA(feedDesc,'<description>(.*?)</description>');
      }

      //拿第一个item做验证
      String exampleItem = items.first;

      print(exampleItem);

      //获取标题exp
      String itemTitleExp = '<title([^<]*?)>(.*?)</title>';
      Iterable<Match> itemTitleMatches = RegExp(itemTitleExp).allMatches(exampleItem);
      if (itemTitleMatches.length > 0) {

        String itemTitle = itemTitleMatches.first.group(0);
        itemTitleExp = expCDATA(itemTitle,itemTitleExp);
      }

      //获取内容exp
      String itemDescExp = '<description([^<]*?)>(.*?)</description>';
      Iterable<Match> itemDescMatches = RegExp(itemDescExp).allMatches(exampleItem);
      String itemDesc = "";
      if (itemDescMatches.length > 0) {

        itemDesc = itemDescMatches.first.group(0);
        itemDescExp = expCDATA(itemDesc,itemDescExp);
      }

      //获取备选内容标签 content:encoded
      String itemDescExp2 = '<content:encoded([^<]*?)>(.*?)</content:encoded>';
      Iterable<Match> itemDescMatches2 = RegExp(itemDescExp2).allMatches(exampleItem);
      String itemDesc2 = "";
      if (itemDescMatches2.length > 0) {

        itemDesc2 = itemDescMatches2.first.group(0);
        itemDescExp2 = expCDATA(itemDesc2,itemDescExp2);
      }
      //如果备选里面的内容更多那就选备选内容
      if (itemDesc2.length > itemDesc.length) {

        itemDescExp = itemDescExp2;
      }

      //获取链接exp
      String itemLinkExp = '<link([^<]*?)>(.*?)</link>';
      Iterable<Match> itemLinkMatches = RegExp(itemLinkExp).allMatches(exampleItem);
      if (itemLinkMatches.length > 0) {

        String itemLink = itemLinkMatches.first.group(0);
        itemLinkExp = expCDATA(itemLink,itemLinkExp);
      }

      //获取图片exp,先查一级里面有没有标签,如果查不到配置通用格式
      String handleItem = exampleItem.replaceAll(RegExp(itemDescExp), '');//去除内容的干扰信息
      handleItem = handleItem.replaceAll(RegExp('<content(.*?)>(.*?)</content(.*?)>'), '');//去除内容的干扰信息

      String itemImgExp = '<([^<]*?)>([^>]*?)(jpg|png|jpeg)(.*?)</(.*?)>';
      Iterable<Match> itemImgMatches = RegExp(itemImgExp).allMatches(handleItem);
      if (itemImgMatches.length > 0) {

        String itemImg = itemImgMatches.first.group(0);//包含有图片的标签
        String itemImgTag = RegExp('<([^/>]*?)>').allMatches(itemImg).first.group(0);
        itemImgTag = itemImgTag.replaceAll("<", "");
        itemImgTag = itemImgTag.replaceAll(">", "");//拿到标签
        itemImgExp = '<' + itemImgTag + '>' + '(.*?)' + '</' + itemImgTag + '>';
        itemImgExp = expCDATA(itemImg,itemImgExp);
      } else {

        itemImgExp = 'img([^>]*?)src="(.*?)"';//此为通用匹配格式，大概率会拿到内容中的img，优先匹配标签中包含的图片资源 - 修改于2020.7.20 原值：<img([^>]*?)src="(.*?)"
      }

      //创建info
      InfoModel infoModel = InfoModel();
      infoModel.infoUrl = originalLink;
      infoModel.abInfoUrl = feedLink;
      infoModel.infoName = feedTitle.length == 0 ? infoModel.infoUrl : feedTitle;
      infoModel.infoImage = feedImg;//图片
      infoModel.infoIntroduce = feedDesc;//介绍
      infoModel.topExp = topExp;

      List<String> titleExps = itemTitleExp.split("(.*?)");
      infoModel.titleExpStart = titleExps.first;
      infoModel.titleExpEnd = titleExps.last;

      List<String> contentExps = itemDescExp.split("(.*?)");
      infoModel.contentExpStart = contentExps.first;
      infoModel.contentExpEnd = contentExps.last;

      List<String> imageExps = itemImgExp.split("(.*?)");
      infoModel.imageExpStart = imageExps.first;
      infoModel.imageExpEnd = imageExps.last;

      List<String> linkExps = itemLinkExp.split("(.*?)");
      infoModel.linkExpStart = linkExps.first;
      infoModel.linkExpEnd = linkExps.last;

      //弹框提示
      Alert.addAlert(Alert(
        title: Alert.commonTitle('栏目订阅'),
        message: Alert.commonMessage(feedTitle + "\n" +
            '链接：'+ originalLink
        ),
        actions: [Alert.commonCancelBtn('取消'),Alert.commonSureBtn('去验证', (){
          Alert.dismiss();

          AppNavigator.push(ctx, infoPage().buildPage({"info":infoModel,'from':from}));
        })],
      ));

      Alert.show(ctx);
    }
  }

//获取可能包含CDATA的内容
  static String handleOrCDATA (String t,String exp) {

    List<String> exps = exp.split("(.*?)");
    String expStart = exps.first;
    String expEnd = exps.last;
    if (t.contains('<![CDATA[')) {

      String startString = RegExp(expStart + '<!\\\[CDATA\\\[').allMatches(t).first.group(0);
      String endString = RegExp('\\\]\\\]>' + expEnd).allMatches(t).last.group(0);

      return t.substring(startString.length,t.length - endString.length);
    } else {

      String startString = RegExp(expStart).allMatches(t).first.group(0);
      String endString = RegExp(expEnd).allMatches(t).last.group(0);

      return t.substring(startString.length,t.length - endString.length);
    }
  }

//获取可能包含CDATA的正则
  static String expCDATA (String t,String exp) {

    if (t.contains('<![CDATA[')) {

      List<String> exps = exp.split("(.*?)");
      String expStart = exps.first;
      String expEnd = exps.last;

      return expStart + '<!\\\[CDATA\\\[' + '(.*?)' + '\\\]\\\]>' + expEnd;
    }
    return exp;
  }
}
