import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

import 'package:rss_readneed/public.dart';
import 'package:rss_readneed/punch_card/punchCardModel.dart';
import 'package:rss_readneed/punch_card/page.dart' as punchCard;
import 'package:flutter/gestures.dart';

Widget buildView(punch_card_listState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: AppbarCommon(ctx: viewService.context,titleString: "月度列表",isNeedBack: true,),
    body: ListView.builder(
        itemCount: state.monthList.length,
        itemBuilder: (ctx,i){
          
          PunchCardModel model = state.monthList[i];

          int difHour = DateTime.parse(model.finishTime).difference(DateTime.parse(model.dateTime + state.model.finishTime.substring(10))).inHours;

          Color timeColor = Colors.black45;
          if (difHour <= 0) {//0-1准点下班

            timeColor = Colors.black45;
          } else if (difHour <= 2) {//2-3小时，还可以

            timeColor = Colors.green;
          } else if (difHour <= 4) {//4-5小时，黄线

            timeColor = Colors.yellow;
          } else if (difHour <= 5) {//5-6小时，红线

            timeColor = Colors.red;
          } else {//>6小时，死亡芭比粉~

            timeColor = Colors.pink;
          }

          return PunchCardListCell(
            model: model,
            timeColor: timeColor,
            checkCallBack: (){ dispatch(punch_card_listActionCreator.changeCheckAction(model));/*更改是否统计*/ },
            timeCallBack: (){ dispatch(punch_card_listActionCreator.changeTimeAction(model)); },
          );
        }),
  );
}

class PunchCardListCell extends StatefulWidget {

  final PunchCardModel model;
  final Color timeColor;
  final VoidCallback checkCallBack;
  final VoidCallback timeCallBack;

  PunchCardListCell({
    this.model,
    this.timeColor,
    this.checkCallBack,
    this.timeCallBack,
  });

  @override
  PunchCardListCellState createState() => new PunchCardListCellState();
}

class PunchCardListCellState extends State<PunchCardListCell> {

  TapGestureRecognizer _tapGestureRecognizer = new TapGestureRecognizer();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: Checkbox(value: widget.model.inCount, onChanged: (incount){ widget.checkCallBack();/*更改是否统计*/},),
      title: RichText(text: TextSpan(
        text: widget.model.dateTime.substring(8,10) + "  ",//加上间隔
        style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w600),
        children: [
          TextSpan(text:(widget.model.finishTime.contains(widget.model.dateTime) ? widget.model.finishTime.substring(11,16) : widget.model.finishTime),
              style: TextStyle(color: widget.timeColor,fontSize: 24,fontWeight: FontWeight.w300),
              recognizer: _tapGestureRecognizer
                                        ..onTap = widget.timeCallBack,
          )
        ],
      )),
      subtitle: Text(widget.model.workingThings),
//            onTap: (){ AppNavigator.push(ctx, punchCard.punch_cardPage().buildPage({"model":model}));},//删除跳转,更改为对时间添加点击事件切换时间
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(PunchCardListCell oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}
