import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

import '../public.dart';
import 'package:http/http.dart' as http;

Effect<infoState> buildEffect() {
  return combineEffects(<Object, Effect<infoState>>{
    Lifecycle.initState:_initState,
    infoAction.action: _onAction,
  });
}

void _initState(Action action, Context<infoState> ctx) async {

  http.Response response = await http.get('https://www.bilibili.com/ranking',
  headers: {'User-Agent':'Mozilla/5.0 (Windows NT 6.1; WOW64)AppleWebKit/535.1 (KHTML, like Gecko) Chrome/14.0.835.163 Safari/535.1'});

  print(response.body);
  RegExp exp = RegExp(r'rank-item(.*?)href="(.*?)"(.*?)title(.*?)pts');
  Iterable<Match> matches = exp.allMatches(response.body);

  int count = 0;
  List<String> items = [];
  for (Match m in matches) {

    if (m.groupCount > 0) {
      String match = m.group(0);
      items.add(match);
      print(match);
      count ++;
    }

  }
  Map<String,String> item = {};
  for (String str in items) {
      String title = itemExp(str, '"title">', '</a>');
      String content = '';
      String image = '';
      String link = itemExp(str, '<a href="', ' target="_blank">');

  }

  print('count' + count.toString());
}

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

void _onAction(Action action, Context<infoState> ctx) {
}
