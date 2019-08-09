import 'package:fish_redux/fish_redux.dart';
import 'package:rss_readneed/punch_card/punchCardModel.dart';
import 'package:flutter/material.dart';

class punch_cardState implements Cloneable<punch_cardState> {

  bool isToday = true;//是否当天
  bool isChange = false;//是否确定是修改进入

  PunchCardModel model = PunchCardModel(todayThings: [],tomorrowThings: []);

  //滑动控制
  ScrollController scrollController = ScrollController();

  //当天事情输入控制
  TextEditingController controller = TextEditingController();

  //明天(未来)事情输入控制
  List<TextEditingController> tomorrowControllers = [];

  @override
  punch_cardState clone() {
    return punch_cardState()
            ..isToday = isToday
            ..isChange = isChange
            ..model = model
            ..controller = controller
            ..tomorrowControllers = tomorrowControllers;
  }
}

punch_cardState initState(Map<String, dynamic> args) {

  final newState = punch_cardState();

  newState.model = args["model"];

  DateTime dateTime = PunchCardModel().todayDateTime();
  
  String dateString = PunchCardModel().dateTimeString(dateTime);

  if (args["model"] == null) {//无传递数据过来 - 检查是否有存储的相关数据 - 有：赋值 无：创建

    //无model传入则，先赋值默认数据，定义为当天
    newState.isToday = true;

    newState.model = PunchCardModel().initModelWith(dateTime);

    //然后用当天做匹配，万一存储的数据里面有则应该展示,数据更改和查询放在effect

  } else {//传递数据过来

    PunchCardModel model = args["model"];

    if (model.dateTime == dateString) {//如果传递过来的天跟今天一样，那就是今天，可以刷新更新时间

      newState.isToday = true;
      newState.isChange = true;
    } else {

      newState.isToday = false;
    }
  }
  newState.controller.text = newState.model.workingThings;

  for (int i = 0; i < newState.model.tomorrowThings.length; i++){

    TextEditingController controller = TextEditingController(text: newState.model.tomorrowThings[i]);

    newState.tomorrowControllers.add(controller);
  }

  if (newState.model.tomorrowThings.length < 5 && newState.isToday) {

    //突出的一条添加，最多可填5条
    TextEditingController controller = TextEditingController(text: "");
    newState.tomorrowControllers.add(controller);
  }

  return newState;
}
