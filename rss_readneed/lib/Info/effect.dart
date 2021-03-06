import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

import '../Home/model.dart';
import '../public.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:gbk2utf8/gbk2utf8.dart';
import 'package:flutter/material.dart' hide Action;

Effect<infoState> buildEffect() {
  return combineEffects(<Object, Effect<infoState>>{
    Lifecycle.initState:_initState,
    infoAction.checkSureInfo:_checkSureInfo,
  });
}

void _initState(Action action, Context<infoState> ctx) async {

  LoadingCommon.show(ctx.context, true);
//  1.本地链路/主正则 -
  if (ctx.state.infoModel.topExp != null && ctx.state.infoModel.topExp.length > 0) {

    http.Response response = await http.get(ctx.state.infoModel.infoUrl,
        headers: {'User-Agent':RequestCommon.randomUserAgent()});

    //转码判断编码类型gbk or utf8
    String body_judge = response.body;
    RegExp exp_meta = RegExp('<meta(.*?)charset(.*?)>');
    Iterable<Match> matches_meta = exp_meta.allMatches(body_judge);
    RegExp exp_encoding = RegExp('encoding="(.*?)"');
    Iterable<Match> matches_encoding = exp_encoding.allMatches(body_judge);

    String responseString = '';
    if ((matches_meta.length > 0 && matches_meta.first.group(0).toLowerCase().contains('gb')) ||
        (matches_encoding.length > 0 && matches_encoding.first.group(0).toLowerCase().contains('gb'))) {

      responseString = gbk.decode(response.bodyBytes);
    } else {
      responseString = utf8.decode(response.bodyBytes);
    }

    if (!responseString.contains('<?xml') && !responseString.contains('<html') && !responseString.contains('<rss')) {

      ctx.state.isJsonR = true;
      //兼容json数据解析
      responseString = jsonDecode(responseString).toString();
    } else {
      responseString = responseString.replaceAll("\r", "");//将enter符清除
      responseString = responseString.replaceAll("\n", "");//将换行符清除
      responseString = responseString.replaceAll(RegExp(r'>(\s*?)<'), '><');//将标签之间的空格清除
    }
//    print(response.body);
    RegExp exp = RegExp(ctx.state.infoModel.topExp);
    Iterable<Match> matches = exp.allMatches(responseString);

    //提取每一个item的字符串
    List<String> items = [];
    for (Match m in matches) {

      if (m.groupCount > 0) {//忽略仅匹配到正则的结果
        String match = m.group(0);
        items.add(match);
      }
    }

    bool titleExp = (ctx.state.infoModel.titleExpStart != null && ctx.state.infoModel.titleExpStart.length > 0 &&
        ctx.state.infoModel.titleExpEnd != null && ctx.state.infoModel.titleExpEnd.length > 0);
    bool contentExp = (ctx.state.infoModel.contentExpStart != null && ctx.state.infoModel.contentExpStart.length > 0 &&
        ctx.state.infoModel.contentExpEnd != null && ctx.state.infoModel.contentExpEnd.length > 0);
    bool imageExp = (ctx.state.infoModel.imageExpStart != null && ctx.state.infoModel.imageExpStart.length > 0 &&
        ctx.state.infoModel.imageExpEnd != null && ctx.state.infoModel.imageExpEnd.length > 0);
    bool linkExp = (ctx.state.infoModel.linkExpStart != null && ctx.state.infoModel.linkExpStart.length > 0 &&
        ctx.state.infoModel.linkExpEnd != null && ctx.state.infoModel.linkExpEnd.length > 0);

    String lastItemImg = '';
    ctx.state.articles = items.map((String itemString){

      ArticleModel amodel = ArticleModel();
      amodel.articleTitle = titleExp ? itemExp(itemString, ctx.state.infoModel.titleExpStart, ctx.state.infoModel.titleExpEnd) : '';

      //使用web的方式加载html效果并不好,所以隐藏
//      amodel.webContent = contentExp ? itemExp(itemString, ctx.state.infoModel.contentExpStart, ctx.state.infoModel.contentExpEnd) : '';

      amodel.articleContent = contentExp ? itemExp(itemString, ctx.state.infoModel.contentExpStart, ctx.state.infoModel.contentExpEnd) : '';
      amodel.articleContent = amodel.articleContent.replaceAll(RegExp(r'<(.*?)>'), '');//将内容里面的标签全部去除展示
      amodel.articleContent = amodel.articleContent.replaceAll(RegExp(r'&([0-9a-z]{2,6});'), '');//去除常用转义符
      amodel.articleContent = amodel.articleContent.replaceAll(RegExp(r'&#([0-9]{2,4});'), '');//去除常用转义符

      //todo:评估是否需要添加标签来区别于重度过滤
      amodel.articleContent = amodel.articleContent.replaceAll(RegExp(r'img src="(.*?)"'), '');//去除图片标签 - 去除示例：知乎精选
      amodel.articleContent = amodel.articleContent.replaceAll(RegExp(r' ([a-z][\S]{1,})="(.*?)"'), '');//去除标签 - 去除示例：知乎精选
      amodel.articleContent = amodel.articleContent.replaceAll(RegExp(r'/{1,2}([a-z]{1,})'), '');//去除虚假标签 - 去除示例：知乎精选

      amodel.articleContent = amodel.articleContent.length > 1000 ? (amodel.articleContent.substring(0,500) + '...') : amodel.articleContent;


      amodel.articleImage = imageExp ? itemExp(itemString, ctx.state.infoModel.imageExpStart, ctx.state.infoModel.imageExpEnd) : '';
      amodel.articleImage = amodel.articleImage.replaceAll(" ", '');//把内部空格去除
      if (amodel.articleImage == lastItemImg) {//防止抓到一些样式图，都是样式图则只展示第一个
        amodel.articleImage = '';
      } else {
        lastItemImg = amodel.articleImage;
      }

      amodel.articleUrl = linkExp ? itemExp(itemString, ctx.state.infoModel.linkExpStart, ctx.state.infoModel.linkExpEnd) : '';

      return amodel;

    }).toList();

    ctx.dispatch(infoActionCreator.fetchAction());

  } else {//2.本地链路有问题，a.上报 todo b.请求数据

    ResuestResult result = await RequestCommon.Get('/info/' + ctx.state.infoModel.infoId.toString());

    List datas = result.body["articles"];
    ctx.state.articles = datas.map((obj) => ArticleModel.fromJson(obj)).toList();

    ctx.dispatch(infoActionCreator.fetchAction());
  }

  LoadingCommon.dismiss();

}

String itemExp(String matchString,String start,String end){

  RegExp exp = RegExp(start + "(.*?)" + end);
  Iterable<Match> matches = exp.allMatches(matchString);

  if (matches.length > 0) {
    Match match = matches.first;
    if (match.groupCount > 0) {

      String str = match.group(0);

      String startString = RegExp(start).allMatches(str).first.group(0);
      String endString = RegExp(end).allMatches(str).last.group(0);

      return str.substring(startString.length,str.length - endString.length);
    }
  }
  return '';
}

void _checkSureInfo(Action action, Context<infoState> ctx) async {
  
  ResuestResult result = await RequestCommon.Post('/info', ctx.state.infoModel);

  if (result.success) {

    Toast.show(ctx.context, '栏目创建成功');


    if (ctx.state.flag == 'checkFeedInWeb') {//web自动直接解析

      Navigator.of(ctx.context)
        ..pop();

    } else if (ctx.state.flag == 'checkFeedInAdd') {//checkFeed自动解析，所以少一层结构

      Navigator.of(ctx.context)
        ..pop()
        ..pop();
    } else {

      Navigator.of(ctx.context)
        ..pop()
        ..pop()
        ..pop();
    }
  }
}
