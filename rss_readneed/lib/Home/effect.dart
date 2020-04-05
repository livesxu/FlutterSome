import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';
import '../public.dart';
import 'model.dart';

Effect<homeState> buildEffect() {
  return combineEffects(<Object, Effect<homeState>>{

    Lifecycle.initState:_initState,
    //    homeAction.action: _onAction,
  });
}

void _initState(Action action, Context<homeState> ctx) async {

//  _requestTodays(ctx);

  _requestInfos(ctx);
}

void _requestTodays (Context<homeState> ctx) async {

  //  今日榜单
  ResuestResult resultTodays = await RequestCommon.Get('/info/10');
  
  List todaysdatas = resultTodays.body["articles"];
  ctx.state.todayThings = todaysdatas.map((obj) => ArticleModel.fromJson(obj)).toList();

  ctx.dispatch(homeActionCreator.onAction());
}

void _requestInfos (Context<homeState> ctx) async {

  //栏目推荐 - 目前是所有栏目
  ResuestResult result = await RequestCommon.Get('/info');

  List datas = result.body;
  ctx.state.infos = datas.map((obj) => InfoModel.fromJson(obj)).toList();

  ctx.dispatch(homeActionCreator.onAction());
}