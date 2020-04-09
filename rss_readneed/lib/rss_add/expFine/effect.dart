import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

import '../../public.dart';
import '../../Home/model.dart';
import '../../Info/page.dart';

Effect<expFineState> buildEffect() {
  return combineEffects(<Object, Effect<expFineState>>{
    expFineAction.focusAction: _focusAction,
    expFineAction.appendDPointAction:_appendDPointAction,
    expFineAction.appendGreedyAction:_appendGreedyAction,
    expFineAction.syncAction:_syncAction,
    expFineAction.analysisAction:_analysisAction,
    Lifecycle.dispose:_dispose,
  });
}

void _focusAction(Action action, Context<expFineState> ctx) {

  int focusIndex = action.payload;

  ctx.state.focusIndex = focusIndex;

}

void _appendDPointAction(Action action, Context<expFineState> ctx) {

  if (ctx.state.focusIndex != null) {

    switch (ctx.state.focusIndex) {
      case 1:
        ctx.state.titleEditingController.text += "\"";
        break;
      case 2:
        ctx.state.contentEditingController.text += "\"";
        break;
      case 3:
        ctx.state.imageEditingController.text += "\"";
        break;
      case 4:
        ctx.state.linkEditingController.text += "\"";
        break;
      default:
        return;
    }
    ctx.dispatch(expFineActionCreator.refreshAction());
  }
}

void _appendGreedyAction(Action action, Context<expFineState> ctx) {

  if (ctx.state.focusIndex != null) {

    switch (ctx.state.focusIndex) {
      case 1:
        ctx.state.titleEditingController.text += "(.*?)";
        break;
      case 2:
        ctx.state.contentEditingController.text += "(.*?)";
        break;
      case 3:
        ctx.state.imageEditingController.text += "(.*?)";
        break;
      case 4:
        ctx.state.linkEditingController.text += "(.*?)";
        break;
      default:
        return;
    }
    ctx.dispatch(expFineActionCreator.refreshAction());
  }
}

void _syncAction(Action action, Context<expFineState> ctx) {

  int suncIndex = action.payload;

  String item = ctx.state.examples.first;

  List<String> exps = [];

  switch (suncIndex) {
    case 1:

      exps = ctx.state.titleEditingController.text.split("(.*?)");

      if (judgeExp(exps) == false){ Toast.show(ctx.context, "当前匹配必须有且仅有一个(.*?)"); return; };

      String title = itemExp(item, exps.first, exps.last);
      ctx.state.syncTitle = title;
      break;
    case 2:

      exps = ctx.state.contentEditingController.text.split("(.*?)");

      if (judgeExp(exps) == false){ Toast.show(ctx.context, "当前匹配必须有且仅有一个(.*?)"); return; };

      String content = itemExp(item, exps.first, exps.last);
      ctx.state.syncContent = content;
      break;
    case 3:

      exps = ctx.state.imageEditingController.text.split("(.*?)");

      if (judgeExp(exps) == false){ Toast.show(ctx.context, "当前匹配必须有且仅有一个(.*?)"); return; };

      String image = itemExp(item, exps.first, exps.last);
      ctx.state.syncImage = image;
      break;
    case 4:

      exps = ctx.state.linkEditingController.text.split("(.*?)");

      if (judgeExp(exps) == false){ Toast.show(ctx.context, "当前匹配必须有且仅有一个(.*?)"); return; };

      String link = itemExp(item, exps.first, exps.last);
      ctx.state.syncLink = link;
      break;
    default:
      return;
  }

  ctx.dispatch(expFineActionCreator.refreshAction());
}

bool judgeExp(List<String> exps) {

  if (exps.length == 2) {

    return true;
  } else {

    return false;
  }
}

//同info effect
String itemExp(String matchString,String start,String end){

  RegExp exp = RegExp(start + "(.*?)" + end);
  Iterable<Match> matches = exp.allMatches(matchString);

  if (matches.length > 0) {
    Match match = matches.first;
    if (match.groupCount > 0) {

      String str = match.group(0);

      return str.substring(start.length,str.length - end.length);
    }
  }
  return '';
}

void _analysisAction(Action action, Context<expFineState> ctx) async {

  if (ctx.state.nameEditingController.text.length <= 0) {

    Toast.show(ctx.context, '栏目名称必须填写哦~');
    return ;
  }

  InfoModel infoModel = InfoModel();
  infoModel.infoName = ctx.state.nameEditingController.text;
  infoModel.infoUrl = ctx.state.url;
//  String infoImage;//图片
//  String infoIntroduce;//介绍
  infoModel.topExp = ctx.state.exp;

  List<String> titleExps = ctx.state.titleEditingController.text.split("(.*?)");
  if (judgeExp(titleExps)) {

    infoModel.titleExpStart = titleExps.first;
    infoModel.titleExpEnd = titleExps.last;
  }

  List<String> contentExps = ctx.state.contentEditingController.text.split("(.*?)");
  if (judgeExp(contentExps)) {

    infoModel.contentExpStart = contentExps.first;
    infoModel.contentExpEnd = contentExps.last;
  }

  List<String> imageExps = ctx.state.imageEditingController.text.split("(.*?)");
  if (judgeExp(imageExps)) {

    infoModel.imageExpStart = imageExps.first;
    infoModel.imageExpEnd = imageExps.last;
  }

  List<String> linkExps = ctx.state.linkEditingController.text.split("(.*?)");
  if (judgeExp(linkExps)) {

    infoModel.linkExpStart = linkExps.first;
    infoModel.linkExpEnd = linkExps.last;
  }

  AppNavigator.push(ctx.context, infoPage().buildPage({"info":infoModel,'from':'check'}));
}

void _dispose(Action action, Context<expFineState> ctx) {

  ctx.state.nameEditingController.dispose();
  ctx.state.titleEditingController.dispose();
  ctx.state.contentEditingController.dispose();
  ctx.state.imageEditingController.dispose();
  ctx.state.linkEditingController.dispose();
}


